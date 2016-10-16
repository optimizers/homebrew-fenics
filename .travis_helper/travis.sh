#!/bin/bash
# Credits: http://stackoverflow.com/a/26082445/756986
set -e

export PING_SLEEP=60s
export WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export BUILD_OUTPUT=$WORKDIR/build.out

touch $BUILD_OUTPUT

dump_output() {
   echo "############# Build log(last 1Mb) start #############"
   tail -b 1024 $BUILD_OUTPUT
   echo "############# Build log end #########################"
}
cleanup() {
  dump_output
  kill -9 $PING_LOOP_PID
}
error_handler() {
  echo ERROR: An error was encountered during the build.
  cleanup
  exit 1
}
trap error_handler ERR SIGHUP SIGINT SIGTERM

# Set up a repeating loop to send some output to Travis.
( echo working; while true; do echo -n ...; sleep $PING_SLEEP; done; echo; ) &
PING_LOOP_PID=$!
echo "\e[33m[ping loop pid] $PING_LOOP_PID\e[0m"

# Dump output of building dependencies to log file
echo "\e[33m[$@ > $BUILD_OUTPUT]\e[0m"
$@ >> $BUILD_OUTPUT 2>&1

# The build was successful. Clean up.
cleanup

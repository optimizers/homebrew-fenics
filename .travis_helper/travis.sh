#!/bin/bash
# Credits: http://stackoverflow.com/a/26082445/756986
set -e

export PING_SLEEP=10s
export WORKDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export BUILD_OUTPUT=$WORKDIR/build.out

touch $BUILD_OUTPUT

dump_output() {
   echo "############# Build log(last 1Mb) start #############"
   tail --bytes=1024 $BUILD_OUTPUT
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
( while true; do echo working ...; sleep $PING_SLEEP; done ) &
PING_LOOP_PID=$!
echo "pid: $PING_LOOP_PID"

# Dump output of building dependencies to log file
echo "executing: $@"
$@ >> $BUILD_OUTPUT 2>&1

# The build was successful. Clean up.
cleanup

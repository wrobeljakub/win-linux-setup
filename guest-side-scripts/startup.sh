#!/bin/bash
SCRIPT=/home/gynvael/iface/iface.py # Correct this.
SCRIPT_ARGS=--linux
PYTHON=/usr/local/bin/python # Make sure it' s path to python 2.7!!!
SLEEP=/bin/sleep

# Retry 10 times.
for i in {0..10}
do

  if [ -e "$SCRIPT" ]
  then
    export SHELL=/bin/bash
    $PYTHON $SCRIPT $SCRIPT_ARGS >/dev/null 2>/dev/null &
    exit 0
  else
    $SLEEP 2
  fi

done

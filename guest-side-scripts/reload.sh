#!/bin/bash

IFACE=
PYTHON=/usr/bin/python2
SCRIPT_ARGS=--linux

pkill -9 python
sleep 2

for i in {0..10}
do
	if [ -e "$SCRIPT"]
	then
		export SHELL=/usr/bin/bash
		$PYTHON $IFACE $SCRIPT_ARGS >/dev/null 2>/dev/null &
		exit 0
	else
		sleep 2
	fi
done

#!/bin/bash
IFACE=
SCRIPT_ARGS=--linux
PYTHON=/usr/bin/python2

# Retry 10 times.
for i in {0..10}
do

	if [ -e "$SCRIPT" ]
	then
		export SHELL=/usr/bin/bash
		$PYTHON $IFACE $SCRIPT_ARGS >/dev/null 2>/dev/null &
		exit 0
	else
		sleep 2
	fi
done

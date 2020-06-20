#!/bin/bash
SCRIPT=/home/jakubwrobel/win-linux-setup/RPC/iface.py
SCRIPT_ARGS=--linux
PYTHON=/usr/bin/python2
SLEEP=/usr/bin/sleep

# Retry 10 times.
for i in {0..10}
do

	if [ -e "$SCRIPT" ]
	then
		export SHELL=/usr/bin/zsh
		$PYTHON $SCRIPT $SCRIPT_ARGS >/dev/null 2>/dev/null &
		exit 0
	else
		$SLEEP 2
	fi
done

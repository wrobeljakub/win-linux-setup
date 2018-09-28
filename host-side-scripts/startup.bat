@echo off
color a

set %PRVKEY%="Enter path here"
set %repopath%="Enter path to win-linux-setup directory"

echo Starting vcxsrv...
start c:\bin\vcxsrv.exe :0 -clipboard -multiwindows
start c:\bin\xhost.exe +192.168.56.3
set DISPLAY=127.0.0.1:0
echo vcxsrv is running.

echo starting pageant...
start pageant %PRVKEY%

echo starting virtual machine
call vm-start.bat

echo starting Windows/Linux iface...
start c:\python27\python.exe %repopath%\RPC\iface.py --windows
@echo off

set linuxusername=
set windows_repopath=
set linux_repopath=

taskkill /F /IM python.exe
sleep 1
start c:\Python27\python.exe %windows_repopath%\RPC\iface.py --windows
::start c:\Python27\pythonw.exe %windows_repopath%\RPC\iface.py --windows

ssh %linuxusername%@192.168.56.3 "(sh %linux_repopath%/guest-side-scripts/reload.sh) &>/dev/null &"

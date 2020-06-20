@echo off

set vcxsrvpath=c:\VcXsrv
set pythonpath=c:\python27\python.exe
set pythonwpath=c:\python27\pythonw.exe
set privkey=c:\etc\win-linux-setup\SSHkey.ppk
set repopath=c:\etc\win-linux-setup
set vmpath=C:\vms\Debian\Debian.vmx

echo Starting vcxsrv...
start %vcxsrvpath%\vcxsrv.exe :0 -ac -nowgl -clipboard -multiwindow
start %vcxsrvpath%\xhost.exe +192.168.56.3
set DISPLAY=127.0.0.1:0
echo vcxsrv is running.

echo starting pageant...
start pageant %privkey%

echo starting virtual machine
"C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe" start %vmpath% nogui

echo starting Windows/Linux iface...
start %pythonpath% %repopath%\RPC\iface.py --windows
rem start %pythonwpath% %repopath%\RPC\iface.py --windows
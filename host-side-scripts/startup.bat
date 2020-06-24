@echo off

set pythonpath=c:\python27\python.exe
set pythonwpath=c:\python27\pythonw.exe
set windows_repopath=c:\etc\win-linux-setup
set vmpath=C:\vms\Debian\Debian.vmx

"C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe" start %vmpath% nogui

start %pythonpath% %windows_repopath%\RPC\iface.py --windows
:: start %pythonwpath% %windows_repopath%\RPC\iface.py --windows

set DISPLAY=127.0.0.1:0

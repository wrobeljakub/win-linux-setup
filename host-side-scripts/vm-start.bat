@echo off

set vmpath=C:\vms\Debian\Debian.vmx

"C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe" start %vmpath% nogui
echo "VM started."
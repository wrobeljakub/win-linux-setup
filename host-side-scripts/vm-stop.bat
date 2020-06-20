@echo off

set vmpath=C:\vms\Debian\Debian.vmx

"C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe" stop %vmpath%
echo "VM Stopped."
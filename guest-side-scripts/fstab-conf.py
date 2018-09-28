#!/bin/env python

from subprocess import check_output
from os import system

drives = check_output("vmware-hgfsclient", shell=True).decode('utf-8').split()
fstab = open('/etc/fstab', 'a')

for drive in drives:
    fstab.write(
        ".host:{} /mnt/{} fuse.vmhgfs-fuse rw,allow_other 0 0".format(drive, drive[0].lower()))
    print("{} attached.".format(drive[0].lower()))
    system("ln /mnt/{} /{}".format(drive[0].lower(), drive[0].lower()))
    print("/{} link created.".format(drive[0].lower()))
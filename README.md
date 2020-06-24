# iface
![](media/preview.png)
This is my implementation of [@gynvael](https://github.com/gynvael)'s Windows - host + Debian - guest setup using a VMWare Workstation 15. I faced some issues while following [@SynneK1337](https://github.com/SynneK1337)'s guide, so I decided to create a new and complete guide. I hope that somebody will find it useful.

**WARNING**: The Windows/GNU+Linux iface by is EXPERIMENTAL and has nothing to do with good coding, security, etc. **USE AT YOUR OWN RISK**.

# Setting up a Virtual Network Interfaces

* Open VMWare Workstation
* Go to: Edit -> Virtual Network Editor
* Create one Bridged Network Interface and attach your physical Network Adapter to it (it will be used to get the internet access on your linux guest)
* Create another Host-Only Adapter with set it up like on picture below

![](media/virtual-adapters.jpg)

# Virtual Machine Creation
Create a Virtual Machine as you always do, but attach two of those Network Interfaces to it and install your favourite GNU/Linux Distribution.


# VMWare Tools installation
* Arch based: ```sudo pacman -S open-vm-tools xf86-video-vmware```
* Debian based: ```sudo apt install open-vm-tools xserver-xorg-video-vmware```
* openSUSE: [software.opensuse.org](https://software.opensuse.org/download.html?project=Virtualization%3AVMware&package=open-vm-tools)

# Clone this repo to your VM
```
git clone https://github.com/jakubwrobel/win-linux-setup.git
```
# Attaching host physical drivers to Virtual Machine
Make sure your on 4.x kernel or newer: ```uname -r```\
```sudo poweroff```
In VMWare Workstation go to: **Edit this Virutal Machine settings** -> **Options** -> **Shared Folders** -> Check **Always enabled** -> **Add** -> Add the root folder of every partition you want to attach and name it **DRIVE_C**, **DRIVE_D** etc

![](media/disk_attaching.jpg)
![](media/disks_attached.jpg)

In ```/etc/fstab``` add line/lines ```.host:DRIVE_x /mnt/x fuse.vmhgfs-fuse rw,allow_other 0 0``` where ```x``` is the letter of your Windows drive/drives.

# Set up Network Interfaces on your Guest
```nmtui```
* Install NetworkManger
  * Arch based: ```sudo pacman -S networkmanager```
  * Debian based: ```sudo apt install network-manager```

* Enable NetworkManger service ```sudo systemctl enable NetworkManger```, disable other networking services e.g. ```dhcpcd.service```, ```networking.service``` and remove all interfaces starting with ``ens`` from ```/etc/network/interfaces``` file.
* ```sudo reboot```
* Set up your host-only interface ipv4 address to 192.168.56.3/24 using ```nmtui```

# Set up Network Interface on your Host
**Control Panel** -> **Network and Sharing Center** -> **Change adapter settings** -> right-click on ***your host-only interface*** -> **Properties** -> **Internet Protocol Version 4 (TCP/IPv4)** -> set it like on picture belown

![](media/network_configuration.jpg)

# Set Up SSH Server on guest-side **(for easier troubleshoting)**
* Install OpenSSH and enable it ```sudo systemctl enable ssh```
* edit ```/etc/ssh/sshd_config``` \
in line ***13***  change ```port``` to something different that 22 **(eg. 2137)** \
in line ***56*** change ```PasswordAuthentication``` to **no** \
in line ***32*** change ```PermitRootLogin``` to **no**

# Set Up SSH on Host-side
* Open ```cmd.exe``` \
* Generate SSH key with ```ssh-keygen``` \
* ```mkdir .ssh``` in your *$HOME* directory \
* Transfer ```id_rsa.pub``` to guest using ```cp /c/Users/your_windows_username/.ssh/id_rsa.pub ~/.ssh/authorized_keys``` \
* Now you can connect to your VM by typing ```ssh -p your_port your_linux_username@192.168.56.3```

# Install VcXsrv
* [Download](https://sourceforge.net/projects/vcxsrv/)

# Configure all host-side scripts
* go to ```REPO/host-side-scripts``` \
Correct variables values on top of every file located in that directory. \
```vcxsrvpath```= directory where *VcXsrv* was installed \
```pythonpath``` path to *python.exe*, it should be ```c:\python27\python.exe``` \
```pythonwpath``` path to *pythonw.exe*, it should be ```c:\python27\pythonw.exe``` \
```privkey``` path to your private key in .ppk format \
```repopath``` path to this repo cloned into your disk \
```vmpath``` path to *.vmx* file located in your VM's directory

# Configure iface
* Edit ```REPO/RPC/iface.cfg``` \
in line ***2*** enter random string \
in line ***3*** enter path to *home* directory on guest-side \
in line ***6*** enter path to your *terminal emulator* \
Use same iface.cfg both on guest and host side

# Add iface to autostart on guest-side
* Edit ```REPO/guest-side-scripts/startup.sh```
in line ***2*** enter path to the *iface.py* on guest-side \
in line ***4*** enter path to *python2* ```whereis python2``` \
in line ***5*** enter path to *sleep* ```whereis sleep``` \
in line ***13*** enter path to the shell you use ```whereis bash```/```whereis zsh```
* Install ```cron``` and enable it ```sudo systemctl enable cron```
* ```crontab -e``` \
add line
```@reboot *PATH to startup.sh*```

# Add iface to autostart on host-side
* Go to ```shell:startup``` using ```win+R``` shortcut and create link to ```REPO\host-side-scripts\startup.bat```


# Credits
* [@gynvael](https://github.com/gynvael) for providing RPC Interface
* [@SynneK1337](https://github.com/SynneK1337) for writing great guide

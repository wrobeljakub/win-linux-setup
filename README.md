# iface
![](media/preview.jpg)
Rather bad Windows/Linux RPC interface specialized for a Windows-host/GNU+Linux-guest configuration.

**WARNING**: The Windows/GNU+Linux iface by is EXPERIMENTAL and has nothing to do with good coding, security, etc. **USE AT YOUR OWN RISK**.

In this guide, I'll show you how to setup Windows-host + GNU/Linux-guest using a VMWare Workstation.

# Setting up a Virtual Network Interfaces

* Open VMWare Workstation
* Go to: Edit -> Virtual Network Editor
* Create one Bridged Network Interface and attach your physical Network Adapter to it (it will be used to get the internet access on your linux guest)
* Create another Host-Only Adapter with set it up like on picture below

![](media/virtual-adapters.jpg)

# Virtual Machine Creation
Create a Virtual Machine as you always do, but attach two of those Network Interfaces to it and install your favourite GNU/Linux Distribution (Btw. I use Arch). 


# VMWare Tools installation
* Arch Linux: ```sudo pacman -S open-vm-tools xf86-video-vmware```
* Debian/Ubuntu-based: ```sudo apt install open-vm-tools xserver-xorg-video-vmware```
* openSUSE: [software.opensuse.org](https://software.opensuse.org/download.html?project=Virtualization%3AVMware&package=open-vm-tools)

# Clone this repo to your VM
```
git clone https://github.com/synnek1337/win-linux-setup.git
```
# Attaching host physical drivers to Virtual Machine
Make sure your on 4.x kernel or newer: ```uname -r```\
Shut down the Virtual Machine.
In VMWare Workstation go to: **Edit this Virutal Machine settings** -> **Options** -> **Shared Folders** -> Check **Always enabled** -> **Add** -> Add the root folder of every partition you want to attach and name it **DRIVE_C**, **DRIVE_D** etc.

![](media/disk_attaching.jpg)
![](media/disks_attached.jpg)

Start the VM, go to ```win-linux-setup/guest-side-conf-scripts``` and do ```sudo python fstab-conf.py``` **!! USE PYTHON 3**

# Set up Network Interfaces on your Guest
```nmtui```
Set up your host-only interface ipv4 address to 192.168.56.3/24

# Set up Network Interface on your Host
**Control Panel** -> **Network and Sharing Center** -> **Change adapter settings** -> right-click on ***your host-only interface*** -> **Properties** -> **Internet Protocol Version 4 (TCP/IPv4)** -> set it like on picture belown

![](media/network_configuration.jpg)

# Set Up SSH Server on guest-side **(for easier troubleshoting)**
* Install OpenSSH and enable it like it' s described on your distro' s wiki (*https://wiki.archlinux.org/index.php/Secure_Shell*)
* edit ```/etc/ssh/sshd_config``` \
in line *13*  change ```port``` to something different that 22 **(eg. 2137)** \
in line *15* change ```ListenAddress``` to **192.168.56.3** \
in line *57* change ```PasswordAuthentication``` to **no** \
in line *32* change ```PermitRootLogin``` to **no**.

* Generate SSH Keys \
```ssh-keygen``` and enter the passphrase \
go to ```~/.ssh/``` and rename **id_rsa.pub** to **authorized_keys** \
Transfer ```id_rsa``` to your host by ```cp id_rsa /c/...```

# Set Up PuTTY on Host-side
* [Download](https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.70-installer.msi) PuTTY
* Open ```puttygen``` \
**Conversions** -> **Import Key** -> **Save private key**
* Edit ```.\host-side-scripts\startup.bat``` \
in line *4* ***enter path to your .ppk file***.
* Now you can easily connect to your VM


# Credits
* [@gynvael](https://github.com/gynvael) for providing RPC Interface
* [@vmware](https://github.com/vmware) for providing virtualization solutions
* [@python](https://github.com/python) for providing Python Programming language
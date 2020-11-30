## Setup Boot and Arch ISO on USB key

First, setup the boot USB, boot arch live iso, and run the `preinstall.sh` from terminal. 

### Arch Live ISO (Pre-Install)

This step installs arch to your hard drive. *IT WILL FORMAT THE ENTIRE DISK*

```bash
pacman -Syy; pacman -S wget --noconfirm
wget https://raw.githubusercontent.com/ilyessbachiri/arch/master/preinstall.sh
wget https://raw.githubusercontent.com/ilyessbachiri/arch/master/chroot.sh
chmod u+x preinstall.sh chroot.sh
./preinstall.sh
reboot
```

### Arch Linux First Boot

Once the machine reboots, login with `root` and run the following commands:

```bash
pacman -S git --no-confirm
git clone https://github.com/ilyessbachiri/arch
cd arch
./install.sh
```

### Arch Linux After Login to Awesome

The previous command (`./install.sh`) will bring up the display manager. Login with user you entered
in the previous step and choose Awesome as the windown manager.

```bash
git clone https://github.com/ilyessbachiri/arch
arch/9-customization.sh
```
*Note*: This script opens a `zsh` shell and gets "stuck" there. You need to exit (by running the command `exit`)
for it to continue.

### Don't just run these scripts. Examine them. Customize them. Create your own versions.

---

### System Description
This runs Awesome Window Manager with a custom Material theme.

To boot I use `systemd` because it's minimalist, comes built-in, and since the Linux kernel has an EFI image, all we need is a way to execute it.

I also install the LTS Kernel along side the rolling one, and configure my bootloader to offer both as a choice during startup. This enables me to switch kernels in the event of a problem with the rolling one.

### Resolution
If running in as a virtual machine set the resolution in `/etc/lightdm/lightdm.conf` file by setting the display setup script as follows:
```
display-setup-script=xrandr --output Virtual-1 --mode 1920x1080
```
### Troubleshooting Arch Linux

__[Arch Linux Installation Gude](https://github.com/rickellis/Arch-Linux-Install-Guide)__

#### No Wifi

```bash
sudo wifi-menu`
```

#### Initialize Xorg:
At the terminal, run:

```bash
xinit
```

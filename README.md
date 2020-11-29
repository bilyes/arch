## Setup Boot and Arch ISO on USB key

First, setup the boot USB, boot arch live iso, and run the `preinstall.sh` from terminal. 

### Arch Live ISO (Pre-Install)

This step installs arch to your hard drive. *IT WILL FORMAT THE DISK*

```bash
pacman -Syy; pacman -S wget --noconfirm
wget https://raw.githubusercontent.com/ilyessbachiri/arch/master/preinstall.sh
wget https://raw.githubusercontent.com/ilyessbachiri/arch/master/chroot.sh
chmod u+x preinstall.sh chroot.sh
./preinstall.sh
reboot
```

### Arch Linux First Boot

```bash
pacman -S git --no-confirm
git clone https://github.com/ilyessbachiri/arch
cd arch
./install.sh
```

### Arch Linux After Login to Awesome

```bash
git clone https://github.com/ilyessbachiri/arch
arch/9-customization.sh
```

### Don't just run these scripts. Examine them. Customize them. Create your own versions.

---

### System Description
This runs Awesome Window Manager with the base configuration.

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

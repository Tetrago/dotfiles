# dotfiles

## Installing Arch

### User-required Setup

Go through the basic installation process for Arch:
1. Check for UEFI boot: `ls /sys/firmware/efi/efivars`
2. `timedatectl set-ntp true`
3. Partition your drive(s)
    - mkfs.ext4
    - mkswap
    - swapon
4. `mount /dev/root_partition /mnt`
5. `pacstrap /mnt base linux linux-firmware`
6. `genfstab -U /mnt >> /mnt/etc/fstab`
7. `arch-chroot /mnt`

### Installation

Execute the installation script:

1. Add your hostname to `/etc/hostname`
2. `curl -sLf https://raw.githubusercontent.com/Tetrago/dotfiles/master/arch_install.sh | bash`

Setup users:
1. `passwd`
2. `useradd -m [user]`
3. `usermod -aG wheel,optical,video,audio,storage [user]`
4. `passwd [user]`

Setup grub:
1. `grub-install /dev/sda`
    - This may vary when using UEFI
2. `grub-mkconfig -o /boot/grub/grub.cfg`

Quit:
1. `exit`
2. `umount /mnt`
3. `shutdown now`

### Post-installation Setup

After rebooting, execute the setup script:

`curl -sLf https://raw.githubusercontent.com/Tetrago/dotfiles/master/arch_setup.sh | sudo bash`
#!/bin/sh

echo "Pylon" >> /etc/hostname

echo "LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8" > /etc/locale.conf

echo "en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8" > /etc/locale.gen

locale-gen

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock -wu

pacman -Syu --noconfirm git linux linux-firmware networkmanager zsh
systemctl enable NetworkManager

passwd

useradd -m -G wheel -s /bin/zsh kako
passwd kako

sed -i 's/# \(%wheel ALL=(ALL) ALL\)/\1/' /etc/sudoers

bootctl --path=/boot install
echo "default arch
timeout 5" > /boot/loader/loader.conf
echo "title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=$(blkid -s PARTUUID -o value $(lsblk -rpo NAME,MOUNTPOINT | awk '$2=="/"{print $1}'))" \
	> /boot/loader/entries/arch.conf

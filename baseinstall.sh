#!/bin/bash

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	arch.localdomain	arch" >> /etc/hosts
echo root:PASSWORD |chpasswd

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel xdg-user-dirs xdg-utils bluez bluez-utils cups bash-completion rsync pipewire pipewire-alsa alsa-utils openssh tlp avahi

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer 
systemctl enable avahi-daemon

useradd -m rodal
echo rodal:PASSWORD |chpasswd
echo "rodal ALL=(ALL) ALL" >> /etc.sudoers.d/rodal

echo "Done!"
echo "Type: exit, followed by: umount -a, and then: reboot"

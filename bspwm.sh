#!/bin/bash

sudo timedatectl set-ntp true
sudo hwclock --systohc

sudo reflector -c 'United States' -a 12 --sort rate --download-timeout 20 --save /etc/pacman.d/mirrorlist
sudo pacman -Syy

git clone https://aur.archlinux.org/yay-git.git
cd yay-git/
makepkg -si --noconfirm

echo "MAIN PACKAGES"

sleep 5

sudo pacman -S --noconfirm xorg light-locker lightdm lxappearance bspwm sxhkd picom nitrogen dmenu ranger simplescreenrecorder alsa-utils qbittorent r gcc gcc-libs obs-studio dunst pulseaudio pulseaudio-alsa pavucontrol arandr

yay -S --noconfirm brave-bin st remmina-git dropbox f5vpn mendeleydesktop rstudio-desktop-bin teams zoom dragon-drag-and-drop 

sudo systemctl enable lightdm

mkdir -p .config/{bspwm,sxhkd,dunst}

install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

echo "Change files in sxhkd config before rebooting"

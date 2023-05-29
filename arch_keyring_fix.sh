#!/usr/bin/env bash
# Thanks to G3NSVRV
# https://github.com/yuk7/ArchWSL/issues/91#issuecomment-506806989

sudo rm -R /etc/pacman.d/gnupg/
sudo rm -R /root/.gnupg/ 
sudo rm -R /var/cache/pacman/pkg/
sudo gpg --refresh-keys
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --refresh-keys
sudo pacman -Syyu
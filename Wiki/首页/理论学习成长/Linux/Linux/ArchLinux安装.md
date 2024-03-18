  

  

  

1. 分区
2. timedatectl set-ntp true
3. Pacstrap /mnt base linux linux-firmware base-devel
4. arch-chroot mnt
5. ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
6. hwclocl --systohc
7. vim /etc/locale.gen
8. locale-gen
9. vi /etc/hostname
10. vi /etc/hosts
11. pacman -S linux-lts linux-lts-headers
12. useradd cd
13. chsh -s /binzsh cd
14. pacman -s grub efibootmgr
15. grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
16. vim /etc/default/grub. 取消注释 GRUB_DISABLE_OS_PROBER=false
17. grub-mkconfig -o /boot/grub/grub.cfg
18. pacman -s os-prober ntfs-3g

  

  

# pacman

- pacman -S package 安装软件包
- pacman -R package 卸载软件包
- pacman -Rs package 卸载软件包，并卸载没有被其他软件依赖的软件包
- pacman -Rsc package 递归删除软件包和所有依赖这个软件包的所有其他软件

‘

pacman -S xorg iwd xorg-server xorg-apps xf86-input-synaptics sddm plasma-desktop

pacman -S nvidia-lts nvidia-settings

pacman -S networkmanager iwd dhcp dhcpcd

systemctl enable sddm

用户组没设置好会导致sddm无法进入kde

pacman -S kscreesn

pacman -S dolphin yakuake alsa-utils powerdevil plasma-nm
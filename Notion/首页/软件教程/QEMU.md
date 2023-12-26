---
Created: 2023-06-26T00:08
---
qemu-system-aarch64 -machine mcimx7d-sabre -cpu cortex-a7 -accel tcg‘‘

qemu-system-arm -M mcimx7d-sabre -m 1024 -kernel /home/charles/Project/IMX7/NXP_LINUX/u-boot-imx7dsabresd_nand.imx -dtb /home/charles/Project/IMX7/NXP_LINUX/imx7d-sdb.dtb -drive file=./sd.img,if=sd,format=raw -append "root=/dev/mmcblk0p1 rw console=ttyAMA0,115200n8" -serial file:./txt -net nic,model=smc91c111 -net user -nographic

  

  

tested

qemu-system-aarch64 -M xilinx-zynq-a9  -serial /dev/null -serial mon:stdio -display none -kernel ./uImage -dtb ./system.dtb -nographic -sd ./rootfsts.ext4 -append "root=/dev/mmcblk0 rw”
[[README]]

## 文件目录

Directory Hierarchy:  
====================  
  
/arch Architecture specific files  
/arc Files generic to ARC architecture  
/arm Files generic to ARM architecture  
/m68k Files generic to m68k architecture  
/microblaze Files generic to microblaze architecture  
/mips Files generic to MIPS architecture  
/nds32 Files generic to NDS32 architecture  
/nios2 Files generic to Altera NIOS2 architecture  
/openrisc Files generic to OpenRISC architecture  
/powerpc Files generic to PowerPC architecture  
/riscv Files generic to RISC-V architecture  
/sandbox Files generic to HW-independent "sandbox"  
/sh Files generic to SH architecture  
/x86 Files generic to x86 architecture  
/api Machine/arch independent API for external apps  
/board Board dependent files  
/cmd U-Boot commands functions  
/common Misc architecture independent functions  
/configs Board default configuration files  
/disk Code for disk drive partition handling  
/doc Documentation (don't expect too much)  
/drivers Commonly used device drivers  
/dts Contains Makefile for building internal U-Boot fdt.  
/examples Example code for standalone applications, etc.  
/fs Filesystem code (cramfs, ext2, jffs2, etc.)  
/include Header Files  
/lib Library routines generic to all architectures  
/Licenses Various license files  
/net Networking code  
/post Power On Self Test  
/scripts Various build scripts and Makefiles  
/test Various unit test files  
/tools Tools to build S-Record or U-Boot images, etc.  

  

  

## 开发板初始化流程

首先运行架构中的架构中的start.S文件，接下来调用三个函数分别为：

1. lowlevel_init()：为调用board_init_f() 做准备
2. board_init_f(): 为调用board_init_r()做准备
3. board_init_r():

  

  

## 生成文件

- "u-boot.bin" is a raw binary image
- "u-boot" is an image in ELF binary format
- "u-boot.srec" is in Motorola S-Record format

  

  

1. Add O= to the make command line invocations:
    
    make O=/tmp/build distclean  
    make O=/tmp/build NAME_defconfig  
    make O=/tmp/build all  
    
2. Set environment variable KBUILD_OUTPUT to point to the desired location:
    
    export KBUILD_OUTPUT=/tmp/build  
    make distclean  
    make NAME_defconfig  
    make all
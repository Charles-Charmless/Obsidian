概述

参考文献

内核编译

内存寻址

进程管理

内存管理

中断

系统调用

内核同步

文件系统

设备驱动

内核函数

实验

![[mrjc6ztw4jnh.jpg]]

# 概述

内核设计理念：机制和策略分离

  

  

  

  

# 参考文献

linux操作系统原理与应用

现代操作系统

linux内核的设计与实现

深入理解linux内核

linux设备驱动程序

# 内核编译

1. 获取源码：[链接](https://www.kernel.org/)
2. 配置内核
    
    make config：遍历选择所要编译的内核特性  
    make allyesconfig：配置所有可编译的内核特性  
    make allnoconfig：并不是所有的都不编译，而是能选的都回答为NO、只有必须的都选择为yes。  
    make menuconfig：这种就是打开一个文件窗口选择菜单，这个命令需要打开的窗口大于80字符的宽度，打开后就可以在里面选择要编译的项了  
    下面两个是可以用鼠标点选择的、比较方便哦：  
    make kconfig(KDE桌面环境下，并且安装了qt开发环境)  
    make gconfig(Gnome桌面环境，并且安装gtk开发环境)  
    menuconfig：使用这个命令的话、如果是新安装的系统就要安装gcc和ncurses-devel这两个包才可以打开、然后再里面选择就可以了、通这个方法也是用得比较多的：  
    
      
    
    zimage和uimage区别:
    
    > [!info] uImage和zImage的区别  
    > ​转自： https:// blog.  
    > [https://zhuanlan.zhihu.com/p/46403145](https://zhuanlan.zhihu.com/p/46403145)  
    
      
    
      
    
      
    
      
    
      
    

  

# 内存寻址

asfaf

  

# 进程管理

  

  

# 内存管理

  

# 中断

  

# 系统调用

  

# 内核同步

  

# 文件系统

  

# 设备驱动

  

  

make config：遍历选择所要编译的内核特性  
make allyesconfig：配置所有可编译的内核特性  
make allnoconfig：并不是所有的都不编译，而是能选的都回答为NO、只有必须的都选择为yes。  
make menuconfig：这种就是打开一个文件窗口选择菜单，这个命令需要打开的窗口大于80字符的宽度，打开后就可以在里面选择要编译的项了  
下面两个是可以用鼠标点选择的、比较方便哦：  
make kconfig(KDE桌面环境下，并且安装了qt开发环境)  
make gconfig(Gnome桌面环境，并且安装gtk开发环境)  
menuconfig：使用这个命令的话、如果是新安装的系统就要安装gcc和ncurses-devel这两个包才可以打开、然后再里面选择就可以了、通这个方法也是用得比较多的：  

  

  

  

# 内核函数

[[内核函数]]

[[内核编程]]

# 实验

[[hello world!程序]]

[[链表实验]]






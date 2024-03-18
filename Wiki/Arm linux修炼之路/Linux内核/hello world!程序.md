hello.c

Makefile

输出

总结

Makefile反思

module_exit()

库文件问题

## hello.c

```C
\#include <linux/kernel.h>
\#include <linux/module.h>

static  int __init hello_init(void){
        printk("hello world!");
        return 0;
}


static void __exit hello_exit(void){
        printk("good bye, world");
}


module_init(hello_init);
module_exit(hello_exit);


MODULE_LICENSE("GPL");
```

## Makefile

```Makefile
obj-m=hello.o
CURRENT_PATH := $(shell pwd)
LINUX_KERNEL := $(shell uname -r)
LINUX_KERNEL_PATH := /usr/src/linux

all:
        make -C $(LINUX_KERNEL_PATH) M=$(CURRENT_PATH) modules
clean:
        make -C $(LINUX_KERNEL_PATH) M=$(CURRENT_PATH) clean
```

  

## 输出

```Bash
[  +0.016418] hello world!
[  +0.004977] good bye, world
```

  

## 总结

### Makefile反思

- makefile文件其实主要的内容就是 make modules,其他都是指定库文件所在位置，

```Bash
# Use make M=dir to specify directory of external module to build
# Old syntax make ... SUBDIRS=$PWD is still supported
# Setting the environment variable KBUILD_EXTMOD take precedence
ifdef SUBDIRS
  KBUILD_EXTMOD ?= $(SUBDIRS)
endif
ifdef M
  ifeq ("$(origin M)", "command line")
    KBUILD_EXTMOD := $(M)
  endif
endif
```

### module_exit()

```C
\#include <linux/kernel.h>

## definition
\#define module_init(x) __initcall(x)
\#define module_exit(x) __exitcall(x)

typedef int (*initcall_t)(void);
typedef void (*exitcall_t)(void);

\#define __initcall(fn)								\
	static initcall_t __initcall_#\#fn __init_call = fn
\#define __exitcall(fn)								\
	static exitcall_t __exitcall_#\#fn __exit_call = fn
```

- 如果设置出口函数的返回值为int型变量，编译报错，显示返回值不匹配

```C
/home/cd/Project/Kernel_Program/hello.c: In function ‘hello_exit’:
/home/cd/Project/Kernel_Program/hello.c:12:1: warning: no return statement in function returning non-void [-Wreturn-type]
   12 | }
      | ^
In file included from /home/cd/Project/Kernel_Program/hello.c:2:
/home/cd/Project/Kernel_Program/hello.c: In function ‘__exittest’:
/home/cd/Project/Kernel_Program/hello.c:16:13: error: returning ‘int (*)(void)’ from a function with incompatible return type ‘exitcall_t’ {aka ‘void (*)(void)’} [-Werror=incompatible-pointer-types]
   16 | module_exit(hello_exit);
      |             ^~~~~~~~~~
./include/linux/module.h:138:11: note: in definition of macro ‘module_exit’
  138 |  { return exitfn; }     \
      |           ^~~~~~
/home/cd/Project/Kernel_Program/hello.c: At top level:
./include/linux/module.h:139:7: warning: ‘cleanup_module’ alias between functions of incompatible types ‘void(void)’ and ‘int(void)’ [-Wattribute-alias=]
  139 |  void cleanup_module(void) __copy(exitfn) __attribute__((alias(\#exitfn)));
      |       ^~~~~~~~~~~~~~
/home/cd/Project/Kernel_Program/hello.c:16:1: note: in expansion of macro ‘module_exit’
   16 | module_exit(hello_exit);
      | ^~~~~~~~~~~
/home/cd/Project/Kernel_Program/hello.c:10:19: note: aliased declaration here
   10 | static int __exit hello_exit(void){
      |                   ^~~~~~~~~~
cc1: some warnings being treated as errors
```

### 库文件问题

- 系统没有安装库文件，安装上即可 “ sudo pacman -S linux-headers”
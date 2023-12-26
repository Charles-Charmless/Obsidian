[Share](https://www.notion.sojavascript:void(0);)

# 文件IO

1. **可用的文件IO函数**：打开文件，读文件，写文件等（不带缓冲的IO函数（指每个read或write函数都调用内核的一个系统调用））,不是ISO C的组成部分，但是时POSIX和SUS的组成部分
2. **UNIX系统中常用的文件IO函数**：open,read,wirte,lseek,close函数
3. 当打开一个现有文件或创建一个新文件时，内核向进程返回一个**文件描述符**（非负整数）
    - UNIX的shell把文件描述符0与标准输入关联，文件描述符与标准输出关联，文件描述符2与标准错误输出关联，在POSIX标准中，对应的被替换为符号常量STDIN_FLLENO,SEDOUT_FLLENO,STDERR_FLLENO　<unistd,h>

---

## 函数open和openat (fcntl.h)

`int open(const char* path,int oflag,.../*mode_t mode*/);int openat(int fd,const char* path,int oflag,.../*mode_t mode*/);`

### 描述

1. 将最后一个参数写为…,表明余下的参数的数量以及类型是可变的
2. 由open和openat函数返回的文件描述符一定是最小的未用的描述符数值
    
    ### 参数
    

- 若path参数指定为绝对路径，fd参数无用，openat函数相当于open函数
- path指定的是相对路径，fd参数指出相对路径名在文件系统中的开始位置
- path指定相对路径名，fd参数具有特殊值AT_FDCWD，路径名在当前工作目录中获取，openat函数在操作上与open函数类似
- mode:文件权限
- oflag参数： 参数 描述 ————– —— O_RDONLY  
    O_WRONLY  
    O_RDWR  
    O_EXEC  
    O_SEARCH  
    O_APPEND  
    O_CLOEXEC  
    O_CREAT  
    O_DIRECTORY  
    O_EXCL  
    O_NOCTTY  
    O_NOFOLLOW  
    O_NONBLOCK  
    O_SYNC  
    O_TRUNC  
    O_TTY_INIT  
    O_DSYNC  
    O_RSYNC  
    

✰可以通过逻辑或同时使用多个参数

---

## 函数creat　<fcntl.h>

`int creat(const char *path,mode_t mode);`  
等效于　  
`open(path,0_WRONLY|O_CREAT|O_TRUNC,mode)`

---

## 函数：　close <unistd.h> {#函数：-close-lt-unistd-h-gt}

`int close(int fd);`

---

## 函数 lseek <unistd.h>

`off_t lseek(int fd,off_t offset,int whence)`

1. 系统默认情况下，当打开一个文件时，除非指定O_APPEND选项，否则该偏移量被设置为0
2. 调用lseek函数可以显式的为打开一个文件设置偏移量
    - 如果whence是SEEK_SET，则将该文件的偏移量设置为距文件开头处offset个字节
    - 如果whence是SEEK_CUR，则将该文件的偏移量设置为当前值加offset，offset可正可负
    - 如果whence是SEEK_END，将该文件的偏移量设置为文件长度加offset，offset可正可负

---

## 函数read <unistd.h>

`ssize_t read(int fd,void *buf,size_t nbytes);`**返回值**：读到的字节数，若已到文件尾，返回0，若出错，返回-1　(可能因为数据的本身大小的原因导致读到的字节数少于要求读的字节数)

- 在ISO C中，void*表示通用指针

---

## 函数write <unistd.h>

`ssize_t write (int fd,void *buf,size_t nbytes)`**返回值**：若成功，返回已写字节数，若出错，返回-1

- 对于普通文件，写操作会从当前偏移量开始

**IO效率**：当缓冲区大小与磁盘block大小一致时系统cpu时间最少（效率最高）当继续增大缓冲区大小时并不会提高效率

---

## 文件共享

**UNIX系统支持在不同的进程间共享打开的文件**

### 内核表示打开文件的三种数据结构

1. 进程表项（每个进程都有一个记录项，记录项包含一张打开文件描述符表）
    - 文件描述标志
    - 指向一个文件表项的指针
2. 文件表项（内核为所有文件维持一张文件表）
    - 文件标志状态
    - 当前文件偏移量
    - 指向该文件V节点表项的指针
3. V节点表项（每个打开文件（或设备）都有一个V节点结构）
    - 文件类型
    - 对此文件进行各项操作函数的指针
    - 对于大多数文件还包含文件的I节点（I节点包含文件的所有者，文件长度，指向文件实际数据块在磁盘所在位置的指针）  
        ❦如果两个独立进程各自打开同一个文件，则有下图的关系  
        ➽之所以每个进程可以获得自己的文件表项，是因为这可以使每个进程都有自己对该文件的当前偏移量  
        ➽文件共享操作可能产生预想不到的结果，相当两个进程同时对文件的操作的顺序不同可能到是文件内容的混乱和丢失，为了知道如何避免这种情况，需要理解原子操作的概念  
        
        [![](https://www.notion.so../pictures/wenjianIO_1.png)](https://www.notion.so../pictures/wenjianIO_1.png)
        
        [![](https://www.notion.so../pictures/wenjianIO_2.png)](https://www.notion.so../pictures/wenjianIO_2.png)
        

### 原子操作： {#原子操作：}

- 多个进程同时对一个文件进行操作导致混乱的原因在于使用了多个操作符（先定位再操作）
- 解决这种混乱只需使这两个操作对于其他进程而言成为一个原子操作
- 原子操作指多步组成的一个操作，任何要求多于一个函数调用的操作不是原子操作 ,如果该操作原子的执行，那么执行完所有的操作，要么一步也不执行，不可能只执行所有步骤的一个子集

---

## 函数pread和pwrite <unistd.h> （SUS C的XSI扩展） {#函数pread和pwrite-lt-unistd-h-gt-（SUS-C的XSI扩展）}

`ssize_t pread(int fd,void* buf,size_t nbytes,off_t offset);ssize_t pwrite(int fd,const void* buf,size_t nbytes,off_t offset);`

1. 调用pread相当于调用lseek后调用read
    - pread与上面的顺序调用的区别：调用pread时无法中断其定位与操作 不会更新当前文件偏移量
2. 调用pwrite相当于调用lseek后调用write
    - pwrite也有类似的区别

---

## 函数dup和dup2 <unistd.h> ##

**描述**：复制一个现有的文件描述符`int dup(int fd);int dup2(int fd,int fd2);`

- 由dup返回的新文件描述符一定是当前可用文件爱你描述符中最小数值
- 对于dup2可以用fd2参数指定新描述符的值，如果fd2已经打开，则先将其关闭，如果fd等于fd2，则dup2返回fd2，而不关闭他，否则fd2的FD_CLOEXEC文件描述符标志就会被清空，_这样fd2在调用exec时总是打开的状态_。

---

## 函数sync,fsync,fdatasync <unistd,h>

`int fsync(int fd);int fdatasync(int fd);void sync(void);`

- 传统的UNIX系统内核内没有设置缓冲区高速缓存或页高速缓存，大多数磁盘IO都通过缓冲区进行，等到修改过的数据需要写到磁盘中，或者当内核需要重用缓冲区来存放其他磁盘块数据时，再将缓冲区内的数据块（延时写数据）写入磁盘

1. sync只是将所有修改过的块缓冲区排入写队列，然后就返回，不等待实际写磁盘操作的完成
2. fsync函数只针对文件描述符fd指定的一个文件起作用，并且等待写磁盘操作结束才返回
3. fdatasync类似于fsync，但他只影响文件的数据部分，而除数据外，fsync还会同步更新文件的属性

---

## 函数fcntl <fcntl.h>

`int fcntl(int fd,int cmd,.../*int arg*/);`  
** 描述:  
**改变已经打开文件的属性  
**功能：  
**  
功能|cmd参数  
:-|:-  
复制一个已有的操作符|（cmd=F_EUPFD或 F_DUPED_CLOEXEC）  
获取/设置文件描述符标志|(cmd=F_GETFD 或F_SETFD)  
获取/设置文件状态标志|(cmd=F_GETFL或 F_SETEL)  
获取/设置异步IO所有权|(cmd=F_GETOWN或 F_SETOWN)  
获取/设置记录锁|(cmd=F_GETLK 或F_SETLK 或F_SETLKW)（在记录锁处在详解）  

|cmd值|描述|
|---|---|
|[[F-DUPFD]]||
|[[F-DUPFD_CLOEXEC]]||
|[[F-GETFD]]||
|[[F-SETFD]]||
|[[F-GETFL]]||
|[[F-SETFL]]||
|[[F-GETOWN]]||
|[[F-SETOWN]]||

  
  

|对于fcntl的文件状态标志|描述|
|---|---|
|[[O_RDONLY]]||
|[[O_WRONLY]]||
|[[O_RDWR]]||
|[[O_EXEC]]||
|[[O_SEARCH]]||
|[[O_APPEND]]||
|[[O_NONBLOCK]]||
|[[O_SYNC]]||
|[[O_DSYNC]]||
|[[O_RSYNC]]||
|[[O_FSYNC]]||
|[[O_ASYNC]]||

  
  

➤前面5中访问方式标志并不各占一位，一个文件的访问方式只能是这5个值之间的一个，必须先用屏蔽字O_ACCMODE取得访问方式位再将结果与这5个值之间的每一个进行比较**返回值**：

- 如果出错，所有命令返回-1
- 如果成功返回某个其他值，
- 下列四个命令具有特定返回值：
    - F_DUPFD,F_GETFD,F_GETFL,F_GETOWN第一个命令返回一个新的文件描述符
    - 第二个第三个命令返回相应的标志，
    - 最后一个命令返回一个正的或负的进程组ID
        - 正的表示对应的进程ID，负的进程组ID表示绝对值对应的一个进程组ID

---

## 函数ioctl()　<ioctl.h> <unistd.h>

`int ioctl(int fd,int request);`　(SUS标准扩展)

- ioctl函数一直是IO操作的杂货箱，不能用其他函数表示的IO操作通常都能用ioctl函数表示 终端最常用

---

## 特殊文件描述符

/dev/fd　用文件来表示文件描述符

- 特指标准输入或标准输出
# UNIX环境高级编程-文件和目录

[Share](https://www.notion.sojavascript:void(0);)

# 文件系统特征和文件的性质

## 函数stat，fstat,fstatat,lstat <sys/stat.h> {#函数stat，fstat-fstatat-lstat-lt-sys-stat-h-gt}

```Plain
`int stat(const char * restrict pathname,struct stat* restrict buf);
一但给出pathname，stat函数返回与此命名文件有关的信息结构


`int fstat(int fd,struct stat* buf);`
+ fstat函数获得已在描述符fd上打开文件的有关信息


`int lstat(const char* restrict pathname,struct stat* restrict buf,int flag);`
lstat函数类似于stat，但是当命名的文件是一个符号链接时，lstat返回符号链接的有关信息，而不是由该符号链接引用的文件的信息
```

`int fstatat(int fd,const char* restrict pathname,struct stat* restrict buf,int flag)`

- fstatat函数为一个相对于当前打开目录（由fd指向）的路径名返回文件统计信息 +————————————–+————————————–+ | 123456789101112131415 | struct stat { mode_ | | | t st_mode; //文件对应的模式，文件 | | | ，目录等（包含对文件的访问权限） ino_t | | | st_ino; //inode节点号 | | | dev_t st_dev; // | | | 设备号码 dev_t st_rdev; | | | //特殊设备号码 nlink_t | | | st_nlink; //文件的连接数 &e | | | msp;uid_t st_uid; //文件 | | | 所有者 gid_t st_gid; | | | //文件所有者对应的组 off_t | | | st_size; //普通文件，对应的文件 | | | 字节数 time_t st_atime; | | | //文件最后被访问的时间 time | | | _t st_mtime; //文件内容最后被修改 | | | 的时间 time_t st_ctime; | | | //文件状态改变时间 blksiz | | | e_t st_blksize; //文件内容对应的块大小& | | | emsp; blkcnt_t st_blocks; | | | //伟建内容对应的块数量}; | +————————————–+————————————–+

---

## 文件类型： {#文件类型：}

- 普通文件
- 目录文件
- 块特殊文件
- 字符特殊文件
- FIFO
- 套接字
- 符号链接
- POSIX允许将进程间通信（IPC）对象说明为文件 IPC类型宏 对象的类型 —————- ————– S_TYPEISMQ 消息队列 S_TYPEISSEM() 信号量 S_TYPEISSHM() 共享存储对象

|判断文件类型的宏|文件类型|
|---|---|
|[[S_ISREG()]]|普通文件|
|[[S_ISDIR()]]|目录文件|
|[[S_ISCHR()]]|字符特殊文件|
|[[S_ISBLK()]]|块特殊文件|
|[[S_ISFIFO()]]|管道或FIFO文件|
|[[S_ISLNK()]]|符号链接文件|
|[[S_ISSOCK()]]|套接字文件|

  
  

---

## 设置用户ID和设置组ID

- 与一个进程相关联的ID有6个或者更多
    
    |ID|ID解析|
    |---|---|
    |[[实际用户ID]]|用于标志我们是谁，在登录时取自口令文件登录项|
    |[[实际组ID]]|用于标志我们是谁，在登录时取自口令文件登录项|
    |[[有效用户ID]]|用于文件访问权限检查|
    |[[有效组ID]]|用于文件访问权限检查|
    |[[所属组ID]]|用于文件访问权限检查|
    |[[保存的设置用户ID]]|由exec函数保存|
    |[[保存的设置组ID]]|由exec函数保存|
    
      
      
    
- 实际用户ID和实际组ID标识我们的身份
- 有效用户ID，有效组ID和所属组ID决定了我们的访问权限
- 保存的设置用户ID和保存的设置组ID在执行程序时包含了有效用户ID和有效组的副本
- 通常有效用户ID等于实际用户ID，有效组ID等于实际组ID  
    ❤可以在文本字模式（st_mode）中设置一个特殊标志位（suid）让当执行此文件时，进程的有效用户ID设置为文件所有者的ID 相应的，可以设置sgid来让有效组ID设置为文件的组所有者ID  
    

## 文件访问权限： {#文件访问权限：}

|st_mode屏蔽|含义|
|---|---|
|[[S_IRUSR]]|用户读|
|[[S_IRGRP]]|组读|
|[[S_IRGOTH]]|其他读|
|[[S_IWUSR]]|用户写|
|[[S_IWGRP]]|组写|
|[[S_IWOTH]]|其他写|
|[[S_IXUSR]]|用户执行|
|[[S_IXGRP]]|组执行|
|[[S_IXOTH]]|其他执行|
|[[+ chmod命令允许我们用u表示用户，g表示组，o表示其他]]||
|[[权限规则：]]||
|[[1. 要打开某一个文件,需要对其从更目录到文件所在目录中间的所有目录都应该具有执行权限(x)(决定能否进入该目录),对于目录，其执行权限（x）常被称为搜索位]]||
|[[2. 读权限允许我们读目录，获取在该文件中所有文件名的列表]]||
|[[3. 对一个文件的读权限决定了我们能否打开现有文件进行读操作，与open函数的O_RDONLY和O_RDWR有关]]||
|[[4. 对一个文件的写操作决定了我们能否打开现有文件进行写操作，与open函数的O_WRONLY和O_RDWR有关]]||

  
  

### 权限对于文件： {#权限对于文件：}

|权限代码|权限|
|---|---|
|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(4)-文件和目录/Untitled Database/r\|r]]|读取一个档案的实际内容|
|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(4)-文件和目录/Untitled Database/w 2\|w 2]]|编辑，新增，修改文件的内容（不包括删除文件的权限）|
|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(4)-文件和目录/Untitled Database/x 2\|x 2]]|该文件是否可以被系统执行|
|[[权限对于目录：]]||
|[[权限代码]]|权限|
|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(4)-文件和目录/Untitled Database/--\|--]]|:-|
|[[r 2]]|读取目标结构清单的权限|
|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(4)-文件和目录/Untitled Database/w\|w]]|建立新的文件与目录,删除已经存在的文件与目录（不管文件的权限如何）,重命名已经存在的文件以及目录　　移动文件以及目录的权限|
|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(4)-文件和目录/Untitled Database/x\|x]]|使用者能否进入该目录并使之成为工作目录|

  
  

## 新文件和目录的所有权

1. 新文件的用户ID为进程的有效ID
2. 新文件的组ID为进程的有限组ID也可以是它所在目录的组ID
    - 对于linux新文件的组ID取决于他所在的目录的组ID是否被设置
        - 如果设置，文件的组ID即目录的组ID
        - 如果未设置，新文件的组ID为进程的组ID

## 函数access和faccessat　<unistd.h>

**描述**：access和faccessat函数以实际用户ID和实际组ID而不是进程ID和进程组ID来进行访问测试`int access(const cahr* pathname,int mode);it faccessat(int fd,const char* pathname,int mode,int flag);`**返回值**：若成功，返回0，若失败，返回-1**mode**： R_OK（读权限测试）　W_OK（写权限测试）　X_OK（执行权限测试）  
★flag参数可以用来改变faccessat函数的行为，如果flag设置为AT_EACCESS，访问检查用的是调用进程的有效用户ID和有效组ID，而不是实际用户ID和实际组ID  

## 函数umask：　<sys/stat.h> ## {#函数umask：-lt-sys-stat-h-gt}

`mode_t umask(mode_t cmask);`　

- umask函数为进程设置文件模式创建屏蔽字，并返回之前的值，（没有出错返回函数）
- cmask由上面6个文件访问权限常量按位或构成
- 在进程创建一个新文件或新目录的时候，通过文件模式创建屏蔽字
- open和creat函数中的参数mode指定了新文件的访问权限位
    - 创建一个新文件或目录时，在文件模式创建屏蔽字为1的位，在文件mode中的相应位被关闭
    - 子进程的umask屏蔽字不影响父进程的umask屏蔽字

## 函数chmod，fchmod，fchmodat <sys/stat.h> {#函数chmod，fchmod，fchmodat-lt-sys-stat-h-gt}

```Plain
`int chmod(const char* pathname,mode_t mode);`   
   在指定的文件上进行操作


`int fchmod(int fd,mode_t mode);`　　
   对已打开的文件进行操作
```

`int fchmodat(int fd,const char* pathname,mode_t mode,int flag);`

- flag参数用于改变fchmodat的值
    - 当设置为AT_SYMLINK_NOFOLLOW时，fchmodat不会跟随符号链接
- 当fd设置为AT_FDCWD时，path为相对路径，否则默认为相对于打开目录（fd）进行查找
- 为了改变一个文件的权限位，进程的有效用户ID必须等于文件的所有者ID，或者具有root权限

|参数mode|说明|
|---|---|
|[[S_ISUID]]|执行时设置用户ID|
|[[S_ISGID]]|执行时设置组ID|
|[[S_ISVTX]]|保存正文粘着位|
|[[S_IRWXU]]|用户读写执行|
|[[S_IRUSR 2]]|用户读|
|[[S_IWUSR 2]]|用户写|
|[[S_IXUSR 2]]|用户执行|
|[[S_IRWXG]]|组读写执行|
|[[S_IRGRP 2]]|组读|
|[[S_IWGRP 2]]|组写|
|[[S_IXGRP 2]]|组执行|
|[[S_IRWXO]]|其他读写执行|
|[[S_IROTH]]|其他读|
|[[S_IWOTH 2]]|其他写|
|[[S_IXOTH 2]]|其他执行|
|[[+ 组执行权限为S表示设置组ID位已经设置，同时，组执行位未设置]]||
|[[+ 只有超级用户才能设置普通文件的粘着位（FreeBSD和Solaris系统中，Mac和Linux无限制（因为对普通文件无意义））]]||

  
  

## 粘着位： {#粘着位：}

设置粘着位之后，当内存中的程序结束之后，并不会完全的将程序释放，而是会将程序部分的副本仍然保存在交换区等待下次使用时快速启动

- 物理内存（RAM）指的是RAM（内存条）提供的临时数据存储空间
- 交换区是指LINUX/UNIX系统前台与后台之间数据交换的场所，即为UNIX/LINIUX的虚拟内存
- 虚拟内存泛指将临时数据存储在磁盘存储器上的技术,(简单说就是划出一部分磁盘作为临时的RAM)

**目录的粘着位**  
如果一个目录设置了粘着位，只有对目录具有写权限并且满足以下条件之一才能删除或者重命名该目录下的文件  

- 拥有此文件
- 拥有次目录
- 是超级用户  
    典型的粘着位目录：/tmp /var/tmp  
    

---

## 函数chown，fchown，fchownat，lchown <unistd.h> {#函数chown，fchown，fchownat，lchown-lt-unistd-h-gt}

`int chown (const char *pathname,uid_t owner,gid_t grouop);int fchown(int fd,uid_t owner,gid_t group);int fchownat(int fd,const char *pathname,uid_t owner,gid_t group,int flag);int lchown(const char *pathname,uid_t owner,gid_t group);`

1. 所引用的文件非符号链接：
    - 四个函数操作类似
2. 所引用的文件是符号链接：
    - lchown和fchownat（设置了AT_SYMLINK_NOFLLOW）更改符号链接本身的所有者，而不是该符号链接所指向的文件的所有者

- 如果owner或者group中有一个为-1，则对应的ID不变
- fchown（同fchmod）针对一个打开的文件改变fd参数指向的打开文件的所有者（不能用于符号链接）

**fchownat对比chown，lchown**

- 如果pathname为绝对地址，或者fd参数设置为AT_FDCWD而pathname设置为相对路径，fchonwat等价于chown，lchown
- 在这两种情况下，如果flag参数中清除了AT_SYMLINK_NOFOLLOWED标志，fchownat和lchown行为相同
- 如果fd参数设置为打开目录的文件描述符，并且pathname为一个相对路径名，fchownat函数计算相对于打开目录的pathname

若_POSIX_CHOWN_RESTRICTED对指定的文件生效则：

1. 只有超级用户进程才能更改该文件的用户ID
2. 如果进程拥有此文件（其有效用户ID等于该文件的用户ID），参数owner等于-1或文件的用户ID，并且参数group等于进程的有效组ID，或进程的附属组ID之一，那么一个非超用户及进程可以更改文件的组ID

- 这意味着当_POSIX_CHOWN_RESTRICTED有效时，不能更改其他用户文件的用户ID，可以改变自己拥有的文件的组ID，但只能更改到自己所属的组
- 如果这些函数由非超级用户进程调用，则在成功返回时，该文件的设置用户ID位和设置组ID位i都被清除

## 文件长度

stat结构成员st_size表示以字节为单位的文件的长度,只对下三种文件有意义

- 普通文件: 文件长度可以是0,读长度为0的文件,将得到EOF提示
- 目录文件 &ems;目录的文件长度一般是个数的整数倍
- 符号链接 文件长度是**文件名**中的实际字节数 因为符号链接文件的长度总是由st_size指示,所以一般不包含C语言中作为名字结尾的null字节

现在UNIX系统提供字段st_blksize和st_blocks,其中第一个是对文件IO较合适的块长度,第二个是所分配的实际512(不一定全部是512字节)字节块的块数

## 文件中的空洞

- 空洞是由所设置的偏移量超过文件的尾端并写入某些数据造成的
- 普通文件可以包含空洞
- 对于没有写过的字节,read函数读到的字节是0
- wc -c可以计算文件中的字符数(字节)
- 如果使用实用程序复制这个文件,那么所有的这些空洞都会被填满,其中  
    实际数据字节皆写0(将原本的空洞用0填充)  
    
- 但文件系统也可以实用若干块来存放指向实际数据块的各个指针(导致实际字节数超过ls报告的大小)

## 文件截断

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hint truncate( const char pathname,off_t length);i nt ftruncate(int fd,off_t length);]]|

  
  

- 这两个函数将一个现有文件长度截断为length。
- 如果该文件以前的长度大于length，length以外的数据不能访问
- 如果以前的长度小于lengh，文件长度增加，在以前文本尾端和新文件的尾端之间的数据读为0（也就是可能在文件中创建了一个空洞）

## 文件系统

磁盘，分区和文件系统  
一个磁盘分为一个或多个分区  
每个分区可以包含一个文件系统  

[![](https://www.notion.so../pictures/filesystem1)](https://www.notion.so../pictures/filesystem1)

picture

**普通文件的链接计数**  
节点是固定长度的记录项，他包含有关文件的大部分信息  

每个节点都有一个链接计数，其值是指向该i节点的目录项数  
只有当链接计数减小到0时才可删除此文件(可以释放该文件所占据的磁盘块)  
在stat结构中，链接计数包含在st_nlink成员中，其基本系统数据类型是nlink_t.(硬链接)  

符号链接

符号链接的实际内容（在数据块中）包含了该符号链接所指向的文件的名字,通过判断i节点中的文件类型是S_IFLNK,于是系统直到这是一个符号链接

[![](https://www.notion.so../pictures/filesystem2)](https://www.notion.so../pictures/filesystem2)

picture

i节点包含了文件有关的所有信息：文件类型，文件访问权限位，文件长度和指向文件数据块的指针等

stat结构中大多数信息取自i节点，只有两项重要数据存放在目录项中：文件名和i节点编号（inode）  
i节点的编号的数据类型是ino_t  

目录项中的i节点编号取自同一文件系统中的相应i节点，一个目录项不能指向另一个文件系统的i节点（ln命令不能跨文件系统）

[![](https://www.notion.so../pictures/filesystem3)](https://www.notion.so../pictures/filesystem3)

mv命令，在不更换文件系统情况下，重命名（移动）并不改变文件的实际内容与位置，只需构造一个指向现有i节点的新目录项并删除旧的目录项（链接计数不会改变）

**目录文件的链接计数**  
目录是包含目录项的文件（文件名和相应的i节点编号）  

i节点指向目录项，目录项包含文件名和对应的i节点编号，其中有两个特殊的文件，分别为当前目录以及上层目录，其中根据文件名（代表目录）对应的i节点编号指向i节点，i节点继续指向目录项从而构成逐级目录，  
最底层目录链接计数至少为2（.代表当前目录，以及上层目录中的文件名指向）  

上层目录链接计数至少为3（.代表当前目录，以及上层目录中的文件名指向，和下层目录的..上层目录指向）  
父目录中的每一个子目录使父目录的链接计数加1  

## 函数link，linkat，unlink，unlinkat，remove {#函数link，linkat，unlink，unlinkat，remove}

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hint link(cons t char existingpath,const charnewp ath);int linkat(int efd,const char existingpath,int nfd,const char new path,int flag);]]|

  
  

返回值：成功返回0，出错，返回-1  
创建一个指向现有文件的里链接  
创建一个新目录项，它会引用现有文件existingpath  

对于linkat函数，现有文件通过efd和existingpath指定，新的路径名通过nfd和newpath指定  
如果两个文件描述符中任一个设置为AT_FDCWD则路径名通过相对于当前目录的相对路径来计算  
如果路径名以绝对路径描述，则相对应的文件描述符参数会被忽略  

当现有文件是符号链接时，由flag参数控制linkat函数是创建指向现有符号链接还是创建指向现有符号链接所指向的文件的链接，如果哦flag参数设置AT_SYMLINK_FOLLOW，则创建指向符号链接目标的链接，如果这个标志被清除，则创建一个指向符号链接本身的链接

|Column 1|Column 2|
|---|---|
|1234|[[include unistd.hint unlink(co nst char pathname);int unlinkat(int fd,const char pathname,int flag); 两个函数的返回值：成功返回0，失败返回 -1]]|

  
  

- 这两个函数删除目录项，并且将由pathname所引用的文件的链接数减1
- 为了解除文件的链接，必须对包含目录项的文件具有写和执行权限；如果对目录设置了粘着位，则必须对目录具有写权限并且具有以下三个条件之一
    - 拥有该文件
    - 拥有该目录
    - 具有超级用户权限
- 只有当链接计数达到0时该文件的内容才能删除
- 如果进程打开文件，也不能删除该文件  
    ★关闭一个文件时，内核会先检查打开文件的进程数，如果这个计数为0，内核再去检查链接计数，如果也为0，则删除文件内容  
    - 通过unlink的这种特性，可以确保当程序崩溃时，它所创建的临时文件也不会被遗留（打开或新建文件后马上调用unlink函数将链接数变为0，但文件由于正在被占用，所以不会被删除，当程序不正常退出时，内核检查到链接数为0，自动的将其删除）
- 如果parhname为符号链接的话那么unlink删除该符号链接，而不是来年接引用的文件名，在给出符号链接名的情况下，没有一个函数能删除由链接引用的文件
    
    |Column 1|Column 2|
    |---|---|
    |12|[[include stdio.hint remove (co nst char pathname);]]|
    
      
      
    
- 对于文件，remove功能与unlink相同，对于目录，remove与rmdir命令相同
    
    ## 函数rename，renameat　<stdio.h> {#函数rename，renameat-lt-stdio-h-gt}
    
    |Column 1|Column 2|
    |---|---|
    |12|[[int rename(const char oldname, const char newname);inr renameat(in t oldfd,const char oldname,int newf d,const char newname);]]|
    
      
      
    
- 如果oldname指的是一个文件而不是一个目录，那么为该文件或符号链接重命名
    - 如果newname已经存在，而且不是一个目录，则先将该目录项删除，然后将oldname重命名为newname
- 如果oldname为一个目录，那么为该目录重命令
    - 如果newname已经存在，则它必须引用一个目录，而且该目录应该为一个空目录
    - 如果newname已经存在（而且是一个空目录），则先将其删除，然后将oldname重命名为newname
    - 并且在为这个目录串重命名时，不能包含oldname作为其路径前缀，会导致循环目录
- 如果oldname或newname应用符号链接，则处理符号链接本身，而不是它应用的文件
- 不能对/.和/..重命名
- 如果oldname和newname引用同一个文件，则函数不做任何更改

**权限问题**

- 如果newname已经存在，则调用进程需要对他有写权限
- 调用进程需要删除oldname，并创建newname目录项，所以需要它对包含oldname和newname的目录具有写和执行权限

## 符号链接

- 符号链接是对一个文件的简介指针
- 硬链接直接指向文件的i节点
- 硬件链接通常要求链接和文件在统一文件系统中
- 只有超级用户才能创建指向目录的硬链接
- 符号链接对指向何种对象无任何文件系统的限制
- 任何用户都可创建指向目录的符号链接
- 符号链接一般用于将一个文件或整个目录结构移动到系统的另一个位置

|函数|不跟随符号链接|跟随符号链接|
|---|---|---|
|[[access]]||*|
|[[chdir]]||*|
|[[chmod]]||*|
|[[chown]]||*|
|[[creat]]||*|
|[[exec]]||*|
|[[lchown]]|*||
|[[link]]||*|
|[[lstat]]|*||
|[[open]]||*|
|[[opendir]]||*|
|[[pathconf]]||*|
|[[readlink]]|*||
|[[remove]]|*||
|[[rename]]|*||
|[[stat]]||*|
|[[truncate]]||*|
|[[unlink]]|*||
|[[创建读取符号链接]]|||

  
  

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hint symlink(c onst actualpath,const char sympath );int symlinkat(const char actualpa th,const char sympath);]]|

  
  

- 在创建符号链接时不需要actualpath已经存在
- actualpath与sympath不要求在同一个文件系统中

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hssize_t readl ink(const char restrict pathname,ch ar restrict buf,size_t bufsize);ssi ze_t readlinkat(int fd,const char r strict pathname,char restrict buf,s ize_t bufsize);]]|

  
  

- 这两个函数打开链接本身，并读取链接中的名字

## 文件时间

|字段|说明|例子|ls(1)选项|
|---|---|---|---|
|[[st_atim]]|文件数据的最后访问时间|read|-u|
|[[st_mtim]]|文件数据的最后修改时间|write|默认|
|[[st_ctim]]|i节点状态的最后更改时间|chomd，chown|-|

  
  

- 修改时间(st_mtim)是文件内容最后一次被修改的时间
- 状态更改时间(st_ctim)是该文件的i节点最后一次被修改的时间
- i节点中的所有信息与文件的实际内容是分开存放的
- 系统并不维护对i节点的最后一次访问时间

**各种函数对访问，修改和状态更改时间的作用**  
| 函数 | 引用的文件或目录 | 所引用的文件或父目录 |  
| :— | :————— | ——————– |  
| 函数 | 引用的文件或目录 | 所引用的文件或父目录 |  

|函数|a|m|c 1|a 1|m 1|c|
|---|---|---|---|---|---|---|
|[[chmod,fchmod]]|||*||||
|[[chown,fchown]]|||*||*|*|
|[[creat(O_CREAT新文件)]]|*||||||
|[[creat(O_TRUNC现有文件)]]||*|*||||
|[[exec 2]]|*||||||
|[[lchown 2]]|||*||||
|[[link(第二个参数的父目录)]]|||*||*|*|
|[[mkdir]]|*|*|*||*|*|
|[[mkfifo]]|*|*|*||*|*|
|[[open(O_CREAT新文件)]]|*|*|*||*|*|
|[[open(O_TRUNC现有文件)]]||*|*||||
|[[pipe]]|*|*|*||||
|[[read]]|*||||||
|[[remove 2]]|||*||*|*|
|[[remove 3]]|||||*|*|
|[[rename 2]]|||*||*|*|
|[[rmdir]]|||||*|*|
|[[truncate,ftruncate]]||*|*||||
|[[unlink 2]]|||*||*|*|
|[[utimes,utimesat]]||*|*||||
|[[futimens]]|||||||
|[[write]]||*|*||||

  
  

## 函数futimens，utimensat，utime　<sys/stat.h> {#函数futimens，utimensat，utime-lt-sys-stat-h-gt}

**POSIX**

|Column 1|Column 2|
|---|---|
|123|[[include sys-stat.hint futimen s(int fd,const struct timespec times 2);int utimeensat(int fd,const cha r path,const struct timespec times 2,int flag);]]|

  
  

futimens函数需要打开文件来更改时间  
utimensat函数根据文件名来更改文件时间  
*  
_SUS *_

|Column 1|Column 2|
|---|---|
|12|[[include sys-time.hint utimes( const char pathname,const struct ti meval times2);]]|

  
  

utimes函数针对路径名进行操作

|Column 1|Column 2|
|---|---|
|1234|[[struct timespec{ time_t tv_sec; --seconds long tv_nsec; --mocroseconds};]]|

  
  

times数组参数的第一个元素包含访问时间，第二个元素包含修改时间（这两时间是自特定时点（1970年1月1日00：00：00）以来经过的秒数，不足秒的部分用纳秒表示）

★没有函数对时间st_ctim(i节点最近被修改的时间),应为调用utimes时,此字段自动更新

- fd的特殊参数AT_FDCWD：强制通过相对于调用进程的当前目录计算pathname
- flag参数如果设置为AT_SYMLINK_NOFOLLOW，则更改符号链接的时间，默认跟随符号链接

**时间戳的指定**

- 如果times是一个空指针，则访问时间和修改时间两者都设置为当前时间
- 如果times参数是指向两个timespec结构的数组，任一数组元素的tv_nsec的字段为UTIME_NOW，相应的时间戳就设置为当前时间，忽略相应的tv_sec字段
- 如果times参数指向来嗯个timespec结构的数组，任一数组元素tv_nsec字段的值为UTIME_OMIT，相应的时间戳保持不变，忽略相应的tv_sec字段
- 如果times参数是指向两个timespec结构的数组，任一数组元素的tv_nsec的字既不是UTIME_NOW也不是UTIME_OMIT，则相应的时间戳设置为相应的tv_sec和tv_nsec字段的值

**权限**

- 如果times是一个空指针，或者任一tv_nsec字段设置为UTIME_NOW则进程的有效用户id必须等于该文件的所有者id；进程对该文件必须具有写权限，或者为root权限
- 如果times为非空指针，并且任一tv_nsec字段的值既不是UTIME_NOW也不是UTIME_OMIT，则进程的有效用户id必须等于该文件的所有者id，或者进程必须是一个root进程，仅有写权限是不够的
- 如果times是非空指针，并且两个tv_nsec字段的值都是UTIME_OMIT，就不进行权限检查

## 函数mkdir，mkdirat，rmdir　<sys/stat.h> {#函数mkdir，mkdirat，rmdir-lt-sys-stat-h-gt}

|Column 1|Column 2|
|---|---|
|123|[[include sys-stat.hint mkdir(c onst char pathname,mode_t mode);int mkdirat(int fd,const char pathname ,mode_t mode);]]|

  
  

这两个函数创建一个空目录,所指定的文件访问权限mode由进程的文件模式创建屏蔽字修改  
对于目录通常至少要设置一个执行权限位以允许访问目录中的文件名  

|Column 1|Column 2|
|---|---|
|12|[[include unistd.hint rmdir(con st char pathname);]]|

  
  

rmdir函数可以删除一个空目录

- 如果调用此函数使得目录的链计数位0,并且没有其他进程打开此目录,则释放该目录所占用的空间
- 如果在链接计数达到0时,由一个或多个进程打开此目录,再则在此函数返回前删除最后一个链接.和..项并且在此目录中不能创建新文件但是在最后一个进程关闭他之前不会释放此目录

## 读目录

|Column 1|Column 2|
|---|---|
|123456789101112|[[include include include include include include include include include include include include include include include include include include include include include include include include include...]]|

  
  

|Column 1|Column 2|
|---|---|
|1234|[[struct dirent{ino_t d_ino;char d _name;}]]|

  
  

DIR结构是一个内部结构，上述函数用此结构保存正在读的目录的有关信息

fopendir可以把打开文件描述符转换成目录处理函数需要的DIR结构

由opendir和fopendir返回的指向DIR结构的指针由另外5个函数使用，opendir执行初始化操作，使得第一个readdir返回目录中的第一个目录项，DIR结构由fopendir创建时，readdir返回的第一项取决于传给fdopendir函数的文件描述符相关联的文件偏移量

## 函数chdir，fchdir，getcwd　<unistd.h> {#函数chdir，fchdir，getcwd-lt-unistd-h-gt}

|Column 1|Column 2|
|---|---|
|1234|[[includeint chdir(const chr pat hname);int fchdir(int fd); 返回值：成功返回0.出错返回-1]]|

  
  

当前工作目录是进程的一个属性

每个程序运行在独立的进程中，shell的当前工作目录并不会随程序调用chdir额改变，如果改变应该是shell直接调用chdir函数

内核为每个进程值保存指向该目录V节点的指针等目录本身的信息，并不保存目录的完整路径名

|Column 1|Column 2|
|---|---|
|12|[[char getcwd(char buf,size_t si ze);返回值：成功返回buf，出错返回NULL]]|

  
  

getcwd函数可以由当前目录找到上层目录下的路径（当前目录/.下的/..中的i节点编号与工作目录的i节点编号对比），直到找到以/开头的完整路径

buf：缓冲区地址，size：缓冲区长度（得容纳下完整路径名加上一个nul字节）  
符号链接能从山而下，但不能从下而上，通过/..无法跳转到符号链接  

## 设备特殊文件

- 每个文件系统所在的存储设备都是由主次设备号表示
- 设备号所用的数据类型是基本系统数据类型dev_t
- 主设备号标识设备驱动成功程序，有时编码为与其通信的的外设板
- 次设备号标识特定的字设备
- 通常用两个宏major和minor来访问主次设备号
- 系统中与每个文件名相关联的st_dev值是文件系统的设备号，该文件系统包含了这一文件名和他对应的i节点
- 只有字符设备和块特殊文件才有st_rdev值，此值包含实际设备的设备号

## 文件访问权限小结

S_IRWXU=S_IRUSR| S_IWUSR| S_IXUSR  
S_IRWXG=S_IRGRP| S_IWGRP| S_IXGRP  
S_IRWXO=S_IROTH| S_IWOTH| S_IXOTH  

|常量|说明|对普通文件的影响|对目录的影响|
|---|---|---|---|
|[[S_ISUID 2]]|设置用户ID|执行时设置有效用户iID|（未使用）|
|[[S_ISGID 2]]|设置组ID|若组执行位设置，则执行时设置有效用户ID否则使强制性锁起作用|将在目录中创建的新文件和的组ID设置为目录中的组ID|
|[[S_ISVTX 2]]|粘着位|在交换区缓存程序正文|阻止在目录中删除和重命名文件|
|[[S_IRUSR 3]]|用户读|许可用户读文件|许可用户读目录项|
|[[S_IWUSR 3]]|用户写|许可用户写文件|许可用户在目录中删除和创建文件|
|[[S_IXUSR 3]]|用户执行|许可用户执行文件|许可用户在目录中搜索给定路径名|
|[[S_IRGRP 3]]|组读|许可组读文件|许可组读目录项|
|[[S_IWGRP 3]]|组写|许可组写文件|许可组在目录中删除和创建文件|
|[[S_IXGRP 3]]|组执行|许可组执行读文件|许可组在目录中搜索给定路径名|
|[[S_IROTH 2]]|其他读|许可其他读文件|许可其他读目录项|
|[[S_IWOTH 3]]|其他写|许可其他写文件|许可用户在目录中删除和创建文件|
|[[S_IXOTH 3]]|其他执行|许可其他执行文件|许可其他在目录中搜索给定路径名|
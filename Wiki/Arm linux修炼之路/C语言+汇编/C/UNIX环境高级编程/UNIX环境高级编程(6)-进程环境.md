# 概述

- 说明一个进程是如何启动和终止的，如何向其传递参数表和环境
- 虽然参数表和环境都不是由内核进行解释的，但内核起到了从exec的调用将这两者传递给新进程的作用
- 说明了C语言的典型存储空间布局，以及一个进程是如何动态的分配和释放存储空间
- setjmp和longjmp函数提供一种在进程内非局部转移的方法
- 各种实现提供的资源限制功能

# main函数

原型：`int main(argc,char\*argv[]);`

- argc是命令行参数的个数
- argv是指向各个参数的各个指针所构成的数组  
    内核使用exec函数来执行C程序，在调用main之前先调用一个特殊的启动例程，启动例程从内核取得命令行参数以及环境变量，可执行程序文件将此启动例程指定为程序的起始地址（这是由连接编辑器设置的，而链接编辑器由C编译器调用）  
    
    # 进程终止
    
    正常终止：
    

1. 从main返回
2. 调用exit
3. 调用_exit或Exit
4. 最后一个线程从其启动例程返回
5. 从最后一个线程调用pthread_exit  
    异常终止：  
    
6. 调用abort
7. 接到一个信号
8. 最后一个线程对取消请求作出的回应

启动例程：  
启动例程使得从main返回后立即调用exit函数，经常用汇编代码编写，C余个格式可能为  
`exit(main(argc,argv));`

## 退出函数

|Column 1|Column 2|
|---|---|
|12345|[[include stdio.hvoid exit(int status); ISO C标准void _Exit (int status); ISO C标准inc lude unistd.hvoid _exit(int status ); POSIX C标准]]|

  
  

_exit和_Exit立即进入内核，exit则先执行一些清理处理，再返回内核

int status称为终止状态（或退出状态 exit status）  
如果  

> 调用这些函数时不带终止状态  
> 或main执行了一个没有返回值的return语句  
> 或main函数没有声明返回类型为整数  

则该进程的终止状态是未定义的  
但是若main函数的返回类型是整数，并且main执行到最后一条语句时返回（隐式返回）则进程的终止状态为0  

exit(0);等价于return(0);

# atexit函数

一个进程可以登记多至32个函数，这些函数将由exit自动调用，我们称这些函数为终止处理函数（exit handler）并调用atexit函数来登记这些函数，exit函数调用这些函数的顺序与登记的顺序相反，同一个程序被登记多次也会被调用多次

|Column 1|Column 2|
|---|---|
|12|[[include stdlib.hint atexit(vo id (func)(void));]]|

  
  

atexit的参数是一个函数指针，当调用此函数时无需要向它传递任何参数，也不期望它返回一个值

一个C语言启动与终止的流程

[![](https://www.notion.so../pictures/process1)](https://www.notion.so../pictures/process1)

理解：

1. 内核首先调用一个特殊的启动例程，启动例程从内核取得命令行参数以及环境变量，可执行程序文件将此启动例程指定为程序的起始地址（这是由连接编辑器设置的，而链接编辑器由C编译器调用）从而为调用main函数做好支持
2. 内核调用exec函数执行main函数
3. main函数执行结束之后立即调用exit函数来使进程终止
4. 进程通过atexit()函数来登记终止处理函数
5. exit函数首先自动调用进程终止函数，然后关闭（通过fclose）所有打开流  
    补充：  
    进程自愿终止的唯一方法是显式或隐式的调用exit或_exit或_Exit  
    进程也可以非自愿的由一个信号使其终止  
    

# 命令行参数

当执行一个程序时，调用exec的进程可以将命令行参数传递给该新程序  
main函数的定义要写成  
`int main(int argc,char *argv[])`  
ISO C 和POSIX.1都要求argv[argc]是一个空指针  

# 环境表

全局变量environ`extern char **environ;`  
每个程序保有一张环境表，与参数表(char *argv[])一样也是一个字符指针数组，其中每个指针包含一个以NULL为结尾的C字符串的地址，environ全局变量包含了该指针数组的地址  
环境由  
`name=value`这样的字符串组成，大多数预定义的完全由大写字母组成（惯例）

通常使用getenv和putenv函数来访问特定的环境变量，但是如果要查看整个环境则必须使用environ指针

# C程序的存储空间布局

[![](https://www.notion.so../pictures/process2)](https://www.notion.so../pictures/process2)

“图片”

- 未初始化数据段并不存放在磁盘程序文件中，原因是内核在程序开始运行前将他们都设置为0，需要存放在磁盘程序文件中的段只有正文段和初始化数据段  
    size（1） 命令报告正文段，数据段和bss段的长度（以字节为单位）  
    

**C程序的组成**

1. 正文段  
    cpu执行的机器指令部分正文段可共享正文段常常是只读的，防止程序异常而修改指令  
    
2. 初始化数据段
    - 包含程序中需要明确地赋初值的变量
3. 未初始化数据段
    - 通常将此段称为bss段（意思为由符号开始的块（block started by symbol)）在程序开始执行前，内核将此段中的数据初始化为0或空指针
4. 栈
    - 自动变量以及每次函数调用时所需保存的信息都存放在此字段中
    - 每次函数调用时，其返回地址以及调用者的环境信息都存放在栈中
    - 最近被调用的函数在栈上为自动或临时变量分配存储空间
5. 堆
    - 通常在堆中进行动态内存分配，由于历史惯例，堆位于未初始化数据段于栈之间

# 共享库

- 共享库使得可执行文件中不需要包含公有的库函数，只需要在所有进程均可引用的存储区中保存该库例程的副本
- 程序第一次执行或者第一次调用某个库函数的时后，用动态链接的方法将程序于共享库函数链接起来
- 减小可执行文件的长度，增加了一些运行时间开销（主要在程序第一次被执行时，或每个共享库第一次被调用的时候）
- 可以直接更新库函数而不许对函数重新进行链接编辑
    
    # 存储空间分配
    
    |Column 1|Column 2|
    |---|---|
    |1234567|[[Wiki/Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(6)-进程环境/Untitled Database/include include include include include include include include include include include include include include include include include include include include include include include include include...|include include include include include include include include include include include include include include include include include include include include include include include include include...]]|
    
      
      
    
- 返回的地址一定是对齐的
- 不需要显式的执行强制类型转换（还是强制类型转换）
- 未声明的函数的默认返回值为int，使用没有正确的函数声明的强制类型转换可能会隐藏系统错误
- free函数释放ptr指针指向的存储空间，被释放的空间进入可用存储池
- 这些分配例程通常使用sbrk(2)系统调用实现，该系统调用扩充（或缩小）进程的堆
- sbrk可以增缩进程空间，但是大多数的calloc和malloc函数并不会缩减进程的存储空间，而是将他们保存在malloc池中而不返回内核以供以后再分配
- 大多数实现所分配的空间会比所要求的空间大一些，额外的空间来记录管理信息–分配块的长度，指向下一个分配块的指针
- 在动态分配的缓冲区前或后进行写操作破坏的可能不仅仅是该区的管理信息，在动态分配的缓冲区前后的存储空间很可能用于其他动态分配的对象
- 其他可能产生致命错误的原因
    - 释放一个已经释放了的块
    - 调用free时所使用的指针不是三个alloc函数的返回值
- 内存泄露：一个进程调用alloc函数但是没有调用free函数，导致该进程占用的存储空间就会连续增加

## 替代的存储空间分配程序

1. libmalloc库
    - libmalloc库提供了一套与ISO C存储空间分配函数相匹配的接口
    - libmalloc库包含mallopt函数，它使进程可以设置一些变量并用他们来控制存储空间分配程序的操作
    - 还包含mallinfo韩寒素，对存储空间分配程序的操作进行统计
2. vmalloc库
    - 说明一种存储空间分配程序，允许进程对于不同的存储区使用不同的技术
    - 该库还提供ISO C存储空间分配函数的仿真器
3. quick-fit
    - 该算法基于将存储空间分裂成各种长度的缓冲区，并将未使用的缓冲区按其长度组成不同的空闲区列表，比上述两种算法快，但是占用较多存储空间
4. jemalloc
    - 库函数malloc在FreeBSD中的实现，可用于多处理器系统中使用多线程的应用程序
5. TCMalloc
    - 该函数用于替代malloc函数族以提供高性能，高扩展性以及高存储效率
    - 从高速缓存中分配缓冲区以及释放缓冲区到高速缓存中，使用线程—本地高速缓存来避免开销
    - 有内置的堆检查程序和堆分析程序帮忙调试和分析动态存储的使用
6. 函数alloca
    - alloca函数与malloc函数相似，调用序列与malloc相同，但是alloca在当前函数的栈帧上分配存储空间，而不是在堆中
        - 优点：当函数返回时，自动释放它所使用的栈帧，所以不需要操心释放空间
        - 缺点： 增加了栈帧的长度，而某些系统不支持在函数调用后增加栈帧的长度，所以不支持alloca函数

# 环境变量

环境字符串的形式： name=value

读取环境变量值：

|Column 1|Column 2|
|---|---|
|123|[[include stdio.hchar getenv(c onst char name); 返回值：指向与name关联的value指针，若未找到返回NULL]]|

  
  

**attention**：应当使用getenv从环境中取出一个指定环境变量的值，而不是直接访问environ

**SUS 定义的环境变量**  
变量|POSIX.1|FreeBSD|linux|Mac OS|Solaris|说明  
:-|:-:|:-:|:-:|:-:|:-:|:-  
COLUMNS|  
_|_|_|_|_|终端宽度  
DATEMSK|XSI|  
_|_|_|_|getdate模板文件路径名  
HOME|  
_|_|_|_|_|home起始目录  
LANG|  
_|_|_|_|_|本地名  
LC_ALL|  
_|_|_|_|_|本地名  
LC_COLLATE|  
_|_|_|_|_|本地排序名  
LC_CTYPE|  
_|_|_|_|_|本地字符分类名  
LC_MESSAGES|  
_|_|_|_|_|本地消息名  
LC_MONETARY|  
_|_|_|_|_|本地货币编辑名  
LC_NUMERIC|  
_|_|_|_|_|本地数字编辑名  
LC_TIME|  
_|_|_|_|_|本地日期/时间格式名  
LINES|  
_|_|_|_|_|终端高度  
LOGNAME|  
_|_|_|_|_|登录名  
MSGVERB|XSI|  
_|_|_|_|fmtmsg处理的消息组成部分  
NLSPATH|  
_|_|_|_|_|消息类模板序列  
PATH|  
_|_|_|_|_|搜索可执行文的路径前缀列表  
PWD|  
_|_|_|_|_|当前工作目录的绝对路径名  
SHELL|  
_|_|_|_|_|用户首选的shell名  
TERM|  
_|_|_|_|_|终端类型  
TMPDIR|  
_|_|_|_|_|在其中创建临时文件的目录路径名  
TZ|  
_|_|_|_|*|时区信息

**设置环境变量**(我们能影响的只是当前进程及其后生成和调用的任何子进程的环境，但不能影响父进程的环境)

|Column 1|Column 2|
|---|---|
|123456|[[include stdlib.hint putenv(ch ar str); 返回值：成功返回0，出错返回非0；int setenv (const char name.const char value, int rewrite);int unsetenv(const char name); 两个函数返回值：成功返回0.出错返回-1；]]|

  
  

- putenv取形式为name=value的字符串，将其放到环境变量中
    - 如果name已存在则先删除原来的定义
- setenv将name设置为value,如果环境中name已经存在，则
    - 若rewrite非0.则首先删除其现有的定义
    - 若rewrite为0，则不删除其现有的定义（name不设置为新的value，而且也不出错）
- unsetenv删除name的定义
    - 即使不存在也不会出错

**区别**

- setenv必须分配存储空间，以便依据其参数创建name=value的字符串
- putenv可以自由的将他的参数字符串直接放到环境中

环境表和环境字符串通常放在进程存储空间但顶部（栈之上）**删除一个指针**  
删除一个字符串只需先在环境表中找到该指针，然后将所有后续的指针都向环境表首部顺次移动一个位置  
**修改一个现有的name**

- 如果新的value长度少于或等于现有value长度，则只需要将新的字符串复制到原字符串所在的空间
- 如果新的value长度大与原长度，则必须调用malloc为新字符串分配空间，然后将新字符串复制到该空间，接着使环境表中的针对name的指针指向新分配区

**增加一个新的name**

- 首先必须调用malloc为name=value字符串分配空间，然后将该字符串复制到次空间中
- 如果是第一次增加一个新的name，则必须调用malloc为新的指针表分配空间（在堆中分配），将原来的环境表变（不是环境表量，环境变量仍然在栈之上）（一般情况，环境表存放在栈上面）量复制到新的分配区，并将指向新name=value字符串的指针存放在该指针表的表尾，然后又将一个空指针存放在后面。
- 如果不是第一次增加一个新name，可知之前已经调用malloc在堆中分配了空间，则只需要调用realloc以分配一个比原空间多存放一个指针的空间，然后将指向name=value字符串的指针存放在该表表尾，后面接一个空指针
    
    # 函数setjmp和longjmp
    
- 在C语言中，goto语句不能跨越函数而执行这种类型跳转功能的函数是setjump和longjump函数，这两个函数有助于**处理发生在很深层嵌套函数调用中的出错情况**
- 自动变量的存储单元在每个函数的栈帧中
- 如果系统对栈没有提供特殊的硬件支持，则C的实现需要用链表实现栈帧
    
    |Column 1|Column 2|
    |---|---|
    |12345|[[非局部goto函数：指的是不是用普通的C语言goto语句在一个函 数内实现跳转，而是在栈上跳过若干调用帧，返回当前函数调用路径上的一个函数 中include setjmp.hint setjmp(jmp_b uf env); 返回值：若直接调用， 返回0，若从longjmp返回，则为val值 void longjm p(jmp_buf env ,int val);]]|
    
      
      
    
- 在需要返回的地方调用setjmp
- 在出错返回的地方调用longjmp
- 参数env是一个特殊类型的jmp_buf，是一个某种类型的数组，其中存放调用longjmp时能用来恢复栈状态的所有信息，由于longjmp和setjmp在不同函数中，所以需要将env设置为全局变量
- 参数val是从setjmp处返回的值，原因是岁与一个setjmp可以有多个longjmp，通过setjmp返回的val值可以确定程序出错返回的位置。

**自动变量，寄存器变量，和易失变量**

当调用longjmp之后，大多数系统实现并不回滚自动变量和寄存器变量的值，而所有标准则称他们的值是不确定的，如果有一个自动变量，但是又不想使值回滚，则可定义它为volatile属性，声明为全局变量或静态变量的值在执行longjmp时保持不变

关于自动变量的基本规则：在声明自动变量的函数已经返回后，不能再引用这些自动变量

当调用函数返回后，它在栈上所使用的空间将由下一个被调用的函数使用，但是如果由于种种原因(eg:IO缓冲之类)使得栈中内存没有释放就会导致混乱，解决方法是在全局存储空间静态的或动态的为该内存空间分配内存

# 函数getrlimit和setrlimit

**查询和修改进程的资源限制** **SUS XSI扩展**

|Column 1|Column 2|
|---|---|
|123|[[include sys-resource.hint get rlimit(int resource,struct rlimit r lptr);int setrlimit(int resource,con st struct rlimit rlptr);]]|

  
  

每一次调用都需要指定一个资源和指向rlimit结构的指针

|Column 1|Column 2|
|---|---|
|12345|[[struct rlimit{ rlimit rlim_cur; --soft limit-current limit rli mit rlim_max; --hand limit-maximu n value for rlim_cur;}]]|

  
  

更改资源限制的规则：

1. 任何一个进程都可将一个软限制值更改为小于或等于其硬限制值
2. 任何一个进程都可降低其硬限制值，但它必须小于或等于其软限制值，这种降低对普通用户是不可逆的
3. 值有root用户进程可以提高硬限制值

**resouce参数注解**  
resource|注解  
:-|:-  
RLIMIT_AS|进程总的可用存储空间的最大长度，影响sbrk和nmap  
RLIMIT_CORE| core文件的最大字节数，为0则阻止创建core文件  
RLIMIT_CPU|cpu的最大时间量值（秒）超过此限制，向进程发送SIGXCPU信号  
RLIMIT_DATA|数据段的最大字节长度（初始化数据，非初始化数据，以及堆的总和）  
RLIMIT_FSIZE|可以创建的文件的最大字节长度，超过限制发送SIGXFSZ信号  
RLIMIT_MEMLOCK|一个进程使用mlock能够锁定再内存空间中的最大字节长度  
RLIMIT_MSGQUEUE|进程为POSIX消息队列可分配的最大存储字节数  
RLIMIT_NICE|影响进程的调度优先级的nice值可设置的最大限制  
RLIMIT_NOFILE|每个进程能够打开的最多文件数  
RLIMIT_NPORC|每个实际用户id可拥有的最大子进程数  
RLIMIT_NPTS|用户可同时打开的伪终端的最大数量  
RLIMIT_RSS|最大驻内存集字节长度，如果可用的物理存储器很少，则内核从进程处取出RSS部分  
RLIMIT_SBSIZE|再任一给定时刻，一个用户可以占用的套接字缓冲区的最大长度  
RLIMIT_SIGPENDING|一个进程可排队的信号最大数量，此限制有sigqueue函数实施  
RLIMIT_STACK|栈的最大字节长度  
RLIMIT_SWAP|用户可消耗的交换空间的最大字节数  
RLIMIT_VMEN|与RLIMIT_AS同义  

**resource参数对资源限制的支持**  
限制|XSI|FreeBSD|Linux|Mac OS|Solaris  
:-|:-:|:-:|:-:|:-:|:-:  
RLIMIT_AS|  
_|_|_||_  
RLIMIT_CORE|  
_|_|_|_|*  
RLIMIT_CPU|  
_|_|_|_|*  
RLIMIT_DATA|  
_|_|_|_|*  
RLIMIT_FSIZE|  
_|_|_|_|*  
RLIMIT_MEMLOCK|  
_|_|_|_|  
RLIMIT_MSGQUEUE|||  
_||  
RLIMIT_NICE|||  
_||  
RLIMIT_NOFILE|  
_|_|_|_|*  
RLIMIT_NPORC||  
_|_|_|  
RLIMIT_NPTS||  
_|||  
RLIMIT_RSS||  
_|_|_|  
RLIMIT_SBSIZE||  
_|||  
RLIMIT_SIGPENDING|||  
_||  
RLIMIT_STACK|  
_|_|_|_|_  
RLIMIT_SWAP||  
_|||  
RLIMIT_VMEN|||||  
_
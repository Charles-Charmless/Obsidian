# 环境搭建

首先得有一个带有gcc编译器的linux系统，然后就是新手很容易碰到的一个的坑，此书的几乎所有的程序均包含”apue.h”这个头文件，但是这个头文件并不是标准库所包含的，所以需要自己编译apue.3e这个程序，并将生成的头文件和库文件拷贝到系统中然后在编译程序时指定链接文件即可（用-l参数）

1. 下载apue源文件 `wget http://www.apuebook.com/src.3e.tar.gz`
2. 解压 `tar -zxf ./src.3e.tar.gz`
3. 解决依赖关系
    - `wget http://elrepo.reloumirrors.net/testing/el6/x86_64/RPMS/libbsd-0.2.0-4.el6.elrepo.x86_64.rpm`
    - `wget http://elrepo.reloumirrors.net/testing/el6/x86_64/RPMS/libbsd-devel-0.2.0-4.el6.elrepo.x86_64.rpm`
    - `sudo yum localinstall libbsd-0.2.0-4.el6.elrepo.x86_64.rpm`
    - `sudo yum localinstall libbsd-devel-0.2.0-4.el6.elrepo.x86_64.rpm`
4. 编译`make`
5. 将编译出来的库放到合适位置`cp include/apue.h /usr/include/ && cp lib/libapue.a /usr/lib`

---

# ISO C

> [!info] C標準函式庫  
> C 標準函式庫（C standard library，缩写：libc）是在 C語言程式設計中，所有符合標準的 头文件（head file）的集合，以及常用的 函式庫實作程序（如 I/O 輸入輸出和 字串控制）。不像 COBOL、 Fortran 和 PL/I等 程式語言，在 C 語言的工作任務裡不會包含嵌入的 關鍵字 ，所以幾乎所有的 C 語言程式都是由標準函式庫的函式來建立的。 每一個函式的名稱與特性會被寫成一個電腦檔案，這個檔案就稱為 標頭檔案，但是實際的函式實作是被分存到 函式庫檔案裡。標頭檔的命名和領域是很常見的，但是函式庫的組織架構也會因為不同的編譯器而有所不同。標準函式庫通常會隨附在 編譯器上。因為 C 編譯器常會提供一些額外的非 ANSI C 函式功能，所以某個隨附在特定編譯器上的標準函式庫，對其他不同的編譯器來說，是不相容的。 大多数 C 標準函式庫設計得很好。有些少部分會為了商業優勢和利益，把某些舊函式視同錯誤或提出警告。字串輸入函式 gets() 及 scanf() 讀取字串輸入的使用是很多 緩衝區溢位的原因，大多数的程式設計指南會建議避免使用。另一個較為奇特的函式是 strtok()，它原本是作為早期的 词法分析 用途，但是它非常容易出錯（fragile），而且很難使用。 ANSI C共包括15個表頭檔。1995年， Normative Addendum 1 （NA1）批准了3个头文件（ iso646.  
> [https://zh.wikipedia.org/wiki/C%E6%A8%99%E6%BA%96%E5%87%BD%E5%BC%8F%E5%BA%AB](https://zh.wikipedia.org/wiki/C%E6%A8%99%E6%BA%96%E5%87%BD%E5%BC%8F%E5%BA%AB)  

|头文件|内容|
|---|---|
|[[assert.h]]|验证程序断言|
|[[complex.h]]|复数算术运算支持|
|[[ctype.h]]|字符分类和映射支持|
|[[errno.h]]|出错码|
|[[fenv.h]]|浮点环境|
|[[float.h]]|浮点常量与特性|
|[[inttypes.h]]|整型格式转换|
|[[iso646.h]]|赋值，关系，以及一元操作符宏|
|[[limits.h]]|实现常量|
|[[locale.h]]|本地化类别及相关定义|
|[[math.h]]|数学函数，类型声明及常量|
|[[setjmp.h]]|非局部goto|
|[[signal.h]]|信号|
|[[stdarg.h]]|可变长度参数表|
|[[stdbool.h]]|布尔类型和值|
|[[stddef.h]]|标准定义|
|[[stdint.h]]|整型|
|[[stdio.h]]|标准IO库|
|[[stdlib.h]]|实用函数|
|[[string.h]]|字符串操作|
|[[tgmath.h]]|通用类型数学宏|
|[[time.h]]|时间与日期|
|[[wchar.h]]|扩充的多字节与宽字符支持|
|[[wctype.h]]|宽字符分类与映射支持|

  
  

---

---

# posix c

POSIX指可以值操作系统接口（portable operation system interface）  
该标准的目的是提升应用程序在各种UNIX系统环境之间的移植  

作为iso c的超集包含iso c的所有库函数

|头文件|内容|
|---|---|
|[[aio.h]]|异步IO|
|[[cpio.h]]|cpio归档值|
|[[dirent.h]]|目录项|
|[[dlfcn.h]]|动态链接|
|[[fctnl.h]]|文件控制|
|[[fnmatch.h]]|文件名匹配选项|
|[[glob.h]]|路径名匹配类型|
|[[grp.h]]|组文件|
|[[iconv.h]]|代码集变换实用程序|
|[[langinfo.h]]|语言信息常量|
|[[monetary.h]]|货币类型与函数|
|[[netdb.h]]|网络数据库操作|
|[[nl_types.h]]|信息类|
|[[poll.h]]|投票函数|
|[[pthread.h]]|线程|
|[[pwd.h]]|口令文件|
|[[regex.h]]|正则表达式|
|[[sched.h]]|执行调度|
|[[semaphore.h]]|信号量|
|[[strings.h]]|字符串操作|
|[[tar.h]]|tar归档值|
|[[termios.h]]|终端IO|
|[[unistd.h]]|符号常量|
|[[wordexp.h]]|字扩充类型|
|[[arpa-inet.h]]|因特网定义|
|[[net-if.h]]|套接字本地接口|
|[[netinet-in.h]]|因特网地址族|
|[[netinet-tcp.h]]|传输控制协议定义|
|[[sys-mman.h]]|存储管理声明|
|[[sys-select.h]]|select函数|
|[[sys-socket.h]]|套接字接口|
|[[sys-stat.h]]|文件状态|
|[[sys-statvfs.h]]|文件系统信息|
|[[sys-times.h]]|进程时间|
|[[sys-types.h]]|基本系统数据类型|
|[[sys-un.h]]|unix域套接字定义|
|[[sys-utsname.h]]|系统名|
|[[sys-wait.h]]|进程控制|
|[[fmtmsg.h]]|信息显示结构|
|[[ftw.h]]|文件树漫游|
|[[libgen.h]]|路径名管理函数|
|[[ndbm.h]]|数据库操作|
|[[search.h]]|搜索表|
|[[syslog.h]]|系统出错日志记录|
|[[utmps.h]]|用户帐号数据库|
|[[sys-ipc.h]]|IPC|
|[[sys-msg.h]]|XSI信息队列|
|[[sys-resource.h]]|资源操作|
|[[sys-sem.h]]|XSI信号量|
|[[sys-shm.h]]|XSI共享存储|
|[[sys-time.h]]|时间类型|
|[[sys-uio.h]]|矢量IO操作|
|[[mqueue.h]]|信息队列|
|[[spawn.h]]|实时spawn接口|

  
  

  

---

# SUS C

SUS指single UNIX specification(单一SUS规范)

- 作为POSIX.1标准的一个超集，定义了一些符加接口的扩展了POSIX规范提供的功能（接口多以_XOPEN开头）)  
    XSI:POSIX中的X/Open函数接口（X/Open System Interface,XSI）选项描述了可选的接口，可定义了遵循XSI的实现必须支持的POSIX的哪些可选部分：  
    
- 文加同步
- 线程栈地址和长度属性
- 线程进程共享同步
- _XOPEN_UNIX符号常量  
    只有遵循XSI的实现才能称为UNIX系统  
    

  

遵循XSI的系统可选的接口：

- 加密：由符号常量_XOPEN_CRYPE标记
- 实时：由符号常量_XOPEN_REALTIME标记
- 高级实时
- 实时线程：由符号常量_XOPEN_REALTIME_THREADS标记
- 高级实时线程

---

# 编译器针对不同系统的三种限制： {#编译器针对不同系统的三种限制：}

- 编译时限制（头文件）
- 与文件或目录无关的运行时限制（sysconf（）函数）
- 与文件或目录有关的运行时限制（pathconf函数和fpathconf函数）
- 当标准之间出现冲突时POSIX服从ISO C标准

## 编译时的限制

ISO C定义的所有编译时的限制都列在头文件<limits.h>中

#### ISO C限制

|名称|说明|可接受的最小值|典型值|
|---|---|---|---|
|[[CAHR_BIT]]|char的位数|8|8|
|[[CHAR_MAX]]|char的最大值|127|127|
|[[CHAT_MIN]]|char 的最小值|-127|-127|
|[[SCHAR_MAX]]|signed char 的最大值|127|127|
|[[SCHAR_MIN]]|signed char的最小值|-127|-127|
|[[UCHAR_MAX]]|unsigned char的最大值|255|255|
|[[INT_MAX]]|int的最大值|32767|2147483647|
|[[INT_MIN]]|int 的最小值|-32767|-2147483647|
|[[UINT_MAX]]|unsigned int的最大值|4294967295|4294967295|
|[[SHRT_MAX]]|short 的最大值|32767|32767|
|[[SHRT_MIN]]|short 的最小值|-32767|-32767|
|[[USHRT_MAX]]|usigned short 的最大值|65535|65535|
|[[LONG_MAX]]|long的最大值\||2147483647|2147483647|
|[[LONG_MIN]]|long的最小值|-2147483647|-2147483647|
|[[ULONG_MAX]]|usigned long最大值|4294967295|4294967295|
|[[LLONG_MAX]]|long long的最大值|9223372036854775807|9223372036854775807|
|[[LLONG_MIN]]|long long的最小值|-9223372036854775807|-9223372036854775807|
|[[ULLONG_MAX]]|usinged long long的最大值|18446744073709551615|18446744073709551615|
|[[MB_LEN_MAX]]|在一个多字节字符常量中的最大字节数\||1|6|

  
  

- 在<float.h>中，对浮点数据类型也有类似的一组定义

1. ISO C常量FOPEN_MAX表示具体实现保证可同时打开的标准IO流的最小个数
2. ISO C还在<stdio.h>中定义了常量TMP_MAX这是由函数tmpnam函数产生的位一文件名的最大个数

### POSIX C限制

**POSIX C限制的最小值是不变的，他们指定这些特性最具约束性的值**  
POSIX C的限制分类：  

- 数值限制：LONG_BIT,SSIZE_MAX和WORD_BIT
- 最小值:如下
- 最大值:_POSIX_CLOCKRES_MIN
- 运行时可以增加的值:CHARCLASS_NAME_MAX,COLL_WEIGHTS,LINE_MAX,NGROUPS_MAX,和RE_DUP_MAX
- 运行时不变值:如下
- 其他不变量:NL_ARGMAX,NL_MSGMAX,NL_SETMAX,和NL_TEXTMAX
- 路径可变值:FILESIZEBITS,LINK_MAX,MAX_CANON,MAX_INPUT,NAME_MAX,PATH_MAX,PIPE_BUF和SYMLINK_MAX

  

  

  

  

  

**最小值**  
称|说明|最小可接受值  
:-|:-|-:  
_POSIX_ARG_MAX|exec函数的参数长度|4096  
_POSIX_CHILD_MAX|每个实际用户ID的子进程数|25  
_POSIX_DELAYTIMER_MAX|定时器最大超限运行次数|32  
_POSIX_HOST_NAME_MAX|gethostname函数符返回的主机名长度|255  
_POSIX_LINK_MAX|至一个文件的链接数|8  
_POSIX_LOGIN_NAME_MAX|登录名的最大长度|9  
_POSIX_MAX_CANON|终端规范输入队列字节数|255  
_POSIX__POSIX_MAX_INPUT|终端输入队列的可用空间|255  
_POSIX_NAME_MAX|文件名中的字节数，不包括终止null字节|14  
_POSIX_NGROUPS_MX|每个进程同时添加的组ID数|8  
_POSIX_OPEN_MAX|每个进程的打开文件数|20  
_POSIX_PATH_MAX|路径名中的字节数，包括终止null字节|256  
_POSIX_PIPE_BUF|能原子的写到一个管道的字节数|512  
_POSIX_RE_DUP_MAX|当使用间隔表示法{m,n}时，regexec和regcomp函数允许的基本正则表达式重复发生次数|255  
_POSIX_RTSIG_MAX|为应用预留的实时信号编号个数|8  
_POSIX_SEM_NSEMS_MAX|一个进程可以同时使用的信号量的个数|256  
_POSIX_SEM_VALUE_MAX|信号量可持有的值|32767  
_POSIX_SIGQUEUE_MAX|一个进程可发送和挂起的排队信号的个数|32  
_POSIX_SSIZE_MAX|能存在ssize_t对象中的值|32767  
_POSIX_STREAM_MAX|一个进程能同时打开的标准IO流数|8  
_POSIX_SYMLINK_MAX|符号链接中的字节数|255  
_POSIX_SYMLOOP_MAX|在解析路径名时，可遍历的符号链接数|8  
_POSIX__POSIX_TIMER_MAX|每个进程的定时器数目|32  
_POSIX_TTY_NAME_MAX|终端设备名长度，包括终止null字节|9  
_POSIX_TZNAME_MAX|时区名字节数|6  

  

  

  

**运行不变值**  
名称|说明|最小可接受值  
:-|:-|-:  
ARG_MAX|exec函数的参数长度|_POSIX_ARG_MAX  
ATEXIT_MAX|可用atexit函数登记的最大函数个数|32  
CHILD_MAX|每个实际用户ID的子进程数|_POSIX_CHILD_MAX  
DELAYIMER_MAX|定时器最大超限运行次数|_POSIX_DELAYTIMER_MAX  
HOST_NAME_MAX|gethostname函数符返回的主机名长度|_POSIX_HOST_NAME_MAX  
LOGIN_NAME_MAX|登录名的最大长度|_POSIX_LOGIN_NAME_MAX  
OPEN_MAX|赋予新建文件描述符的最大+1|_POSIX_OPEN_MAX  
PAGESIZE|系统内存页的大小（以字节为单位）|1  
RTSIG_MAX|为应用程序预留的实时信号的最大个数|_POSIX_RTSIG_MAX  
SEM_NSEMS_MAX|一个进程可使用的信号量最大个数|_POSIX_SEM_NSEMS_MAX  
SEM_VALUE_MAX|信号量的最大值|_POSIX_SEM_VALUE_MAX  
SIGQUEUE_MAX|一个进程可排队信号的最大个数|_POSIX_SIGQUEUE_MAX  
STREAM_MAX|一个进程一次可打开的标准IO流的最大个数|_POSIX_STREAM_MAX  
SYMLOOP_MAX|路径解析过程中可访问的符号链接数|_POSIX_SYMLINK_MAX  
TIMER_MAX|一个进程的定时器最大个数|_POSIX__POSIX_TIMER_MAX  
TTY_NAME_MAX|终端设备名长度，其中包括终止的null符|_POSIX_TTY_NAME_MAX  
TZNAME_MAX|时区名的字节数|_POSIX_TZNAME_MAX  

### XSI限制

|Column 1|Column 2|
|---|---|
|1234|[[include unistd.hlong sysconf( int name);long pathconf(const char pathname,int name);long fpathconf(in t fd,int name);]]|

  
  

**对sysconf的限制及name参数**  
限制名|说明|name参数  
:-|:-|:-  
ARG_MAX|exec函数的参数的最大长度|ARG_MAX  
ATEXIT_MAX|可用atexit函数登记的最大函数个数|ATEXIT_MAX  
CHILD_MAX|每个实际用户ID的最大进程数|CHILD_MAX  
时钟滴答/秒|每秒钟的滴答数|_\SC_CLK_TCK  
COLL_WEIGHTS_MAX|在本地定义文件中可以赋予LC_CLLLATE顺序关键字项的最大权重值|COLL_WEIGHTS_MAX  
DELAYTIMER_MAX|定时器最大超限运行次数|_\SC_DELAYTIMER_MAX  
HOST_NAME_MAX|gethostname函数返回的最大主机名最大长度|_\SC_HOST_NAME_MAX  
TOV_MAX|readv或writev函数可以使用最多的iovec结构的格式|_\SC_TOV_MAX  
LINE_MAX|实用程序输入行的最大长度|_\SC_LINE_MAX  
LOGIN_NAME_MAX|登录名的最大长度|_\SC_LOGIN_NAME_MAX  
NGROUPS_MAX|每个进程同时添加的最大进程组ID数|_\SC_NGROUPS_MAX  
OPEN_MAX|每个进程最大打开文件数|_\SC_OPEN_MAX  
PAGESIZE|系统存储页长度（字节数）|_\SC_PAGESIZE  
PAGE_SIZE|系统存储页长度（字节数）|_\SC_PAGE_SIZE  
RE_DUP_MAX|当使用间隔表示法{m,n}时，函数regexec和regcomp允许的基本正则表达式重复次数|_\SC_RE_DUP_MAX  
RTSIG_MAX|为每个应用程序预留的实时信号的最大个数|_\SC_RTSIG_MAX  
SEM_NSEMS_MAX|一个进程可使用的信号量的最大个数|_\SC_SEM_NSEMS_MAX  
SEM_VALUE_MAX|信号量的最大值|_\SC_SEM_VALUE_MAX  
SIGQUEUE_MAX|一个进程可排队信号的最大个数|_\SC_SIGQUEUE_MAX  
STREAM_MAX|一个_SC_STREAM_MAX进程在任意给定标准时刻标准IO流的最大个数，如果定义，则必须与FOPEN_MAX有相同值|_\SC_STREAM_MAX  
SYMLOOP_MAX|在解析路径名时可遍历的符号链接数|_\SC_SYMLOOP_MAX  
TIMER_MAX|每个进程的最大定时器个数|_\SC_TIMER_MAX  
TTY_NAME_MAX|终端设备名的长度，包括nill字节|_\SC_TTY_NAME_MAX  
TZNAME_MAX|时区名中的最大字节数|_\SC_TZNAME_MAX  

**对字节数pathconf和fpathconf的限制以及name参数**  
限制名|说明|name参数  
:-|:-|:-  
FILESIZEBITS|以带符号整型值表示在指定目录中允许的普通文件最大长度所带的最小位（bit）数|_PCFILESIZEBITS  
LINK_MAX|文件链接计数的最大值||_PC_LINK_MAX  
MAX_CANON|终端规范输入队列的的最大字节整数|_PC_MAX_CANON  
MAX_INPUT|终端输入队列可用空间的字节数|_PC_MAX_INPUT  
NAME_MAX|文件名的最大字节数（不包括终止的null字节）|_PC_NAME_MAX  
PATH_MAX|相对路径名的最大字节数（包括终止的null字节）|_PC_PATH_MAX  
PIPE_BUF|能原子的写到管道的最大字节数|_PC_PIPE_BUF  
_POSIX_TIMESTAMP_RESOLUTION|文件时间戳的纳秒精度|_PC_TIMESTAMP_RESOLUTION  
SYMLINK_MAX|符号链接的字节数|_PC_SYMLINK_MAX  

---

随着学习的深入会不断进行补充
# 概述

- UNIX系统的进程控制包括创建新进程，执行程序和进程终止
- 进程属性的各种ID——实际，有效和保存的用户ID和组ID，以及他们如何受到进程控制原语的影响，这对编写安全的设置用户ID程序是至关重要的
- 解释器文件（exec函数的变体）和system函数
- UNIX系统提供的进程会计机制，从另一个角度了解进程的控制功能
- UNIX进程控制的基础函数——fork,exec,_exec,wait和waitpid
- 从fork函数了解竞争条件

# 进程标识

- 每个进程都有一个非负整数表示的唯一的ID。
- 进程唯一，但是可以副用，通过赋予新建进程的ID不同于最近终止进程所使用的ID，防止了新进程被误认为是使用同一个ID的某个已经终止的先前进程
- ID为0的进程通常是调度进程，常常被称为交换进程(swapper)，是内核的一部分，不执行任何磁盘上的程序，也被称为系统进程
- ID为1通常是init进程，在自举结束时由内核调用，将系统引导到一个状态（多用户，单人维护等），init进程绝对不会终止时一个普通用户权限，但是以root运行，init是所有孤儿进程的父进程

除了进程ID，进程还有其他一些标识符

|Column 1|Column 2|
|---|---|
|1234567|[[include unistd.h 都没有出错返回值]]|

  
  

pid_t getpid(void); 返回值: 调用进程的进程idpid_t

getppid(void); 返回值：调用进程的父 | 进程iduid_t getuid(void); | | | 返回值: 调用进程的实际用户iduid_t geteuid(voi | | | d); 返回值：调用进程的有效用户idgid | | | _t getgid(void); | | | 返回值：调用进程的实际组idgit_t getegid(void); | | | 返回值：调用进程的有效组id | +————————————–+————————————–+

# 函数fork

**一个现有进程通过调用fork函数创建一个新进程**

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hpid_t fork(vo id); 返回值：子进程返回0，父进程返回子进 程id，出错返回-1]]|

  
  

- fork创建的新进程称为子进程
- fork函数调用一次返回两次（在fork之后，一个进程就变成了两个进程，每个进程都从fork函数返回，通过返回值判断是父进程还是子进程
- 父子进程继续执行fork调用之后的指令
- 由于fork之后常常跟着exec函数，所以很多实现不使用完全副本，而是写时复制技术，只有当进程需要调用某存储空间时，才会生成一个副本。
- fork函产生的父子进程执行顺序取决于内核所用的调度算法，如果要求父子进程之间的同步则要求进行某种形式的进程间通信

## 文件共享

- 子进程是父进程的副本，获得父进程的数据空间，堆和栈的副本，父子进程不共享这些存储空间，但是共享正文段
- fork的一个特性是父进程的所有打开文件描述符都被复制到子进程中，父子进程打开描述符共享一个文件表项
- 父子进程共享同一个文件偏移量
- fork处理文件描述符的两种常见情况
    - 父进程等待子进程完成，在子进程终止后更新曾进行读写操作的任一共享描述符的文件偏移量
    - 父进程和子进程各自执行不同的程序段，fork之后的父子进程各自关闭不需要使用的文件描述符，避免干扰对方使用的文件描述符，通常用于网络服务进程

**子进程继承的父进程属性**

- 打开文件 实际用户ID，实际组ID，有效用户ID，有效组ID
- 附属组ID
- 进程组ID
- 会话ID
- 控制终端
- 设置用户ID标志和设置组ID标志
- 当前工作目录
- 根目录
- 文件模式创建屏蔽字
- 信号屏蔽与安排
- 对任一打开文件描述父的执行时关闭标志
- 环境
- 连接的共享存储段
- 存储映像
- 资源限制

**父子进程区别**

- fork的返回值不同
- 进程ID不同
- 这两个进程的父进程ID不同：子进程的父进程ID是创建它的进程的ID，而父进程的父进程ID则不变
- 父进程的tms_utime,tms_stime,tms_cutime和tms_ustime的值设置为0
- 子进程不继承父进程设置的文件锁
- 子进程未处理闹钟被清除
- 子进程的未处理信号集被设置为空集

**fork失败的两个重要原因**

- 系统中已经有了太多的进程（通常意味着在某个方面出问题了）
- 该用户的ID的进程总数超过了系统限制，CHILD_MAX规定了每个实际用户ID在任一时刻可拥有的最大进程数

**fork的两个用法**

- 一个父进程希望复制自己，使父进程和子进程同时执行不同的代码段（在网络服务中很常见——父进程等待客户端的服务请求，当请求到达时，父进程调用fork使子进程处理此请求，父进程则等待下一个服务请求）
- 一个进程要执行一个不同的程序（这对shell是常见的现象在这种情况下，子进程从fork返回后立即调用exec）
    - 有些操作系统将第二种用法中的两个操作fork+exec组合成一个操作，成为spawn
    - unix系统将操作分开，因为很多场合都要求分开使用，而且在fork和exec之间，子进程可以更改自己的属性如I/O的重定向，用户ID，信号安排等

# 函数vfork

vfork函数用于创建一个新进程，而该新进程的目的是exec一个新程序

vfork函数与fork函数一样都创建一个子进程，但是它并不将父进程的地址空间完全复制到子进程中，因为子进程会立即调用exec或exit，于是也就不会引用该地址空间。

在子进程调用exec或exit之前，它会直接在父进程的空间中运行，这样虽然提高了效率，但是有可能对父进程空间的数据进行破坏，从而带来未知结果。

vfork的另一个区别就是vfork保证子进程先执行，在它调用exec或exit之后父进程才可能被调度执行，当子进程调用这两个函数中的任意一个是，父进程会恢复执行（如果在调用这两个函数之前子进程依赖于父进程的进一步动作，则会导致死锁）

# 函数exit

**进程的正常终止方式**  
1.main函数内执行return语句（等效与调用exit）  
2.调用exit函数  

- 函数由ISO C定义
- 包括调用各终止处理函数(终止处理函数在调用atexit函数时登记),然后关闭所有的标准IO流。
- 因为ISO C不处理文件描述符，多进程（父子进程）以及作业控制，所以这一定义对UNIX系统而言并不完整。  
    3.调用_exit或_Exit函数  
    
- 目的是为进程提供一种无需运行终止处理程序或信号处理程序而终止的方法  
    4.进程的最后一个线程在其启动例程中执行return语句  
    
- 线程的返回值不用作进程的返回值
- 当最后一个进程从其启动例程返回时，该进程以终止状态0返回。  
    5.进程的最后一个线程调用pthread_exit函数  
    
- 进程的状态总是0，与传送给pthread_exit的参数无关

**异常终止方式**

1. 调用abort
2. 当进程接受到某些信号时
3. 最后一个进程对“取消”(cancellation)请求作出响应，默认情况下，“取消”以延迟方式发生：一个进程要求取消另一个线程，若干时间后，目标线程终止

_**不管进程如何终止，都会执行内核中的同一段代码，这段代码为相应进程关闭所有打开描述符，释放它所使用的存储器**_

**正常终止的情况下**将退出状态作为终止函数的参数传递给函数从而告知父进程它是如何终止的**异常终止的情况下**内核产生一个指示其异常终止原因的终止状态。**在任何情况下**该终止进程的父进程都能通过调用wait或waitpid函数取得其终止状态。

★注意术语“退出状态”和”终止状态”的区别，在最后调用_exit时，内核将退出状态转换成终止状态

**父进程在子进程之前终止**

- 对于父进程已经终止的所有进程，他们的父进程都改变为init进程，称为进程收养
- 操作过程：当一个进程终止时，内核逐个检查所有活动进程，以判断它是否是正要终止进程的子进程，如果是，则将该进程的父进程改为1

**子进程在父进程之前终止**

- 如果子进程完全小时，父进程在最终准备好检查子进程是否终止时是无法获取它的终止状态的。
- 内核为每个终止子进程保存了一定量的信息以供父进程wait或waitpid调用，至少包括进程id，进程的终止状态，以及进程使用的cpu时间总量，内核可以释放终止进程的所有存储区，以及其打开的所有文件
- 僵死进程(zombie)，一个已经终止，但是父进程尚未对其进行善后处理（获取终止子进程的有关信息，释放它占用的资源）

_一个由init进程收养的进程终止时不会变成僵死程序，因为init被编写为无论何时，只要由一个子进程终止，init就会调用一个wait函数取得其终止状态_

# 函数wait和waitpid #、 {#函数wait和waitpid-、}

当一个进程正常或异常终止时，内核就向其父进程发送SIGCHLD信号（由子进程终止引发的异步通知）

**函数wait和waitpid的效果**

- 如果所有子进程都还在运行，则阻塞
- 如果一个子进程已经终止，正等待父进程读取其终止状态，或者处于僵死状态，则取得该子进程的终止状态立即返回
- 如果没有子进程，则立即返回 +————————————–+————————————–+ | 1234 | \#include <sys/wait.h>pid_t wait( | | | int _statloc);pid_t waitpid(pid_t pi | | | d,int_ statloc,int options); | | | | | | 成功返回进程ID，失败返回0或-1 | +————————————–+————————————–+

**参数**

> statloc：存放终止进程的终止状态，若不关心，可设为空指针，丢弃终止状态。

> pid：pid==-1 等待任一子进程,同wait  
> pid>0 等待进程id和pid相等的进程  
> pid==0 等待组id等于调用进程组id的任一子进程  
> pid<–1 等待组id等于pid绝对值的任一子进程  

> option参数  
> 常量|说明  
> :-|:-  
> WCONTINUED|若实现支持作业控制,那么由pid指定的任一子进程在停止后已经继续,但其状态尚未报告,则返回其状态(XSI扩展)  
> WNOHANG|若由pid指定的子进程不是立即调用的,则waitpid不阻塞,此时返回值0  
> WUNTRACED|若某实现支持作业控制,而由pid指定的任一子进程已处于停止状态,并且其状态自停止以来还从未报告,则返回终止状态,WIFSTOPPED(status)宏确定返回值是否对应于一个停止的子进程  

**区别**

- 在一子进程终止前，wait使其调用者阻塞，而waitpid有一个选项控制，可以阻塞也可以不阻塞。
- waitpid并不等待在其调用之后的第一个终止子进程，可以通过选项控制它所等待的进程。

**返回值**  
依据传统，这两个函数返回的整形状态字是由实现定义的，其中某些位表示退出状态(正常退出)，其他位则表示信号编号(异常返回)，有一位指示是否产生core文件。  

**终止状态的查看**

- POSIX规定，终止状态用定义在<sys/wait.h>中的各个宏来查看
- 有四个互斥的宏来取得进程终止的原因，再接着调用其他宏可取得退出状态，信号编号等。 宏 说明 ———————- ——————————————————————————————————————- WIFEXITED(status) 若为正常终止的状态则为真，可再执行WEXITSTATUS(status)，获得子进程串送给exit或_exit参数的低8位 WIFSIGNALED(status) 若为异常终止子进程返回的状态则为真（接到一个不捕获额信号），可继续执行WTERMSIG(status),获取使子进程终止的信号编号 WIFSTOPPED(status) 若为当前暂停子进程的返回状态，则为真，可继续执行WSTOPSIG(status),获取使子进程暂停的信号编号 WIFCONTINUED(status) 若在作业控制暂停后已经继续的子进程返回了状态则为真，

# 函数waitid

|Column 1|Column 2|
|---|---|
|123|[[include sys-wait.hint waitid( idtype_t idtype,id_t id,siginfo inf op,int options) 返回值-成功返回0,出错返回-1]]|

  
  

_区别于waitpid：使用两个单独的参数表示要等待的子进程所属的属性，而不是将此于进程id或进程组id组合成一个参数_

### 参量

### idtype

|常量|说明|
|---|---|
|[[P_PID]]|等待一个特定进程:id包含要等待的子进程的进程id|
|[[P_PGID]]|等待一特定进程组中的任一子进程：id包含要等待子进程的进程组id|
|[[P_ALL]]|等待任一子进程，忽略id|

  
  

### options:由值下列各标识的按位或运算

|常量|说明|
|---|---|
|[[WCONTINUED]]|等待一个进程，它以前曾被停止，此后又已继续，但其状态尚未报告|
|[[WEXITED]]|等待已退出的进程|
|[[WNOHANG]]|如无可用的子进程退出状态，立即返回而非阻塞|
|[[WNOWAIT]]|不破坏子进程的退出状态，该子进程的退出状态可由后续的wait，waitid或waitpid调用取得|
|[[WSTOPPED]]|等待一个进程，它已经停止，但是状态尚未报告|

  
  

### infop

infop参数是指向siginfo结构的指针，该结构包含造成子进程状态改变有关信号的详细信息。 函数wait3和wait4 ========================================================

|Column 1|Column 2|
|---|---|
|1234567|[[Arm linux修炼之路/C语言+汇编/C/UNIX环境高级编程/UNIX环境高级编程(7)-进程控制/Untitled Database/include include include include include include include include include include include include include include include include include include include include include include include include include...\|include include include include include include include include include include include include include include include include include include include include include include include include include...]]|

  
  

rusage：资源概况（资源统计信息）包括用户CPU时间总量，系统CPU时间总量，缺页次数，接受到信号的次数等

# 竞争条件

**定义**：多个进程都企图对共享数据进行某种处理，而最后的结果取决于进程运行的顺序，这种情况称为竞争条件。

**轮询**：如果一个进程希望等待一个子进程终止，则必须过wait函数等待子进程的终止；形如：`while(getpid()!=1) sleep(1);`但是会浪费cpu时间

**解决**：为了避免竞争条件和轮询，在多个进称之间需要有某种形式的信号发送和接受方法：信号机制和进程间通信（IPC）

# 函数exec

**基本的进程控制原语**：用fork创建新进程，用exec可以初始执行新的程序，exit函数和wait函数处理终止和等待终止。

子程序调用exec来执行一个新的程序，新的程序从main处执行，exec不会创建新进程，所以进程号不变，只是用磁盘上的一个新程序替换了当前进程的正文段，数据段，堆段以及栈段。

|Column 1|Column 2|
|---|---|
|123456789|[[include include include include include include include include include include include include include include include include include include include include include include include include include... 2]]|

  
  

### 区别

- 前四个函数取路径名为参数，后两个函数以文件名做参数，最后一个以文件描述符作为参数
    - 如果filename中包含/，就视之为路径名
    - 否则按照PATH环境变量，在它指定的各目录中搜索可执行文件
    - 如果路径中的文件不是一个机器可执行文件，则认为该文件是一个shell脚本
- 参数传递的区别（l表示list，v表示矢量vector）
    - 函数execl，execlp和execle要求将新程序的每个命令行参数都说明为一个单独的参数，这种参数表**以空指针结尾**
    - 其他四个函数（execv，execvp，execve和fexecve），应先构造一个指向各参数的指针数组，然后将该数组地址作为这四个函数的参数。
- 向新程序传递环境表
    - 以e结尾的3个函数(execle,execve,fexecve)可以传递一个指向环境字符串指针数组
    - 其他四个函数(execl,execv,execlp,execvp)则使用调用进程中的environ变量为程序复制现有的环境

####补充

- 每个系统对参数表和环境表的总长度有一个限制(由ARG_MAX给出)
- 对打开文件的处理与每个描述符的执行时关闭标志位有关
    - 进程中每个打开描述符都有一个执行时关闭标志，若设置此标志，则在执行exec时关闭此描述符，否则此描述符仍打开（默认操作系统在exec之后仍保持这种描述符打开）
    - POSIX明确要求在exec时关闭打开目录流（通常opendir函数调用fcntl函数设置执行时关闭标志）
- 在exec前后实际用户id和实际组id保持不变，而有效id是否改变取决于所执行程序的设置用户id位和设置用户组id位是否设置，如果设置，则有效用户(组)id变成程序文件所有者的id，否则有效用户(组)id不变

### exec函数之间的关系

[![](https://www.notion.so../pictures/exec)](https://www.notion.so../pictures/exec)

库函数execlp和execvp使用PATH环境变量，查找第一个包含名为filename的可执行文件的路径名前缀，fexecve库函数使用/proc把文件描述符装换为路径名，execve使用该路径名去执行程序

# 更改用户id和组id

setuid函数设置实际用户id和有效用户id，setgid函数设置实际组id和有效组id

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hint setuid(ui d_t uid);int setgid(git_t gid);]]|

  
  

**更改用户id的规则** （假定_POSIX_SAVED_IDS设置为真，否则关于保存的设置用户id均无效）

1. 若进程拥有root权限，则setuid函数将实际的用户id，有效用户id以及保存的设置用户id(saved set-user-ID)设置为uid。
2. 若进程没有超级用户权限，但是uid等于实际用户id和保存的设置用户id，则setuid只将有效用户id设置为uid，不更改实际用户id和保存的设置用户id
3. 如果上述两个条件均不满足，则errno设置为EPERM，并返回-1

**关于内核维护的3个用户id**

1. 还有root用户进程可以更改实际用户id（通常实际用户id在用户登录时同时设置所有的3个用户id）
2. 仅当对程序文件设置了设置用户id位时，exec函数才设置有效用户id，任何时候都可调用setuid,将有效用户id设置为实际用户id，而将有效用户id设置为实际用户id或保存的设置用户id
3. 保存的设置用户id由exec复制有效用户id得道。在exec根据文件的用户id设置了进程的有效id之后，这个副本就被保存起来。

ATT：getuid和geteuid只能获取实际用户id和有效用户id的当前值，没有可移植的方法获取保存的设置用户id的当前值

###函数setreuid和setregid

|Column 1|Column 2|
|---|---|
|1234|[[include unistd.hint setreuid( uid_t uid,uid_t euid);int setregid(u id_t uid,uid_t egid); 返回值：成功返回0，失败返回-1；]]|

  
  

- 允许一个非特权用户总能交换实际用户id和有效用户id，
- 允许一个非特权用户将其有效用户id设置为保存的设置用户id

### 函数seteuid和setegid

|Column 1|Column 2|
|---|---|
|1234|[[include unistd.hint seteuid(u id_t uid);int setegid(gid_t gid); 返回值：成功返回0，失败返回 -1；]]|

  
  

一个非特权用户可以将其有效用户id设置为其实际用户id或保存的设置用户id，对于特权用户则可将有效用户id设置为uid（区别于setuid更改所有的用户id）

# 解释器文件

解释器文件是文本文件，其起始行的形式是 #! pathname[optional-argument]  
pathname通常是绝对路径  

# 函数system

函数system对系统的依赖性很强

|Column 1|Column 2|
|---|---|
|12|[[include stdlib.hint system(co nst char cmdstring);]]|

  
  

system在实现中调用了fork，exec和waitpid函数，所以有三种返回值：

1. fork失败或者waitpid返回除EINTR之外的出错，则system返回-1，并且设置errno以指示错误类型
2. 如果exec失败(表示不能执行shell)，则返回值如同在shell中执行了exit一样
3. 若三个函数都成功，则system的返回值是shell的终止状态，格式在waitpid中已说明

# 进程会计

当启用进程会计处理后，每当进程结束时就会写一个会计记录，包括总量较小的二进制数据，一般包括文件名，所使用的cpu时间总量，用户id和组id，启动时间等  
会计记录结构：  

|Column 1|Column 2|
|---|---|
|1.2345678910111213e+30|[[struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct...]]|

  
  

超级用户执行一个带路径名参数的accton命令启动会计

# 用户标识

- 任一进程都可得到其实际用户id和有效用户id以及组id
- getpwuid可以获取运行程序用户的登录名
- 一个人在口令文件中可以有多个登录项，他们的用户id相同，但是登录shell不同
    
    |Column 1|Column 2|
    |---|---|
    |123|[[include unistd.hchar getlogi n(void); 或许系统记录用户登录的名字 返回值：成功返回指向 登录名字符串的指针，出错返回NULL]]|
    
      
      
    
- 通过getlogin获取系统记录用户登录的名字
- 已知登录名，调用getpwnam可在口令文件中查找用户的相应记录从而确定登录shell

# 进程调度

- unix系统历史上对进程提供的只是基于调度优先级的粗粒度的控制
- 调度策略和调度优先级由内核确定
- 进程可以调整（提高）nice值以选择以更低优先级运行（降低对系统cpu的占有）
- 只有特权用户才能提高nice值

### nice

|Column 1|Column 2|
|---|---|
|12|[[include unistd.h incr参数被加到原 nice值上int nice(int incr); 返回值： 成功，返回新nice值NZERO，出错，返回-1]]|

  
  

### getpriority

|Column 1|Column 2|
|---|---|
|12|[[include sys-resource.hint get priority(int which,id_t who); 返回值： 成功返回-NZERO~NZERO-1之间的nice值，出错返回-1；]]|

  
  

- getpriority函数可以像nice函数那样获取进程的nice值，还可以获取一组相关进程的nice值
- which参数：PRIO_PROCESS表示进程，PRIO_PGRP表示进程组，PRIO_USER表示用户id
- which参数控制who参数时为如何解释的
    - who参数为0，表示调用进程，进程组，或者用户（取决于which参数的值）
    - 当which设置为PRIO_USER并且who为0时，使用调度进程的实际id
    - 如果which参数作用于多个进程，则返回所有进程中优先级最高的

##\#setpriority

|Column 1|Column 2|
|---|---|
|12|[[include sys-resource.h 可用 于为进程，进程组和属于特定用户id的所有进程设置优先级int setpr iority(int which,id_t who,int value) ; 返回值：成功返回0，出错返回-1]]|

  
  

SUS没有对fork之后子进程是否继承nice值制定规则，但是遵循XSI的系统要求进程调用exec后保留nice值

# 进程时间

任一进程都可调用times函数获得它自己以及已终止子进程的墙上时间，用户cpu时间和系统cpu时间

|Column 1|Column 2|
|---|---|
|123|[[include sys-times.hclock_t ti mes(struct tms buf); 返回值：成功返回流逝的墙上时钟时间（以时钟滴答为单位），出错返回-1 ；]]|

  
  

|Column 1|Column 2|
|---|---|
|123456|[[struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct struct... 2]]|

  
  

- tmd结构中不包含墙上时间（函数返回）
- 墙上时间时相对于过去某一时间的相对值，单独使用没有意义、
- 所有的clock_t的值都用_SC_CLK_TCK转换为秒
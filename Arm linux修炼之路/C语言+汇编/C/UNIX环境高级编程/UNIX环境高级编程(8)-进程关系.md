[Share](https://www.notion.sojavascript:void(0);)

# 概述

- 作业控制
- 进程组
- 会话
- 登录shell
- 登录shell启动的进程

# 终端登录

## BSD终端登录

1. 系统自举，内核创建init进程
2. init进程使系统进入多用户模式
3. init读取/etc/ttys文件，对每一个允许登录的终端设备，init调用fork，生成子进程exec getty程序（以空环境exec getty程序）。
4. getty对终端调用open函数，以读，写的方式打开终端
5. 当用户键入用户名后，getty工作结束，以如下方式调用login程序
    - execle(“/bin/login”,”login”,”-p”,username,(char*)0,envp);
        
        ## Mac OS X终端登录
        
        与BSD登录过程类似，但是有不同之处
        

- init的工作是launchd完成的
- 一开始提供的就是图形终端
    
    ## Linux终端登录
    
    与BSD登录过程的不同之处在于说明终端配置文件的方式
    
    ## Solaris终端登录
    
    solairs支持两种形式的终端登录：
    
- getty方式：与BSD终端登录的说明类似
- ttymon方式：服务访问设施的一部分
    - init是sac(service access controller,服务访问控制器)的父进程
    - sac调用fork
    - 当用户进入多用户模式时，子进程执行ttymon程序
    - ttymon监控在配置文件中列出所有的终端端口，当用户键入登录名后，调用一次fork
    - ttymon的子进程执行login，向用户发出提示，要求输入口令
    - 之后login执行登录用户的登录shell
- 通常getty用于控制台，ttymon用于其他终端的登录

# 网络登录

**串行终端登录有网络登录的区别**

- 网络登录时，在终端和计算机之间的连接不再是点到点的
- 在网络登录的情况下，login仅仅是一种可用的服务，与其他网络服务性质一样
- init为每个串行终端设备生成一个getty进程
- 对于网络登录，所有登录都经由内核的网络接口驱动程序、
- 为使同一个软件既能成处理终端登录，也能处理网络登录，系统使用一种伪终端的软件驱动程序，仿真串型终端的运行行为，并将终端操作映射为网络操作，反之亦然

## BSD网络登录

1. 系统启动，init调用一个shell，使其执行shell脚本/etc/rc
2. 通shell脚本启动一个守护进程inetd(它等待大多数网络连接)
3. inetd等待TCP/IP连接请求到达主机，当一个请求到达时，它执行一一次fork，然后生成的子进程exec适当的程序
4. 程序打开一个伪终端设备，并用fork分开成两个进程，父进程处理网络连接的通信，子进程则执行login程序，父子进程通过伪终端连接  
    ★当通过终端或网络登录时，我们得到一个登录shell，其标准输入标准输出和标准错误要么连接到一个终端设备，要么连接到一个伪ie终端设备，而此终端或伪终端则是会话的控制段  
    
    ## Mac OS X网络登录
    
    类似FreeBSD。
    
    ## Linux网络登录
    
    用xinetd代替inetd进程（在对启动的各种服务的控制方面更加精密）
    
    ## Solais网络登录
    
    类似FreeBSD，但是inetd进程在服务管理设置下作为restarter运行（restarter作为守护进程，负责启动和监控其他守护进程，如果其他守护进程失败，restarter重启这些失效进程，）
    
    # 进程组
    

- 每个进程除了有一个进程id之外，还有属于一个进程组
- 进程组是一个或多个进程的集合
- 通常他们是在同一作业中结合起来的，同一进程组中的各进程接受来自统一终端的各种信号
- 进程组id类似于进程id，可存放在pid_t的数据类型中 +————————————–+————————————–+ | 12 | \#include <unistd.h> | | | 返回调用进程的进程组idpid_t getpgrp(void); | | | 返回值：调用进程的进程组id | +————————————–+————————————–+

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hpid_t getpgid (pid_t pid); 返回值-成功返回进程组id，失败 返回-1；若pid=0,则返回调用进程的进程组id]]|

  
  

- 每个进程组由一个组长进程，组长进程的进程组id等于其进程id
- 进程组长可以创建一个进程组，创建该组中的进程，然后终止
- 只要在某个进程组中由一个进程存在，则进程组id就存在，与进程组长是否终止无关
- 从进程创建开始到其中共最后一个进程离开为止的时间区间称为进称组的生命期
- 进程组的最后一个进程可以终止也可以转移到另一个进程组

### 函数setpgid

_进程调用setpgid可以加入一个现有的进程组或创建一个新进程组_

|Column 1|Column 2|
|---|---|
|12|[[include unistd.hint setpgid(p id_t pid,pid_t pgid); 返回值：成 功，返回0，出错返回-1]]|

  
  

- setpgid函数将pid进程的进程组id设置为pgid
- 如果两个参数相等，则有pid指定的进程变成进程组组长。
- 如果pid是0，则默认使用调用者的进程id
- 如果pgid是0，则有pid指定的进程id用作进程组id
- 一个进程只能为自己和他的子进程设置用户组id，在子进程调用exec之后，不再更改该子进程的进程组id
    
    # 会话
    
    会话是一个或多个进程组的集合
    
    ### 函数setsid
    
    |Column 1|Column 2|
    |---|---|
    |12|[[include unistd.h 进程调用s etsid函数建立一个新会话pid_t setsid(void)； 返回值：成功返回进程组id，出错返回-1]]|
    
      
      
    

如果调用此函数的进程不是一个进程组长，则函数创建一个新会话

- 该进程会变成新会话的会话首进程（就是创建该会话的进程），此时，该进程是新会话的唯一进程
- 该进程会变成一个新进程组的组长进程，新进程组id是该调用进程的进程id
- 该进程没有控制终端，如果在调用函数之前有，那么这种联系会被切断

★如果调用进程是一个进程组的组长，则该函数出错**通常做法**：先调用fork，然后使子进程终止，而子进程继续，因为子进程继承了父进程的进程组id，而其进程id是重新分配的，从而保证子进程不是一个进程组的组长

### 函数getsid

|Column 1|Column 2|
|---|---|
|12|[[include unistd.h pi d_t getsid(pid_t pdi); 返回值：成功返回会话首进 程的进程组id，出错返回-1；]]|

  
  

若pid=0，则返回调用进程的级才能横组id，出于安全，若pid不属于调度者所在的会话，则调用进程不能得到该会话首进程的进程组id

# 控制终端

会话和进程组的其他一些特性：

- 一个会话可以有一个控制终端(controlling terminal)，这通常是终端设备或伪终端设备
- 建立与控制终端连接的会话首进程被称为控制进程
- 一个会话中的几个进程组可被分为一个前台进程组以及一个或多个后台进程组
- 如果一会话由一个控制终端，则它有一个前台进程组，其他进程组为后台进程组
- 无论何时输入终端单退出建，都会将退出信号发送到前台进程组的所有进程
- 如果终端接口检测到调制调解器(或网络)已经断开连接，则将挂断信号发送到控制进程（会话首进程）

---

**建立控制终端**

- POSIX将如何分配一个控制段的机制交给具体实现来选择
- 当会话首进程打开第一个尚未与一个会话相关联的终端设备时，只需要在调用open时指定O_NOCTTY标志，system v派生的系统将此作为控制终端分配给此会话
- 当会话首进程用TIOCSCTTY作为request参数调用ioctl时，基于BSD的系统会为会话分配控制终端，为使此调用成功执行，此会话不能已经有一个控制终端

# 函数tcgetpgrp,tcsetpgrp和tcgetsid

|Column 1|Column 2|
|---|---|
|123|[[include unistd.hpid_t tcgetpg rp(int fd); 返回值：成功，返回前台进程组id，出错 返回-1；int tcsetpgrp(int fd,pid_t pgrp id); 返回值：成功返回0，出错返回-1；]]|

  
  

**函数tcgetpgrp返回前台进程组id，它与fd上打开的终端相关联如果进程有一个控制终端，则进程可以调用tcsetpgrp函数将前台进程组id设置为pgrpid，pgrpid值应当是同一个会话中的一个进程组的id，fd必须引用该会话的控制终端**

|Column 1|Column 2|
|---|---|
|12|[[include termios.hpid_t tcgets id(int fd); 返回值：成功返回会话首进程的进程组 id，出错返回-1；]]|

  
  

**给出控制tty的文件描述符，通过tcgetsid函数获取会话首进程的进程组id**

# 作业控制

作业控制允许在一个终端上启动多个作业（进程组），以及控制哪一个作业可以访问终端以及哪些作业在后台运行  
作业控制要求的支持：  

1. 支持作业控制的shell
2. 内核中的终端驱动程序必须支持作业控制
3. 内核必须提供对某些作业控制信号的支持

**特殊字符**

- 中断字符（一般ctrl+c）产生SIGINT
- 退出字符（一般ctrl+\）产生SIGQUIT
- 挂起字符（一般ctrl+z）产生SIGTSTP

**对于前台，后台作业以及终端驱动程序的作业控制功能总结**

此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图

！：穿过终端驱动程序的实现表明终端I/O和终端产生的信号总是从前台进程组连接到实际终端

# shell执行程序

# 孤儿进程组

**定义**：该组中的每个成员的父进程要么是该组的一个成员，要么不是该组所属会话的成员**另一种描述**：一个进程组不是孤儿进程组的条件是——该组中有一个进程，其父进程在属于同一个会话的另一个组中  
★如果进程组不是孤儿进程组，那么在属于同一个会话的另一个组中的父进程就有机会重新启动该组中停止的进程  

# FreeBSD实现

**会话和进程组的FreeBSD实现**

此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图此处应有图

**session结构**

- s_count是该会话中的进程组数，当此计数器减至0时，则可释放此结构
- s_leader是指向会话首进程的proc的指针
- s_ttyvp是指向控制终端的vnode结构的指针
- s_ttyp是指向控制终端的tty结构的指针
- s_sid是会话id

**tty结构**

- t_session指向将此终端作为控制终端的session结构，终端在失去载波信号使用此指针将挂起信号发送给会话首进程
- t_pgrp指向前台进程组的pgrp结构，终端驱动程序用此字段将信号发送给前台进程组
- t_termios包含所有这些特殊字符和与终端有关的信息（如波特率，回显打开或关闭）
- t_winsize是包含终端窗口当前大小的winsize结构

**pgrp结构**

- pg_id是进程组id
- pg_session指向此进程组所属会话的session结构
- pg_members是指向此进程组的proc结构的指针，该proc结构包含一个进程的所有信息

**proc结构**

- p_pid包含进程id
- p_pptr是指向父进程的proc结构的指针
- p_pgrp指向本进程所属的进程组的pgrp结构的指针
- p_pglist是一个结构，其中包含两个指针，分别是指向进程组中上一个和下一个进程
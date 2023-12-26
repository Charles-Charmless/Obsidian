# 概述

- 信号是软件中断
- 信号提供一种处理异步事件的方法
- 早期信号出现的问题
    - 信号机制系统不可靠
    - 信号可能丢失
    - 执行临界区代码时，进程很难关闭所选择的信号

# 信号概念

- 信号以SIG开头
- 信号名被定义为正整数常量（信号编号） `\#include <signal.h>`
- 不存在编号为0的信号，kill函数对信号编号0有特殊应用 ___ ## 信号产生条件 ##

1. 用户按某些终端键，引发终端产生的信号
    - 在终端上按delete键（或者很多系统中的Ctrl+C键）通常产生中断信号(SIGINT),停止一个已失去控制程序的方法
2. 硬件异常产生信号（例如除数为0或无效内存引用）
    - 通常由硬件检测到，并通知内核，然后内核为该条件发生时正在运行的进程产生适当的信号
        - 对执行一个无效内存引用的进程产生SIGSEGV
3. 进程调用kill函数可将任意信号发送给另一个进程或进程组
    - 要求接受信号的进程和发送信号的进程的所有这必须相同或发送信号的是超级用户
4. 进程调用kill命令将信号发送给其他进程，（kill命令是kill函数的接口）
5. 当检测到某种软件信号已经发生，并应将其通知有关进程时也该产生信号
    - 在网络上传来带外的数据时产生SIGURG
    - 在管道读进程已经终止后，一个进程写此管道产生SIGPIPE
    - 在进程设置的定时器超时时产生SIGALRM ## 信号的处理与信号相关的动作 ##
6. 忽略此信号
    - 两种信号不能忽略：SIGKILL和SIGSTOP，因为他们向内核和超级用户提供了使进程终止或停止的方法
    - 如果忽略某些由硬件异常产生的信号，则进程的运行行为是未定义的
7. 捕获信号
    - 需要通知内核在某种信号发生时，调用一个用户函数来进行对该事件的处理
    - 不能捕获SIGKILL和SIGSTOP信号
8. 执行系统默认动作（大多数信号的系统默认动作是忽略） ___ ’终止+core’表示在进程当前工作目录的core文件中复制该进程的内存进程J（该文件名为core），大多数UNIX系统调试程序都使用core文件检查进程终止时的状态

|名字|说明|ISOC|SUS|FreeBSD|Linux|Mac OS|Solaris|默认动作|
|---|---|---|---|---|---|---|---|---|
|[[SIGABRT]]|异常终止(abort)|*|*|*|*|*|*|终止+core|
|[[SIGALRM]]|定时器超时|||||||终止|
|[[SIGBUS]]|硬件故障|||||||终止+core|
|[[SIGCANCEL]]|线程库内部使用||||||||
|[[SIGCHLD]]|子进程状态改变||||||||
|[[SIGCONT]]|使暂停进程继续||||||||
|[[SOGEMT]]|硬件故障||||||||
|[[SIGFPE]]|算术异常||||||||
|[[SIGFREEZE]]|检查点冻结||||||||
|[[SIGHUP]]|连接断开||||||||
|[[SIGILL]]|非法硬件指令||||||||
|[[SIGINFO]]|键盘状态请求||||||||
|[[SIGINT]]|终端中断符||||||||
|[[SIGIO]]|异步IO||||||||
|[[SIGIOT]]|硬件故障||||||||
|[[SIGJVM1]]|java虚拟机内部使用||||||||
|[[SIGJVM2]]|java虚拟机内部使用||||||||
|[[SIGKILL]]|终止||||||||
|[[SIGLOST]]|资源丢失||||||||
|[[SIGLWP]]|线程库内部使用||||||||
|[[SIGPIPE]]|写至无读进程的管道||||||||
|[[SIGPOLL]]|可轮询事件(poll)||||||||
|[[SIGPROF]]|梗概时间超时(setitimer)||||||||
|[[SIGPWR]]|电源失效/重启动||||||||
|[[SIGQUIT]]|终端退出符||||||||
|[[SIGSEGV]]|无效内存引用||||||||
|[[SIGSTKFLT]]|协处理器栈故障||||||||
|[[SIGSTOP]]|停止||||||||
|[[SIGSYS]]|无效系统调用||||||||
|[[SIGTERM]]|终止||||||||
|[[SIGTHAW]]|检查点冻结||||||||
|[[SIGTHR]]|线程库内部使用||||||||
|[[SIGTRAP]]|硬件故障||||||||
|[[SIGTSTP]]|终端停止符||||||||
|[[SIGTTIN]]|后台读控制tty||||||||
|[[SIGTTOU]]|后台写向控制tty||||||||
|[[SIGURG]]|紧急情况(套接字)||||||||
|[[SIGUSR1]]|用户定义信号||||||||
|[[SIGUSR2]]|用户定义信号||||||||
|[[SIGVTALRM]]|虚拟时间闹钟(setitimer)||||||||
|[[SIGWAITING]]|线程库内部使用||||||||
|[[SIGWINCH]]|终端窗口大小改变||||||||
|[[SIGXCPU]]|超过CPU限制(setrlimit)||||||||
|[[SIGXFSZ]]|超过文件长度限制(setrlimit)||||||||
|[[SIGXRMS]]|超过资源控制||||||||

  
  

### 不产生core文件的条件

1. 进程是设置用户id的，而且当前用户并非程序文件的所有者
2. 进程是设置用户组id的，而且当前用户并非程序文件的组所有者
3. 用户没有读当前文件的权限
4. 文件已存在，并且用户对该文件没有写权限
5. 文件太大

## 信号详解

SIGABRT _**SIGALRM**_ SIGBUS _**SIGCANCEL**_ SIGCHLD _**SIGCONT**_ SOGEMT _**SIGFPE**_ SIGFREEZE _**SIGHUP**_ SIGILL _**SIGINFO**_ SIGINT _**SIGIO**_ SIGIOT _**SIGJVM1**_ SIGJVM2 _**SIGKILL**_ SIGLOST _**SIGLWP**_ SIGPIPE _**SIGPOLL**_ SIGPROF _**SIGPWR**_ SIGQUIT _**SIGSEGV**_ SIGSTKFLT _**SIGSTOP**_ SIGSYS _**SIGTERM**_ SIGTHAW _**SIGTHR**_ SIGTRAP _**SIGTSTP**_ SIGTTIN _**SIGTTOU**_ SIGURG _**SIGUSR1**_ SIGUSR2 _**SIGVTALRM**_ SIGWAITING _**SIGWINCH**_ SIGXCPU _**SIGXFSZ**_ SIGXRMS

# 函数signal

```Plain
\#include <signal.h>
void (*signal(int signo,void (*func)(int)))(int);
                                    返回值：成功返回以前信号处理配置，出错，返回SIG_ERR
```

- 描述：向信号处理程序传送一个整型参数，而他无返回值，当调用signal设置信号处理程序时，第二个参数是指向该信号处理函数的指针，signal返回值是指向在此之前的信号处理程序的指针
- signo参数是信号名（整型参量）
- func的值可以是SIG_IGN,SIG_DFL或接受到此信号后要调用的函数的地址
    - 如果指定SIG_IGN则向内核表示忽略此信号
    - 如果指定SIG_DFL则向内核表示接受到磁信号后的动作是系统默认动作
    - 当指定函数地址时，则在信号发生时调用此函数，称为捕获信号，函数称为信号处理（捕获）函数。

## 补充

- 当执行一个程序时，所有信号的状态都是系统默认或忽略,通常所有信号都被设置为他们的默认动作，除非调用exec进程忽略此信号（exec函数将原来设置为要捕获的信号更改为默认动作，其他信号状态不变）（一个进程原来要捕获的信号，当执行一个新程序后，就不能再捕获，因为信号捕获函数的地址很可能在新函数中无意义）
- shell自动将后台进程对中断和退出信号的处理方式设置为忽略
- signal函数的限制：不改变信号的处理方式就不能确定信号当前处理方式
- 当一个进程fork时，其子进程继承父进程的信号处理方式（子进程复制父进程的内存映像）

# 不可靠信号

## 不可靠的原因

- 信号可能丢失
- 进程对信号的控制能力很差
- 不具备阻塞信号的能力（有时用户希望通知内核阻塞某个信号 ## 早期版本的问题 ##
- 在信号发生之后到信号处程序调用signal函数之间有一个时间差，在这段期间，可能发生另一个中断信号，第二个信号会造成执行默认动作，而对中断信号的默认动作是终止该进程
- 在进程不希望某种信号发生时，他不能关闭该信号，进程能做的就是忽略该信号

# 中断的系统调用

## 早期UNIX系统的一个特性：

如果进程在执行一个低速系统调用而阻塞期间捕获到一个信号，则系统调用就被中断不再继续进行，该系统调用出错，其errno设置为EINTR（当捕捉到一个信号时，被中断的是内核中执行的系统调用） _**系统调用分为低速系统调用和其他系统调用，低速系统调用可能是进程永远阻塞，包括： + 某些类型文件（如读管道，终端设备和网络设备）的数据不存在，则读操作可能使调用着永远阻塞 + 如果这些数据不能被相同的类型文件立即接受，则写操作可能会使调用者永远阻塞 + 在某种条件之前打开某种类型文件,可能会发生阻塞（例如要打开一个终端设备，需要县等待与之连接的调制解调器应答） + pause函数（他使调用进程休眠直至捕捉到一个信号）和wait函数 + 某些ioctl操作 + 某些进程间通行函数 + 关于磁盘IO有关的系统调用，虽然读写一个磁盘文件可能暂时阻塞调用者（在磁盘驱动程序将请求排入队列，然后在适当时间执行请求期间），但是除非发生硬件错误，IO操作总会很快返回，并使调用者不再处于阻塞状态**_ + 与被中断的系统调用相关的问题是必须显式的处理错误返回 ___ + 为了帮助应用程序使其不必处理被中断的系统调用，并且忽略输入设备是否低速的影响，引进了某些被中断系统调用的自动重启动 + 自动重启动的系统调用包括:ioctl,read,readv,write,writev,wait和waitpid + 前5个函数只是对低速设备进行操作时才会被信号中断，而wait和waitpid在捕获到信号时总是被中断 + 允许进程基于每个信号禁用自动重启动功能

## 系统调用与库函数的区别

- 系统调用：系统调用是操作系统提供给用户程序调用的特殊接口，实现了对系统硬件的操作
- 库函数：库函数可以理解为是对系统调用的一层封装

# 可重入函数

---

1. 进程捕捉到信号并对其进程处理时，进程正在执行的正常指令序列就被信号处理程序临时中断，首先执行该信号处理程序中的指令
2. 如果从信号处理程序返回(例如没有调用exit或longjmp)则继续执行在捕获到信号时进程正在执行的正常指令序列（类似于硬件中断处理）
3. 但是在信号处理程序中，不能判断捕获到信号时进程正在执行到何处，则原程序与信号处理程序可能会导致冲突 _**可重入函数指在信号处理程序中保证调用安全的函数，这些函数被称为是可重入的，也被称为异步信号安全，并且在信号处理操作期间，他会阻塞任何会引起不一致的信号发送**_ **函数不可重入的原因**

- 他们使用静态数据结构
- 他们调用malloc或free
- 他们是标准IO函数(标准IO函数库的很多实现都以不可重入方式使用全局数据结构) ___ >尽管是不可重入函数，但是由于每个线程只有一个errno变量，所有信号处理程序可能会修改原来的值，因此作为一个通用古则，当在信号处理程序调用可重入函数时，应当在调用前保存errno值，在调用后恢复errno >经常被捕获的信号是SIGCHLD，其信号处理程序通常要调用一种wait函数，而各种wait函数都能改变errno值

---

longjmp和siglongjmp不是可重入函数，因为主例程以非可重入方式正在更新一个数据时可能产生信号，如果不是从信号处理程序返回而是调用siglongjmp，那么数据结构可能是部分更新的，如果应用程序将要做更新全局数据结构，而同时捕获某些信号，而这些信号的处理程序又会引起执行siglongjmp，则在更新这种数据结构时要阻塞此类信号 ___

**如果信号处理程序中调用一个非可重入函数则结果是不可预知的** **可重入函数(全)** abort|faccessat|linkat|select|socketpair :-|:-|:-|:-|:- accept|||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| |||| ||||

# SIGCLD语义

**SIGCLD区别于SIGCHLD**：SIGCLD是System V的一个信号名，SIGCHLD是BSD的一个信号名，POSIX采用BSD的SIGCHLD信号 **在linux中，SIGCLD等同于SIGCHLD** **对SIGCLD的早期处理方法** 1. 如果进程明确的将该信号的配置设置为SIG_IGN，则调用该进程的子进程将不产生僵死程序（不同于默认动作“忽略”） + 子进程在终止时，将其状态丢弃 + 如果调用进程随后调用一个wait函数，那么他将阻塞直到所有的子进程都终止，然后该wait返回-1，并将其errno设置为ECHILD（此信号的默认配置为忽略，但这不会使上述语义其作用，必须将其配置明确指定为SIG_IGN才可以） 2. 如果将SIGCLD的配置设置为捕获，则内核立即检查是否有子进程准备好被等待，如果是，则调用SIGCLD处理程序

# 可靠信号术语与语义

## 术语

- 当造成信号的事件发生时，为进程产生一个信号（或向进程发送一个信号）
- 事件可以是硬件中断（除数为0），软件条件（alarm时钟超时），终端产生的信号或调用kill函数
- 当一个信号发生时，内核通常在进程中以某种形式设置一个标志
- 当对信号采取了一个动作时，我们说向进程递送了一个信号
- 在信号产生和信号递送之间的时间间隔内，我们说信号是未决的
- 进程可以“采用阻塞信号递送”
    - 如果进程产生了一个阻塞信号，而且对该信号的动作是系统默认动作或捕获该信号，则为该进程将此信号保持为未决状态，知道对该信号接触阻塞，或者将对此信号的动作更改为忽略
    - 内核在递送一个原来被阻塞的信号给进程时才决定对他的处理方式，因此进程在信号递送给他之前仍可改变对该信号的动作
    - 进程调用sigpending函数来判断某些信号是设置为阻塞并处于未决状态的
- 如果在进程解除对某个信号的阻塞前，这种信号发生多次，POSIX系统允许信号递送多次（称为排队），但是除非支持POSIX扩展，否则大多数信号不支持排队
- 如果多个信号要递送给一个进程，POSIX的建议：在其他信号之前递送与进程当前状态有关的信号，如SIGSEGV
- 每个进程都有一个信号屏蔽字，规定了当前要阻塞递送到该进程的信号集
    - 对于每种可能的信号，该屏蔽字中有一位与之对应，对于某种信号，若其对应位已设置，则表示他当前是被阻塞的
    - 进程可以调用sigprocmask函数来检测和更改其当前信号屏蔽字
- 信号编号可能会超过一个整型所包含的二进制位数，因此POSIX定义了一个新数据类型sigset_t，他可以容纳一个信号集。

# 函数kill和raise

kill函数将信号发送个进程或进程组 raise函数允许进程向自身发送信号

```Plain
\#include <signal.h>
int kill(pid_t pid，int signo);
int raise(int signo);
                返回值：成功返回0，出错返回-1
```

调用`raise(signo)`等价于`kill(getpid(),signo)` kill的pid参数： 情况|说明 :-|:-| pid>0|将信号发送给进程id为pid的进程 pid==0|将信号发送给与发送进程属于同一进程组的所有进程，要求发送进程具有权限向这些进程发送信号，这里的所有进程不包括实现定义的系统进程集，对于大多数UNIX系统，系统进程集包括内核进程和init进程 pid<0|将该信号发送给其进程组id等于pid绝对值而且发送进程具有权限想起发送信号的所有进程，不包括系统进程集中的进程 pid==-1|将该信号放松给发送进程具有权限向他们发送信号的所有进程，不包括其系统进程集中的进程 _**进程发送信号需要权限 + 超级用户可以给任一进程发信号 + 非超级用户，发送者的实际用户id或有效用户id必须等于接受者的实际用户id或有效用户id + 如果支持_POSIX_SAVED_IDS,则检查接受者的设置用户id（而非有效用户id） + 如果发送的信号是SIGCONT，则进程可将他发送给属于同一会话的任一其他进程**_ **空信号** + POSIX将信号编号为0定义为空信号 + 如果signo参数是0，则kill仍执行正常的错误检查，但不发送信号 + 常被用来确定一个特定进程是否存在 + 如果向一个不存在的进程发送空信号，则kill返回-1，errno设置为ESRCH + unix系统在一段时间后会重新启动进程id，所以此测试的进程很可能非目标进程（非原子操作，无意义） +++ 如果调用kill为调用进程产生信号，而且此信号是不被阻塞的，那么在kill返回之前，signo或某个未决的，非阻塞信号被传送到该进程

# 函数alarm和pause

在使用alarm函数可以设置一个定时器，如果定时器超时会产生SIGALRM信号，如果忽略或不捕获此信号，默认动作是终止调用此alarm函数的进程

```Plain
\#include <unistd.h>
unsigned int alarm(unsigned int seconds);
                        返回值：0或以前设置的闹钟时间的余留秒数
```

- 每个进程都有一个信号屏蔽字，规定了当前要阻塞递送到该进程的信号集
- 对于每种可能的信号，该屏蔽字中有一位与之对应，对于某种信号，若其对应位已设置，则表示他当前是被阻塞的
- 参数seconds的值是产生信号的SIGALRM需要经过的时钟秒数，当这一个时刻到达时，信号由内核产生，由于进程调度的延迟，所以进程得到控制从而能够处理该信号还需要一个时钟间隔
- 一个进程只能有一个闹钟时间，如果在调用alarm时，之前已为该进程注册的时间还未结束，则，此次闹钟的剩余值作为返回值返回，以前注册的闹钟时间被代替
- 如果以前注册的尚未超过闹钟时间，而且本次调用的seconds为0，则取消以前的闹钟时间，其余留值仍作为alarm函数的返回值
- 虽然sigalarm的默认动作是终止，但是大多数进程捕获此信号  
      
    只有执行了一个信号处理程序并从其返回时，pause才返回，在这种情况下，pause返回-1，errno设置为EINTR；  
    
    - 如果此时进程要终止，则在终止他之前可以执行所需的清除操作
    - 如果我们要捕获SIGALRM信号，则必须在调用alarm之前安装该信号的处理程序
    - 如果我们先调用alarm，然后在我们安装SIGALRM处理程序程序之前以接受到该信号，则进程结束 +++ pause函数是调用进程挂起直至捕获到一个信号
    
    ```Plain
    \#include <unistd.h>
    int pause(void);
                      返回值：-1，errno设置为EINTR
    ```
    

# 信号集

**处理信号集的函数**

```Plain
\#include <signal.h>
int sigemptyset(sigset_t *set);
int sigfilset(sitset_t *set);
int sigaddset(sigset_t *set,int signo);
int sigdelset(sigset_t *set,int signo);
                                返回值：若成功，返回0，出错返回-1
int sigismember（const sigset_t *set,int signo）;
                                返回值：若真，返回1，若假，返回0
```

- sigemptyset初始化有set指向的信号集，清除所有的信号。
- sigfillset初始化有set指向大额信号集，使其包含所有的信号 所有应用程序在使用信号集前，需要对该信号集调用sigemptyset或sigfillset一次，因为C编译程序将不赋初值的外部变量和静态变量都初始化为0，
- sigaddset将一个信号添加到已有的信号集中
- sigdelset从信号集中删除一个信号 对所有以信号集作为参数的函数，总是以信号集地址作为向其传送的参数

# 函数sigprocmask

★sigprocmask只适用于单线程 调用函数sigprocmask可以检测更改或同时进行检测和更改进程的信号屏蔽字

```Plain
\#include <signal.h>
int sigprocmask(int how,const sigset_t *restrict set,sigset_t *restrict oset);
                                        返回值：成功返回0，出错返回-1
```

- 若oset为非空指针，那么进程的当前信号屏蔽字通过ose返回
- 如set为一个非空指针，则参数how指示如何修改当前信号屏蔽字 >**how可选的值** SIG_BLOCK是或操作 SIG_SETMAKS是赋值操作 how|说明 :-|:- SIG_BLOCK|该进程的信号屏蔽字是当前信号屏蔽字和set所指向信号集的并集，set包含希望阻塞的附加信号 SIG_UNBLOCK|该进程新的信号屏蔽字是其当前信号屏蔽字和set所指向信号集补集的交集，set包含希望解除阻塞的信号 SIG_SETMAKS|该进程的信号屏蔽字是set指向的值
- 如果set是一个空指针，则不改变进程的信号屏蔽字，how值也无意义
- 在调用sigprocmask之后如果有任何未决的，不再阻塞的信号，则在sigprocmask返回前，至少将其中之一递送给该进程

# 函数sigpending

sigpending函数返回一信号集，对于调用进程而言，其中各信号是阻塞不能递送的，因而也一定是当前未决的，该信号集通过set参数返回

```Plain
\#include <signal.h>
int sigpending(sigset_t *set)
                                    返回值：成功返回0，出错返回-1
```

# 函数sigaction

**sigaction函数的功能是检查和修改与指定信号相关联的处理动作**

```Plain
\#include <signal.h>
int sigaction(int signo,const struct sigaction *restrict act,struct sigaction *restrict oact)
                            返回值：成功返回0，出错返回-1
```

- 参数signo是要检测或修改其具体动作的信号编号，若act指针为空，则要修改其动作，若oact指针非空，则系统经oact指针返回该信号的上一个动作

```Plain
struct sigaction{
    void (*sa_handler)(int);            //addr of signal handler or SIG_IGN,or SIG_DFL
    sigset_t sa_mask;                   //additional signals to block
    int sa_flags;                       //signal options,fiure 10.16
    /*alternate handler*/
    void (*sa_sigaction)(int,siginfo_t *,void *);
}
```

+++ ## 更改信号动作过程： ## 如果sa_handler字段包含一个信号捕获函数的地址（不是SIG_IGN或SIG_DFL）则sa_mask字段说明了一个信号集，在调用该信号捕获函数之前，这一信号集要加入到进程的信号屏蔽字中。仅当从信号捕获函数返回时再将进程的信号屏蔽字恢复为原先值，这样在信号捕获函数之前就能阻塞某些信号

在调用信号处理程序时，操作系统建立新的信号屏蔽字包括正在被递送的信号，保证了在处理一个特特定信号时，如果这个信号再次发生，那么他会被阻塞到对前一个信号的处理结束 +++ ★一旦对给定的信号设置了一个动作，那么在调用sigaction显式的改变他之前，该设置一直有效 +++ act结构的sa_flags字段指定对信号进行处理的各个选项 选项|SUS|Free BSD|Linux|Mac OS|Solaris|说明 :-|:-:|:-:|:-:|:-:|:-:|:- SA_INTERRUPT| SA_NOCLDSTOP| SA_NOCLDWAIT| SA_NODEFER| SA_ONSTACK| SA_RESERHAND| SA_RESETART| SA_SIGINFO| +++ >sa_sigaction字段是一个替代的信号处理程序，在sigaction结构中使用了SA_SIGINFO标志时，使用该信号处理程序 > >>对于sa_sigaction字段和sa_handler字段两者，实现可能使用同一存储区，所以应用只能一次使用这两个字段中的一个 >> >>>通常以`void handler(int signo);`的方式来调用信号处理程序，但是如果设置了SA_SIGINFO标志，则按照`void handler(int signo,siginfo_t *info,void *context)`方式来调用信号处理程序

**siginfo结构**包含了信号产生原因的有关信息

```Plain
struct siginfo{
    int si_signo;               //singal number
    int si_errno;               //if nonzero,errno value from <errno.h> 
    int si_code;                //additional info (depends on signal)
    pid_t si_pid;               //sending process id
    uid_t si_uid;               //sengding process real user id
    void *si_addr;              //address that cause the fault
    int si_status;              //exit value or signal number
    uniion sigval si_value;     //application-specific value
}

联合sigval包含以下字段；
    int sival_int;
    void *sival_ptr;
```

- 应用程序在递送信号时，在si_value.sival_int中传递一个整型数，或者在si_value.sival_ptr中共传递一个指针
- 若信号是SIGCHLD则将设置si_pid,si_status和si_uid字段，若信号是SIGBUS,SIGILL,SIGFPE或SIGSEGV，则si_addr包含造成故障的根源地址，该地址可能并不准确
- sig_errno字段包含错误编号，他对应于造成信号产生的条件，并由实现定义 **si_code代码值** 信号|代码|原因 :-|:-|:- SIGILL| SIGILL| SIGILL| SIGILL| SIGILL| SIGILL| SIGILL| SIGILL| SIGFPE| SIGFPE| SIGFPE| SIGFPE| SIGFPE| SIGFPE| SIGFPE| SIGFPE| SIGSEGV| SIGSEGV| SIGBUS| SIGBUS| SIGBUS| SIGTRAP| SIGTRAP| SIGCHLD| SIGCHLD| SIGCHLD| SIGCHLD| SIGCHLD| SIGCHLD| Any| Any| Any| Any| Any| **信号处理程序的context参数** >信号处理程序的context参数是无类型指针，可以被强制类型转换成ucontext_t结构类型 > >>该结构至少包括以下部分

```Plain
ucontext_t *uc_link;            //pointer to context resumed when this ??context returns
sigset_t uc_sigmask;            //signals blocked when this context is active
stack_t uc_stack;               //stack used by this context
mcontext_t uc_mcontext;     //machine-specific representation of saved context
```

> uc_stack字段庙是了当前上下文所用的栈，至少包括：

```Plain
void *ss_sp;                    //stack base or pointer
size_t ss_size;             //stack size
int ss_flags;               //flags
```

# 函数sigsetjmp和siglongjmp

- 在信号处理程序中通常调用longjmp函数以返回程序的主循环,而不是从该处理程序返回
- longjmp跳转的问题:当捕获到一个信号时,进入信号捕获函数,此时当前信号被自动添加到进程的信号屏蔽字中,从而组织后来产生的这种信号中断信号处理程序,如果使用longjmp函数跳出信号处理函数在不同的系统中有不同的操作,有的系统不会支持此操作,有的会保存和会恢复信号屏蔽字,有的不保存和恢复信号屏蔽字 ★POSIX定义了两个新函数sigsetjmp和siglongjmp,在信号处理程序中进行非局部跳转时使用这两个函数

```Plain
\#include <setjmp.h>
int sigsetjmp(sigjmp_buf env,int savemask);
                                返回值:若直接调用返回0,若从siglonjmp调用返回,则返回非0.
void siglongjmp(sigjmp_buf env,int val);
```

与setjmp，longjmp之间的区别：sigsetjmp增加了一个参数，如果savemaask非0，则sigsetjmp在env中保存进程的当前信号屏蔽字，调用siglongjmp时，如果带有非0savemask的sigsetmask调用已经保存了env，则siglongjmp从其中恢复保存的信号屏蔽字

# 函数sigsuspend

- 更改进程的信号屏蔽字可以阻塞所选择的信号，或解除他们的阻塞，这样好处是可以保护不希望由信号中断的代码临界区。
- 如果在信号阻塞时产生了信号，那么该信号的传递就会被推迟直到对他解除了阻塞，对应用程序而言就好像信号发生在解除对SIGINT的阻塞和pause之间（取决于内核如何实现信号）
- 如果产生了上述的情况或在这之前确实产生了信号，那么可能因为永远不能再见到该信号，所以在某种意义上，在此事件窗口中发生的信号丢失，从而导致pause永远阻塞，这也是早期信号不可靠的原因

**sigsuspend函数**使恢复信号屏蔽字然后使进程休眠成为一个原子操作，从而避免上面的时间间隔问题

```Plain
\#include <signal.h>
int sigsuspend(const sigset_t *sigmask);
                            返回值：-1，并将errno设置为EINTR
```

&#该函数没有成功返回值，如果他返回到调用者，则总是返回-1，并将errno设置为EINTR（表示这是一个被中断的系统调用） ★当sissuspend返回时，它将信号屏蔽字设置为调用他之前的值

# 函数abort

abort函数时程序异常终止

```Plain
\#include <stdlib.h>
void abort(void);           此函数无返回值
```

- 此函数将SIGABRT信号发送给调用进程（进程不应该忽略此信号）
- 调用abrt将向主机环境递送一个未成功终止的通知，其方法时调用raise（SIGABRT）函数
- ISO C要求捕获到此信号而且相应的信号处理程序返回，abort仍不会返回到其调用者
    - 如果捕捉到此信号，，则信号处理程序不能返回的唯一方法是他调用exit,_exit_Exit,longjmp或siglongjmp
- abort并不理会进程对此信号的阻塞和忽略
- 让进程捕获SIGABRT的意图是：在进程终止之前由其执行所需的清理操作
    - 如果进程并不在信号处理程序中终止自己，POSIX申明但信号处理程序返回时，abort终止该进程
- ISO C将是否冲洗输出流以及是否要删除临时文件由具体实现决定
- POSIX则要求如果abort调用终止进程，则他对所有打开标准IO流的效果应当与进程终止前对每个流调用fclose相同

# 函数system(见进程控制章节)

POSIX要求system忽略SIGINT和SIGQUIT，阻塞SIGCHLD system的返回值是shell的终止码

# 函数sleep，nanosleep和clock_nanosleep

```Plain
\#include <unistd.h>
unsigned int sleep(unsigned int seconds);
                                    返回值：0或未休眠完的值
```

sleep函数使调用进程被挂起知道满足以下两个条件之一： 1. 已经过了secods所指定的墙上时间信号 2. 调用进程捕获到一个信号并从信号处理程序返回 + 由于其他系统活动，实际返回时间会比要求的迟一些 + 在第一种情况下，返回值为0，在第二种情况下，返回值为未休眠完的秒数 + 如果用alarm函数实现sleep函数，则这两个函数之间可能会相互影响，具体由实现决定

+++

```Plain
\#include <time.h>
int nanosleep(const struct timespec *reqtp,struct timespec *remtp);
                                    返回值：若休眠到要求的时间，返回0，若出错，返回-1
```

nanosleep函数与sleep函数类似，但是提供了纳秒的精度 nanosleep函数挂起调用进程，直到要求的时间已经超时或者某个信号中断了该函数， + reqtp参数用秒和纳秒来指定需要休眠的时间长度 + 如果某个信号中断了休眠间隔，进程并没有终止，remtp参数指向的timespec结构就会被设置为未休眠完的时间长度，可将此参数设置为空，从而将数据丢弃 + 如果系统不支持纳秒，则要求的时间取整 + nanosleep函数不涉及产生信号 +++

```Plain
\#include <time.h>
int clock_nanosleep(clockid_t clock_id,int flags,const struct timespec *reqtp,struct timespec *remtp);
                                    返回值：若休眠到要求的时间，返回0，若出错，返回错误码
```

clock_nanosleep函数使用相对于特定时钟的延迟时间来挂起调用线程 + clock_id参数指定了计算延迟时间基于的时钟，时钟类型标识符见系统文件信息与系统 + flags参数用于控制延迟是相对的还是绝对的 + flags为0表示休眠时间是相对的 + 如果flags设置为TIMER_ABSTIME表示休眠时间是绝对的（休眠到什么时间） + reqtp和remtp与nanosleep函数中类似，只是在使用绝对时间时，remtp参数未使用 + 使用绝对时间由于减少了查询时间的操作，所以精度会高一点

# 函数sigqueue

应用程序在递交信号时可以传递更多的信息（见sigaction函数）这些信息嵌入在siginfo中，除了系统提供的信息，应用程序还可以向信号处理程序传递整数或者时包含信息的缓冲区指针 **使用排队信号需要的操作** 1. 使用sigaction函数安装信号处理程序时指定SA_SIGINFO标志，如果没有这个标志，信号会延迟，信号是否进入队列取决于实现 2. 在sigaction结构的sa_sigaction成员中（非sa_handler），提供信号处理程序，实现可能允许用户使用sa_handler字段，但不能更改sigqueue函数发送出来的额外信息 3. 使用sigqueeu函数发送信号

```Plain
\#include <signal.h>
int sigqueue(pid_t pid,int signo,const union sigval value);
                                    返回值：若成功返回0，若出错，返回-1
```

- sigqueue函数只能把信号发送给单个进程，可以使用value参数向信号处理程序传递参数和指针值
- 信号不能无限排队（SIGQUEEU_MAX）到达限制后，sigqueue失败，将errno设置为EAGAIN
- 随着实时信号的增强，引入独立信号集，这些信号的编号在SIGRTMIN-SIGRTMAX之间，包含两个限制值，这些信号的默认动作是终止进程

# 作业控制信号

与作业控制有关的信号： 信号|说明 :-|:- SIGCHLD|子进程已停止或终止 SIGCONT|如果进程已经停止，则使其继续运行 SIGSTOP|停止信号（不能被忽略或捕获） SIGTSTP|交互式停止信号 SIGTTIN|后台进程组成员读控制终端 SIGTTOU|后台进程组成员写控制终端 + 除了SIGCHLD以外，大多数应用程序并不处理这些信号，交互式shell通常会处理这些信号的所有工作 + 键入挂起字符（CTRL+Z）SIGTSTP被送至前台进程组的所有进程 + 当我们通知shell在前台或后台恢复运行一个作业时，shell向该作业中的所有进程发送SIGCONT信号 + 如果向一个进程递送了SIGTTIN或SIGTTOU信号，则根据系统默认方式停止此进程，作业控制shell了解到这一点后就通知我们 + 特殊的管理终端的进程 + 当用户挂起时，程序需要了解。从而能够将终端状态恢复至程序启动情况 + 当在前台恢复时，需要将终端状态设置回他希望的状态，有可能需要重绘终端屏幕 + 作业控制信号交互：继续信号会导致未决停止信号丢弃，停止信号会导致未决继续信号丢弃 + 如果进程是终止的，则SIGCONT的默认动作是继续进程，否则忽略 + # 信号名和编号 # **信号编号与信号名之间的映射** 某些系统提供数组`extern char *sys_siglist[]`，数组下标是信号编号，数组中的元素是执指向信号名字符串的指针 +++

```Plain
\#include <signal.h>
void psignal(int signo,const char *msg)
```

psignal函数可移植的打印与信号编号对应的字符串 + 字符串msg（通常是程序名）输出到标准错误文件，后面接一个冒号和空格，在接对信号的说明，最后是一个换行符 + 如果msg为NULL，只有信号说明部分输出到标准错误文件

+++

```Plain
\#include <signal.h>
void psigingo(const siginfo_t *info,const char* msg);
```

psiginfo函数答应信号处理程序中有siginfo结构的信号信息 + 类似psignal，返回更多的信息，额外信息依赖于平台 +++

```Plain
\#include <string.h>
char *strsignal(int signo);         返回值：指向描述该信号的字符串的指针
```

strsignal函数只输出信号的字符描述，也不需要把他写到标准错误文件 +++

```Plain
\#include <signal.h>
int sig2str(int signo,char *str);
int str2sig(const char* str,int *signop);
                                    返回值：成功返回0，出错返回-1
```

sig2str函数与str2sig函数在信号编号与信号名之间映射 + sig2str函数将给定信号编号翻译成字符串，并存储在str指向的存储区 + str2sig函数将给定的信号名翻译成信号编号，该信号编号存放在signop指向的整型中 + sig2str函数与str2sig函数与常用的函数做法不同，当他们失败时，不设置errno
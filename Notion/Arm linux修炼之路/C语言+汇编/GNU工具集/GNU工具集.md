介绍gcc-gdb的使用方法

# gcc-gdb使用

程序生成可执行文件的过程：　预处理，编译，汇编，连接

gcc

-E　只进行预处理指令，生成文件格式与源文件相同

-S　不进行汇编之后的操作，生成.s文件（汇编语言程序）

-c　-c选项不进行连接处理，生成汇编文件.o（只编译，不链接形成的文件，里面包含了对各个函数的入口标记）

-o　-o选项指定生成的文件名称

-g　-g选项在编译时生成调试信息

gdb

直接在命令行输入gdb,回车进入执行程序，键入help显示不同的命令类，在help命令后面加入不同的命令类可以查看命令类里面的具体命令,接下来以help file为例

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710092606534-1453204542.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710092606534-1453204542.png)

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710092747579-1189308146.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710092747579-1189308146.png)

通过file xxx（可执行文件）来加载文件，通过list命令来查看源文件的内容

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093054678-1287111492.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093054678-1287111492.png)

查看断点相关命令：（屏幕显示不完全）

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093616216-1382361154.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093616216-1382361154.png)

在第5行处添加断点：

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093805605-2012821304.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093805605-2012821304.png)

查看运行相关命令：（屏幕显示不完全）

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093902375-778104329.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710093902375-778104329.png)

运行程序到断点并继续执行：

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710110626124-1013988637.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710110626124-1013988637.png)

也可以单步执行：

[![](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710110953818-1705109170.png)](https://img2018.cnblogs.com/blog/1531294/201907/1531294-20190710110953818-1705109170.png)

- set args " xxx" 为程序设定参数
- break n 在N行设置断点
- C 继续运行
- print args 打印参数
- next 执行下一个程序行，跳过程序调用
- step 执行下一条命令，进入函数调用
- list 列出当前程序停止处附近的文本
- thread 切换线程
- set detach-on-fork off 开启进程分离，它的意思是在调用fork后相关进程的运行行为是怎么样的，是detache on/off ?也就是说分离出去独立运行，不受gdb控制还是不分离，被阻塞住。这里还涉及到一个设置 set follow-fork-mode [parents/child] ,就是fork之后，gdb的控制落在谁身上，如果是父进程，那么分离的就是子进程，反之亦然。如果detache-on-fork被off了，那么未受控的那个进程就会被阻塞住，进程状态为T，即处于调试状态。

## alias

ni – Step one instruction rc – Continue program being debugged but run it in reverse rni – Step backward one instruction rsi – Step backward exactly one instruction si – Step one instruction exactly stepping – Specify single-stepping behavior at a tracepoint tp – Set a tracepoint at specified line or function tty – Set terminal for future runs of program being debugged where – Print backtrace of all stack frames ws – Specify single-stepping behavior at a tracepoint

![[IMG_20200915_1516092.jpg]]

  

  

  

  

## ar

  

  

  

## readelf

  

  

  

  

## objdump

  

  

  

  

## ld
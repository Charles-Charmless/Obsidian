# # centos执行sudo 显示command not found的问题 #

# # 问题描述 #

当我们用sudo来执行cd、ls等命令时，会出现command not found的提示

# # 问题原因 #

在编译sudo包的时候默认开启了- -with-secure-path选项。

在执行Linux命令时，如果在其前面加上sudo，就表示以root权限执行。但是这其实是有一个前提，就是只有那些Linux内置系统命令才可以用如此的形式来执行，而对于Shell内置命令或其他用户自定义命令、别名等，是不能用sudo来使用root权限的。

因为当在Linux下用sudo执行某一命令时，是在原进程（parent process）的基础上fork出来一个子进程（child process），这个子进程是以root权限执行的。然后在子进程中，执行你在sudo后面跟的命令。

在子进程中是无法调用涉及到父进程的状态的一些命令的，所以非系统内置命令会被拒绝。这就是为什么会出现command not found的提示。
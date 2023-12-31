讲述搭建NFS服务器的过程

# 搭建NFS服务器

要启动NFS，需要先启动RPC(远程过程调用)服务 NFS的服务端口为2049，但是NFS的其他程序会启动额外的端口(随机的小于1024的端口) RPC指定每个NFS功能对应的port number，并且通知给客户端，让客户端可以连接到正确的端口上 服务器启动NFS时会随机选取数个端口，并主动向RPC注册，RPC从而直到每个端口对应的NFS功能

## 客户端向NFS请求访问过程(客户端和服务器端都需要启动RPC)

1. 客户端向服务器端的RPC(port 111)发出NFS文件访问功能的查询要求
2. 服务器端找到对应的已注册的NFS daemon端口后，通知给客户端
3. 客户端了解正确的端口后，就可以直接和NFS daemon连接

## 需要的软件安装

1. RPC主程序：rpcbind sudo yum install rpcbind
2. NFS主程序：nfs-utils sudo yum install nfs-utils

## NFS软件结构

- 配置文件：/etc/exports
    - 不一定存在，可能需要vim主动建立文件
- NFS文件系统维护命令：/usr/sbin/exportfs
    - 重新共享/etc/exports更新的目录资源
    - 将NFS Server共享的目录卸载或重新共享
- 共享资源的日志文件：/var/lib/nfs/*tab
    - etab文件：记录NFS所共享出来的目录的完整权限设置值
    - xtab文件：记录曾经链接到此NFS服务器的相关客户端的数据
- 客户端查询服务器共享资源的命令：/usr/sbin/showmount
    - 查看NFS共享出来的目录资源

## 配置NFS(/etc/exports)

```Plain
[root@host ~]# vim /etc/exports
/tmp       192.168.100.0/24(ro)   localhost(rw)     *.ev.ncku.edu.tw(ro,sync)
[共享目录]  [第一台主机(权限)]        [可用主机名表示]    [可用通配符表示]   
```
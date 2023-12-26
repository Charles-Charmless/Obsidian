搭建一个个人用的VPS服务器用来谷歌东西用 **声明：比博客只做学习使用，任何非法活动本人概不负责**

## vultr的优点

相对于其他的VPS服务器供应商而言，vultr的最大好处就是能够随时删除服务器重新建立新的服务器，同时重新分配ip，也意味着，如果当前的服务器由于使用不当的原因被封锁的话，只要做好了备份，很快就可以重新建立一个和原来一样的VPS服务器。

## 注册vultr

[![](https://www.notion.so./搭建VPS服务器/注册通道界面.PNG)](https://www.notion.so./搭建VPS服务器/注册通道界面.PNG)

注册通道

由于有个注册码要填，所以会重新跳出来一个注册界面

[![](https://www.notion.so./搭建VPS服务器/注册通道界面2.PNG)](https://www.notion.so./搭建VPS服务器/注册通道界面2.PNG)

到这个界面就算注册成功了，到这一步就算注册成功了，接下来就是登陆账号

[![](https://www.notion.so./搭建VPS服务器/注册通道界面3.PNG)](https://www.notion.so./搭建VPS服务器/注册通道界面3.PNG)

## 部署

登陆之后会直接跳到充值界面

[![](https://www.notion.so./搭建VPS服务器/支付.PNG)](https://www.notion.so./搭建VPS服务器/支付.PNG)

接下来点击

**product**

选项进入产品选择界面 该页面的选项主要是是服务器的地址，服务器的操作系统类型，服务器配置，此外还有其他一些选项。

[![](https://www.notion.so./搭建VPS服务器/服务器位置.PNG)](https://www.notion.so./搭建VPS服务器/服务器位置.PNG)

[![](https://www.notion.so./搭建VPS服务器/操作系统类型.PNG)](https://www.notion.so./搭建VPS服务器/操作系统类型.PNG)

[![](https://www.notion.so./搭建VPS服务器/服务器配置.PNG)](https://www.notion.so./搭建VPS服务器/服务器配置.PNG)

这里本人选择的配置如下： 服务器地址：美国纽约 服务器操作系统：centos 7 64位 服务器配置10G硬盘，512M内存，500G带宽，价格3.5/

_M_

_O_

_N_

*

_注_

_意_

：

_这_

_是_

_最_

_低_

_的_

_配_

_置_

，

_如_

_果_

_追_

_求_

_低_

_延_

_迟_

_的_

_话_

_可_

_以_

_选_

_择_

_日_

_本_

_的_

_服_

_务_

_器_

_不_

_要_

_选_

_择_

2.5/MON的配置，那只有IPV6网络地址，暂时还没有推广开，目前所有的IPV4地址已经分配完毕，马上应该就要推广IPV6吧。*

### 延迟检测

服务器的网速测量有专门的网站可以检测 [点此测试网络延迟]:https://www.nmbhost.com/speedtest/

选择好后选择部署就好

[![](https://www.notion.so./搭建VPS服务器/部署中.PNG)](https://www.notion.so./搭建VPS服务器/部署中.PNG)

当这里的状态变为运行中的时候就可以登陆服务器了点击服务器一栏后面的菜单标志（三个。。。的标志）左键打开服务器详情，进入如下界面

[![](https://www.notion.so./搭建VPS服务器/管理.PNG)](https://www.notion.so./搭建VPS服务器/管理.PNG)

[![](https://www.notion.so./搭建VPS服务器/详情.PNG)](https://www.notion.so./搭建VPS服务器/详情.PNG)

查看服务器的预设密码 然后使用远程登陆程序，可是使用服务器菜单里面的view console控制台（推荐securcrt应用，几乎支持所有的协议） 这里使用网页控制台登陆

[![](https://www.notion.so./搭建VPS服务器/登陆服务器.PNG)](https://www.notion.so./搭建VPS服务器/登陆服务器.PNG)

登陆名是root（在输入密码过程中不会显示字符）

[![](https://www.notion.so./搭建VPS服务器/登陆服务器.PNG)](https://www.notion.so./搭建VPS服务器/登陆服务器.PNG)

登陆进远程服务器之后的第一件事最好修修改一下密码，因为预设的密码太复杂，可以改成一个简单点的密码，命令为passwd 然后最好将系统更新一下，命令为 yum update

[![](https://www.notion.so./搭建VPS服务器/预备.PNG)](https://www.notion.so./搭建VPS服务器/预备.PNG)

之后就要在服务器上搭建shadowsocketsr服务了

## 部署ssr服务

这里使用一键搭建脚本 `wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh`

如果出现`bash: wget: command not found` 用命令`yum install -y wget`即可

下载后用

```Plain
ls
```

命令查看当前目录下的文件，如果有

```Plain
shadowsocks-all.sh
```

则说明已经下载成功，然后给此文件添加执行权限

```Plain
chmod +x ./shadowsocks-all.sh
```

[![](https://www.notion.so./搭建VPS服务器/安装1.PNG)](https://www.notion.so./搭建VPS服务器/安装1.PNG)

然后运行此脚本

```Plain
./shadowsocks-all.sh > ./ssr.log
```

在脚本运行的过程中，会有一些选项需要选择，按照需要选择即可，也可以默认配置直接跳过

[![](https://www.notion.so./搭建VPS服务器/安装2.PNG)](https://www.notion.so./搭建VPS服务器/安装2.PNG)

在脚本结束之后会在ssr.log日志中记录所填写的信息

[![](https://www.notion.so./搭建VPS服务器/信息.PNG)](https://www.notion.so./搭建VPS服务器/信息.PNG)

记录下来，在手机安装ssr软件（粉红色小飞机），然后将对应的信息写入点击连接即可科学上网来查看文献，谷歌之类 可以登陆谷歌，youtube等

[![](https://www.notion.so./搭建VPS服务器/效果.PNG)](https://www.notion.so./搭建VPS服务器/效果.PNG)

（目前该服务器已被注销，仅做测试使用）

如果哪位觉得有点花费有点高的，可以和我一起分担，上限10人。(可以在下方的disqus留言) 现在使用的是日本东京的服务器，延时130ms，youtube最高达到20000kps

---
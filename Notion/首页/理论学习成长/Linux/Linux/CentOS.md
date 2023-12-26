  

**常见软件安装**

# typora

1. 从官网下载安装包
2. 安装依赖文件 `sudo yum install libXScrnSaver-devel.x86_64`
3. 更改chrome-sandbox的属性
    - `sudo chown root:root ./chrome-sandbox`
    - `sudo chmod 4775 ./chrome-sandbox`
4. 结束

# 显卡驱动

# chorme浏览器

1. 下载安装包 `wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm`
2. 执行本地安装 `sudo yum localinstall ./google-chrome-stable_current_x86_64.rpm`
3. 结束

# 下载器xdm

1. 下载安装包`wget https://nchc.dl.sourceforge.net/project/xdman/xdm-2018-x64.tar.xz`
2. 解压 `tar Jxf ./xdm-2018-x64.tar.xz`
3. 执行安装程序 `sudo install.sh`
4. 结束

# 桌面快捷方式

1. 目录：

```Plain
/usr/share/applications
~/.local/share/applications
/usr/local/share/application
```

1. 在上述目录中创建shortcut.desktop
2. vim打开编辑

```Plain
[Desktop Entry]
Exec=/opt/typora/Typora（可执行文件目录）
Icon=/opt/typora/resources/app/asserts/icon/icon_256x256.png(图片目录)
Name=typora（名称）
Type=Application（文件类型）
Terminal=false
```

1. 结束

# qt安装

1. 下载 http://www.qtcn.org/bbs/i.php 得到可执行文件： qt-opensource-linux-x64-5.12.0.run
2. 添加执行权限 chmod +x ./qt-opensource-linux-x64-5.12.0.run
3. 执行安装操作 sudo ./qt-opensource-linux-x64-5.12.0.run
4. 结束

# hexo

1. 依赖解决： 安装hexo需要git和node.js的支持
    - git :sudo yum install git
    - node.js :
        - 下载安装包 ：https://nodejs.org/en/ 得到 node-v10.16.3-linux-x64.tar.xz
        - 解压 tar -Jxf ./node-v10.16.3-linux-x64.tar.xz
2. 安装hexo
    - 进入node.js目录下的bin目录
    - 执行 ./npm install -g hexo-cli
3. 初始化hexo ：新建一个空目录，进入执行`hexo init`

# understand

1. 软件下载
2. 直接运行bin目录下的understand文件
3. 激活码  
    4BE2CFDB1273 8FD617EFCA47 B1397300AEA8 54F0D5C90861  
    
4. 结束

# codeblocks

1. 软件下载
    - codeblocks：http://www.codeblocks.org/downloads/
2. 依赖解决：
    - wxwidget：
        - widget下载：http://www.wxwidgets.org/downloads/
        - ./configure –prefix=/usr –enable-xrc –enable-monolithic –enable-unicode
        - make
        - make install
        - ldconfig
    - sudo yum install hunspell-devel
    - sudo yum install gamin
    - sudo yum install gamin-devel
    - sudo yum install boost
    - sudo yum install boost-devel
3. 软件安装
    - ./configure –prefix=/opt/codeblocks –with-contrib-plugins=all
    - make
    - make install

# minicom

1. 软件安装：`sudo yum install minicom`
2. 软件配置：`sudo minicom -s`
    - 选择 serial port setup
    - 选择 serial device
        - 将serial device改成/dev/ttyUSB0(如果不是usb转串口，则直接为/dev/tty0)

  

1. 启动minicom ：`sudo minicom`
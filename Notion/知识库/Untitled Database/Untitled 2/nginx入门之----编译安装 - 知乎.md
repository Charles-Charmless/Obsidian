[https://zhuanlan.zhihu.com/p/128579141](https://zhuanlan.zhihu.com/p/128579141)

  

**Nginx 编译安装与配置使用**

1.查看系统版本/安装常用软件(系统最小化安装)

```Plain
\#cat /etc/centos-release
CentOS Linux release 7.6.1810 (Core)
```

### **1、安装编译环境**

```Plain
# yum -y install gcc gcc-c++
```

### **2、安装pcre软件包（使nginx支持http rewrite模块）**

```Plain
# yum install -y pcre pcre-devel
```

### **3、安装 openssl-devel（使 nginx 支持 ssl）**

```Plain
# yum install -y openssl openssl-devel
```

### **4、安装zlib**

```Plain
# yum install -y zlib zlib-devel gd gd-devel
```

### **5、创建用户 nginx**

```Plain
# useradd -s /sbin/nologin nginx
```

### **6、编译安装 nginx**

### **1、下载安装包**

```Plain
# wget http://nginx.org/download/nginx-1.16.0.tar.gz
# tar -zxvf nginx-1.16.0.tar.gz
# cd nginx-1.16.0
```

### **2、编译配置**

```Plain
[root@localhost.com nginx-1.16.0]# ./configure --prefix=/usr/local/nginx \
--user=nginx \
--group=nginx \
--with-pcre \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_stub_status_module \
--with-http_auth_request_module \
--with-http_image_filter_module \
--with-http_slice_module \
--with-mail \
--with-threads \
--with-file-aio \
--with-stream \
--with-mail_ssl_module \
--with-stream_ssl_module

[root@localhost.com nginx-1.16.0]\#make && make install
[root@localhost.com nginx-1.16.0]# cd /usr/local/nginx/sbin
[root@localhost.com sbin]# ./nginx              # 启动Nginx
[root@localhost.com sbin]# ./nginx -t           # 验证配置文件是正确
[root@localhost.com sbin]# ./nginx -s reload    # 重启Nginx
[root@localhost.com sbin]# ./nginx -s stop      # 停止Nginx
[root@localhost.com sbin]# ./nginx -v            # 查看是否安装成功
nginx version: nginx/1.16.0
[root@localhost.com sbin]# netstat -ntlp | grep nginx # 查看是否启动
tcp   0    0 0.0.0.0:80     0.0.0.0:*     LISTEN    20949/nginx: master
```

### **3、配置 Nginx 命令和服务并开机启动**

### **1、创建服务配置文件**

```Plain
[root@localhost.com sbin]# vim /usr/lib/systemd/system/nginx.service
[Unit]
Description=nginx - high performance web server
Documentation=http://nginx.org/en/docs/
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
PIDFile=/usr/local/nginx/logs/nginx.pid
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload= /usr/local/nginx/sbin/nginx -s reload
ExecStop= /usr/local/nginx/sbin/nginx -s stop
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```

### **2、添加执行权限**

```Plain
[root@localhost.com sbin]# chmod +x /usr/lib/systemd/system/nginx.service
```

### **3、启动服务(先停止nginx服务)**

```Plain
[root@localhost.com sbin]## systemctl daemon-reload
[root@localhost.com sbin]# systemctl start nginx.service   # 启动
[root@localhost.com sbin]\#systemctl stop nginx.service    # 停止
[root@localhost.com sbin]# systemctl reload nginx.service  # 修改配置后重新加载生效
[root@localhost.com sbin]# systemctl restart nginx.service # 重启
[root@localhost.com sbin]# systemctl status nginx   # 查看服务是否启动
```

### **4、添加开机启动**

```Plain
[root@localhost.com sbin]# systemctl enable nginx.service
Created symlink from /etc/systemd/system/multi-user.target.wants/nginx.service to /usr/lib/systemd/system/nginx.service
```

### **5、Nginx 编译参数**

```Plain
# 查看 nginx 安装的模块
[root@localhost.com sbin]# nginx -V
​
# 模块参数具体功能
--with-cc-opt='-g -O2 -fPIE -fstack-protector'   # 设置额外的参数将被添加到CFLAGS变量。（FreeBSD或者ubuntu使用）
--param=ssp-buffer-size=4 -Wformat -Werror=format-security -D_FORTIFY_SOURCE=2'
--with-ld-opt='-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now'
​
--prefix=/usr/share/nginx                        # 指向安装目录
--conf-path=/etc/nginx/nginx.conf                # 指定配置文件
--http-log-path=/var/log/nginx/access.log        # 指定访问日志
--error-log-path=/var/log/nginx/error.log        # 指定错误日志
--lock-path=/var/lock/nginx.lock                 # 指定lock文件
--pid-path=/run/nginx.pid                        # 指定pid文件
​
--http-client-body-temp-path=/var/lib/nginx/body    # 设定http客户端请求临时文件路径
--http-fastcgi-temp-path=/var/lib/nginx/fastcgi     # 设定http fastcgi临时文件路径
--http-proxy-temp-path=/var/lib/nginx/proxy         # 设定http代理临时文件路径
--http-scgi-temp-path=/var/lib/nginx/scgi           # 设定http scgi临时文件路径
--http-uwsgi-temp-path=/var/lib/nginx/uwsgi         # 设定http uwsgi临时文件路径
​
--with-debug                                        # 启用debug日志
--with-pcre-jit                                     # 编译PCRE包含“just-in-time compilation”
--with-ipv6                                         # 启用ipv6支持
--with-http_ssl_module                              # 启用ssl支持
--with-http_stub_status_module                      # 获取nginx自上次启动以来的状态
--with-http_realip_module                 # 允许从请求标头更改客户端的IP地址值，默认为关
--with-http_auth_request_module           # 实现基于一个子请求的结果的客户端授权。如果该子请求返回的2xx响应代码，所述接入是允许的。如果它返回401或403中，访问被拒绝与相应的错误代码。由子请求返回的任何其他响应代码被认为是一个错误。
--with-http_addition_module               # 作为一个输出过滤器，支持不完全缓冲，分部分响应请求
--with-http_dav_module                    # 增加PUT,DELETE,MKCOL：创建集合,COPY和MOVE方法 默认关闭，需编译开启
--with-http_geoip_module                  # 使用预编译的MaxMind数据库解析客户端IP地址，得到变量值
--with-http_gunzip_module                 # 它为不支持“gzip”编码方法的客户端解压具有“Content-Encoding: gzip”头的响应。
--with-http_gzip_static_module            # 在线实时压缩输出数据流
--with-http_image_filter_module           # 传输JPEG/GIF/PNG 图片的一个过滤器）（默认为不启用。gd库要用到）
--with-http_spdy_module                   # SPDY可以缩短网页的加载时间
--with-http_sub_module                    # 允许用一些其他文本替换nginx响应中的一些文本
--with-http_xslt_module                   # 过滤转换XML请求
--with-mail                               # 启用POP3/IMAP4/SMTP代理模块支持
--with-mail_ssl_module                    # 启用ngx_mail_ssl_module支持启用外部模块支持
```

### **6、Nginx 配置文件**

```Plain
[root@localhost.com sbin]# vim /usr/local/nginx/conf/nginx.conf
# 全局参数设置
worker_processes  1;          # 设置nginx启动进程的数量，一般设置成与逻辑cpu数量相同
error_log  logs/error.log;    # 指定错误日志
worker_rlimit_nofile 102400;  # 设置一个nginx进程能打开的最大文件数
pid        /var/run/nginx.pid;
events {                      # 事件配置
    worker_connections  10240; # 设置一个进程的最大并发连接数
    use epoll;                # 事件驱动类型
}
# http 服务相关设置
http {
    log_format  main  'remote_addr - remote_user [time_local] "request" '
                      'status body_bytes_sent "$http_referer" '
                      '"http_user_agent" "http_x_forwarded_for"';
    access_log  /var/log/nginx/access.log  main;    #设置访问日志的位置和格式
    sendfile          on;      # 用于开启文件高效传输模式，一般设置为on，若nginx是用来进行磁盘IO负载应用时，可以设置为off，降低系统负载
    tcp_nopush        on;      # 减少网络报文段数量，当有数据时，先别着急发送, 确保数据包已经装满数据, 避免了网络拥塞
    tcp_nodelay       on;      # 提高I/O性能，确保数据尽快发送, 提高可数据传输效率
    gzip              on;      # 是否开启 gzip 压缩
    keepalive_timeout  65;     # 设置长连接的超时时间，请求完成之后还要保持连接多久，不是请求时间多久，目的是保持长连接，减少创建连接过程给系统带来的性能损                                    耗，类似于线程池，数据库连接池
    types_hash_max_size 2048;  # 影响散列表的冲突率。types_hash_max_size 越大，就会消耗更多的内存，但散列key的冲突率会降低，检索速度就更快。                                            types_hash_max_size越小，消耗的内存就越小，但散列key的冲突率可能上升
    include             /etc/nginx/mime.types;  # 关联mime类型，关联资源的媒体类型(不同的媒体类型的打开方式)
    default_type        application/octet-stream;  # 根据文件的后缀来匹配相应的MIME类型，并写入Response header，导致浏览器播放文件而不是下载
# 虚拟服务器的相关设置
    server {
        listen      80;        # 设置监听的端口
        server_name  localhost;        # 设置绑定的主机名、域名或ip地址
        charset koi8-r;        # 设置编码字符
        location / {
            root  /var/www/nginx;           # 设置服务器默认网站的根目录位置
            index  index.html index.htm;    # 设置默认打开的文档
            }
        error_page  500 502 503 504  /50x.html; # 设置错误信息返回页面
            location = /50x.html {
            root  html;        # 这里的绝对位置是/var/www/nginx/html
        }
    }
 }
```

### **7、检测 nginx 配置文件是否正确**

```Plain
[root@localhost.com sbin]\#usr/local/nginx/sbin/nginx -t
```

### **8、启动 nginx 服务**

```Plain
[root@localhost.com sbin]# /usr/local/nginx/sbin/nginx
```

### **9、Nginx 命令控制**

```Plain
nginx -c /path/to/nginx.conf     # 以特定目录下的配置文件启动nginx:
nginx -s reload                  # 修改配置后重新加载生效
nginx -s reopen                  # 重新打开日志文件
nginx -s stop                    # 快速停止nginx
nginx -s quit                    # 完整有序的停止nginx
nginx -t                         # 测试当前配置文件是否正确
nginx -t -c /path/to/nginx.conf  # 测试特定的nginx配置文件是否正确
```

```Plain
cmake . \
-DCMAKE_INSTALL_PREFIX=/usr/mariadb \
-DMYSQL_DATADIR=/usr/mariadb/doc \
-DSYSCONFDIR=/etc \
-DMYSQL_USER=mysql \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITHOUT_MROONGA_STORAGE_ENGINE=1 \
-DWITH_DEBUG=0 \
-DWITH_READLINE=1 \
-DWITH_SSL=system \
-DWITH_ZLIB=system \
-DWITH_LIBWRAP=0 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_UNIX_ADDR=/usr/mariadb/mysql.sock \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci
```
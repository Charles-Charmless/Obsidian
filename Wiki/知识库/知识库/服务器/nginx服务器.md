# 安装

```Bash
#\#ubuntu
apt install nginx
```

配置文件目录：/usr/local/nginx/conf/ ，/etc/nginx, /usr/local/nginx 下的nginx.conf

nginx启动：nginx

唤醒：nginx -s signal (stop,quit,reload,reopen)

  

配置文件

正文部分包含：events,http,mail,stream块

http block

```C
http{

}
```

server block（分ip处理）

```C
server{

}
```

location block(没有默认地址表示请求dir，有地址表示请求dir+url)

```C
location /xxx(请求资源地址) {
		root /location_dir;
}
```

代理服务器

```Bash
server{
                location / {
                        proxy_pass http://localhost:8080;  //代理传递
                }
                location ~\.(gif|jpg|png)$ {  //正则表达式
                        root /var/www/images;
                }
}

server{
                listen 8080;    //服务监听端口
                root /var/www/www/;
                location /{
                }
}
```

FastCGI代理

指令：fastcgi_pass,fastcgi_param

包含其他配置文件： include file
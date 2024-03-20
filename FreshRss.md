

# Google Reader API return 404\


军哥的LNMP在PHP的扩展fileinfo 库配置文件的设置上有个问题，导致FreshRSS Google Reader API check compatibility 显示404错误，这个错误导致在一些RSS订阅的app无法使用greader.php API。

FreshRSS在github issues上也有人遇到类似的问题，但是他们的方法我这边不适用。

[![20230917214658.jpg](https://img.hjyl.org/uploads/2023/09/20230917214658.jpg "20230917214658.jpg")](https://img.hjyl.org/uploads/2023/09/20230917214658.jpg)

Google Reader API configuration test:FAIL: HTTP error 404 Not Found

比较了一下LNMP与宝塔lnmp的设置，发现在fileinfo 库的配置文件上有些不同，宝塔安装freshrss就没有上图问题。所以我们如此操作一下：

```
#备份pathinfo.conf文件，以防万一宝塔的代码有问题，还能恢复回来
cp /usr/local/nginx/conf/pathinfo.conf /usr/local/nginx/conf/pathinfo.conf.bak

vi /usr/local/nginx/conf/pathinfo.conf
#按“i”键进入编辑状态，将里面的内容全部删除，然后贴上下面的代码，此代码来自宝塔/www/server/nginx/conf/pathinfo.conf

set $real_script_name $fastcgi_script_name;
if ($fastcgi_script_name ~ "^(.+?\.php)(/.+)$") {
		set $real_script_name $1;
		set $path_info $2;
 }
fastcgi_param SCRIPT_FILENAME $document_root$real_script_name;
fastcgi_param SCRIPT_NAME $real_script_name;
fastcgi_param PATH_INFO $path_info;

#按“ESC”，键入“:wq”保存！然后编辑enable-php.conf。

vi /usr/local/nginx/conf/enable-php.conf
#加入include pathinfo.conf;

        location ~ [^/]\.php(/|$)
        {
            try_files $uri =404;
            fastcgi_pass  unix:/tmp/php-cgi.sock;
            fastcgi_index index.php;
            include fastcgi.conf;
            include pathinfo.conf; #新增部分
        }
```

```
nginx -s reload   #重新加载nginx
```

[![20230917222157.jpg](https://img.hjyl.org/uploads/2023/09/20230917222157.jpg "20230917222157.jpg")](https://img.hjyl.org/uploads/2023/09/20230917222157.jpg)

Google Reader API configuration test PASS
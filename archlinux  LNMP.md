sudo pacman -S php




###Nginx
####NGINX安装

```
sudo pacman -S nginx-mainline
sudo systemctl start nginx
sudo systemctl enable nginx
```

#### NGINX配置
配置文件路径：/etc/nginx/nginx.conf
nginx配置工具： 




###Mariade

```
sudo pacman -S mariade
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mariadb-secure-installation
```

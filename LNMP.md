


##PHP

### PHP开启错误日志


500错误首先就需要先开启php错误日志，通过php错误日志来排错。  
LNMP下的错误需要编辑 /usr/local/php/etc/php-fpm.conf 加上  
php_admin_value[error_log] = /usr/local/php/var/log/php_errors.log  
php_admin_flag[log_errors] = on  
或在/usr/local/php/etc/php-fpm.conf里设置，加上catch_workers_output = yes，（要在www组内加入）错误信息就会记录到php-fpm.conf里error_log设置的文件里。 上述两种方法都行，重启php-fpm生效  
有时可能错误日志文件不自动创建，可以执行：touch /usr/local/php/var/log/php_errors.log && chown www:www /usr/local/php/var/log/php_errors.log  
同理如果要设置php.ini里的display_errors也是需要在php-fpm.conf里设置的，加上php_flag[display_errors] = On就开启了，重启php-fpm生效。  <摘自LNMP>



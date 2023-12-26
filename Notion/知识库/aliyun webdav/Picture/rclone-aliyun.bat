@echo off 
if "%1" == "h" goto begin 
mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit 
:begin 
rclone mount alidriver_webdav:/ D:\Desktop\AliYun --cache-dir D:\Ali_webdav\tmp --vfs-cache-mode writes --no-update-modtime
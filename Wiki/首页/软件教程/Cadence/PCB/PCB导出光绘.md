第一步

提取过孔

1. Drill Customization→Auto generate symbols
2. Drill legend →输出钻孔表格
3. NC Parameter设置钻孔参数
4. NC Drill输出标准钻孔文件
5. NC Route 输出异形钻孔

  

第二步

添加Mark点，阻焊1-2mm

1. 制作Mark点（1mm内径）
2. Place菜单勾选Library选项
3. 放置Mark点，一般3个

  

第三步

输出光绘

1. 设置光绘区域 Setup→Areas→PhotoPlot outline
2. 光绘参数设置 Manufacture →Artwork
    1. 修改未定义的线宽为5、6
    2. 设置thermal-reliefs焊盘全连接
    3. 光绘参数设置
3. 光绘层设置
    1. 线路层添加：板框，ETCH，PIN，VIA
    2. 丝印层：板框，Package geometry，Board Geometry，REFDES
    3. 阻焊层：PIN（焊盘），Package geometry，Board Geometry， VIA CLASS
    4. 钢网层：PIN（焊盘），Package geometry
    5. 钻孔：Manufacture→NCLEGEND/NCDRILL_FIGURE/NCDRILL_LEGEND,Board Geometry→dimension
4. 进行Database Check
5. 生成光绘文件

  

第四步

生成IPC网表，进行开短路检查

File→export→IPC356→IPC356A
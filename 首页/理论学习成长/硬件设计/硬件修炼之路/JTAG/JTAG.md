## Pin Description

![[Notion/首页/理论学习成长/硬件设计/硬件修炼之路/JTAG/Picture/Untitled.png|Untitled.png]]

- TCK上升沿的时候，TDI数据传输，下降沿TDO数据传输，TMS引脚提供状态机转换的控制信号
- 不使用JTAG时，将TDI引脚连接到VCC，TDO引脚不连接，TMS引脚连接到VCC
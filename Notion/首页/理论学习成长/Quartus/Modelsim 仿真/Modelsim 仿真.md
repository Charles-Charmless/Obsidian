1. 配置仿真工具：Assignments → Settings → EDA Tools Settings → Simulation

![[Notion/首页/理论学习成长/Quartus/Modelsim 仿真/Picture/Untitled.png|Untitled.png]]

2. 自动产生测试激励文件模板： Processing→ Start → Start Test Bench Template Writer

![[Notion/首页/理论学习成长/Quartus/Modelsim 仿真/Picture/Untitled 1.png|Untitled 1.png]]

3. 编辑自动生成的test bench文件

![[Notion/首页/理论学习成长/Quartus/Modelsim 仿真/Picture/Untitled 2.png|Untitled 2.png]]

4. 连接test bench

  

  

  

## 注意点

![[Screenshot_2021-03-10_164752.jpg]]

- 图中的1处必须和顶层模块名字一致，二处必须在1处的名字后加上“_vlg_tst”，3处的文件必须和1处一致。
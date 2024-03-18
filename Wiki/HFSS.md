四种基本仿真类型
+ driven modal
+ driven terminal
+ eigen mode
+ transient
driven model, driven terminal 都是在有源驱动的的情况下的求解模型（需要端口激励）
driven modal 典型应用在微带线，波导传输，等传输结构，得到的S参数是基于主模到高次模，各种模式的广义S参数
driven terminal ：终端为多根导线的传输线，比如差分线，得到的S参数也是基于终端的
对于天线，微波器件仿真多用driven modal,
电路，高速互联设计多用driven terminal

需要设置端口和边界条件，
一般在需要分析的目标和参考平面之间，绘制二维平面作为端口设置激励，

端口分为：
+ 波端口（wave port）
+ 集总端口（lump port）
暴露在外围边界处的端口设置成波端口
模型内部的端口设置成集总端口

需要在模型外部绘制一个盒子作为求解区域

仿真求解设置：
+ 求解频率
+ 迭代次数
+ 误差门限

SI仿真通常还需要宽带扫频，因此需要进行扫频率设置，包括起止频率，取点数，扫频方式
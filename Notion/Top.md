PTP

802.3

DDR

SERDES

热插拔

SATA

电源

Oring 电路

参数

电源域

布局

电源SOA

保险丝

功能Pin

滤波环路

隔离电源

非隔离电源

DC-I电源

DC-C电源

参数选择

上管 下管是什么？

PI

时钟

晶振

PLL

Free Run mode

ZDM

PHRD

风扇

连接器

EMC

DFC

协议

I2C

Parameter

上升时间

I3C

JTAG

XILINX CONFIG UG470***

Flash 有初始化时间，要求在FPGA获取配置前，flash必须初始化ok，否则需要使用init信号延迟初始化时间

Pull PROGRAM_B pin low trigger internal configuration reload.

电源芯片mos管接反馈

电源管理方案：

专用芯片

CPLD +ADC

RLM 电源种类

Power 要考虑 pcb power loss and 大电流导线loss

电源要看下通流 电流分布， 温升导致通流下降

Cpld可以用iic接口升级

设计要考虑调试便利 比如一般都需要加匹配电阻，和指示灯

Power connector max current influenced by voltage

风扇有启动电压，12v风扇一般启动电压为7v PWM FAN TACH

[https://www.analog.com/en/analog-dialogue/articles/how-to-control-fan-speed.html](https://www.analog.com/en/analog-dialogue/articles/how-to-control-fan-speed.html)

基材混压， FR4 ,TG点，热传导，散热，板材翘曲 采用高TG板材

D2D AR,D2M OSP AR CPK

DRILL TO DRILL

高纵横比

中间两层不对称， 折弯，良率

单挂

8字孔

光模块底部包地过孔，散热，EMC，拉大间距，拉大孔径？,优化

PP 3mil？

外观检查，切片，

加工流程

HDI

LINE CARD：daughter card

PP流胶

HEAT SINK sanreban

厚铜板

埋嵌铜

高速高频混压

表面处理 OSP 化学锡铜

裁板利用率 原始尺寸

黑化，综化

Pp融化厚度影响

Pin lam

Mass lam

Xray 打靶 钻孔定位

钻孔高温，胶流出

xi板 流胶

先化学铜，再电镀铜

脉冲电镀

EMMI 微光显微镜 故障定位，

系统日志分成两种，一种是普通运行日志，可以存储在ssd中，一种为fault log，在异常之后立即通过cpld存储在SRAM中，zero write time，external batery supply

PCIE 电容放置要求：

过连接器，发送侧尽可能靠近连接器

不过连接器，尽可能靠近接受侧

SCHE ASSYEMBLY PIN : RXXXX(PROJECT NUMBER)-GXXXX(BOARD NUMBER)-XXXX(VERSION)-SC(SCHE)

PCBA ASSYEMBLY PIN : RXXXX(PROJECT NUMBER)-AXXXX(BOARD NUMBER)-XXXX(VERSION)

电源管脚 使用电源标识

管脚要加 IN/OUT/INOUT 符号，便于 cross refer

最后一页加 change list

地向下

所有中间信号要加网络名并引出IN/OUT

所有器件需要立放

一定不要盖住东西

光模块7个低速号

ABSENT,INT,RST,1PPS,LP,MODSEL,P/VS(Programmable/Module Vendor Specific)

认证 UL /ROHS /EMC /CE

[https://zhuanlan.zhihu.com/p/554620885](https://zhuanlan.zhihu.com/p/554620885)

# PTP

[[217579co]]

1588 =ptp （Precision Time Protocol），typically on an Ethernet or IP-based network.

1588 can provide real-time applications with precise time-of-day (ToD) information and time-stamped inputs, as well as scheduled and/or synchronized outputs，

频率同步，相位同步，时间同步

NE的频率同步可以通过SyncE或PTPv2实现

SyncE用于从接口上接收的数据包（在物理层上工作）以及接口上接收的ESMC数据包（大约每秒一个数据包）中导出频率，该接口描述时钟的质量。因此，它不添加任何控制数据包，并且不受SyncE最佳方面的流量拥塞的影响。

PTP在数据包上运行，因此会有控制数据包流，并且数据包会受到拥塞的影响，这会增加延迟。

SYNCE recover clock from 同步设备（如BITS/SSU）,也可以是设备时钟（如SEC）

Bits clock

PTP Protocol

PTP could have more than one grandmaster (synchronized to a time reference such as GPS or CDMA)

Messages in the protocol include Master sync message, Master delay response message, and the Slave clock delay request messages. In addition to the messages, the Best Master Clock (BMC) algorithm allows multiple Masters to negotiate the best clock for the network.

Master to slave difference = tranmit delay+ offset time between master to slave

Slave to Master difference = tranmit delay+ offset time between slave to master

Synchronous Ethernet (SyncE—ITU-T Rec. G.8261) and 1588 (IEEE 1588-2008 or version 2) are technologies used for distribution of frequency and time of day (ToD).

IEEE 1588v2 defines the precision timing protocol (PTP) at the packet layer, which may be used to distribute frequency and/or ToD (phase).

SYNCE 同步以太网，SyncE uses the physical layer (Ethernet interfaces) to distribute frequency from the primary reference clock (PRC) to the slaves. The means for redundancy are provided. received clocks from multiple inputs, filters the selected reference, and uses that as the transmit direction clock,实现以太网之间的频率同步

1588实现时间同步

PLL用于频率同步，1PPS用于相位同步

EFuse is a circuit inherited in ASIC,much faster and accurate intervention than mech fuse. Recoverable. Over load will cause limit the I/V,if persist, cut through power

And in POR, hot plug /swap, it could enhace the voltage input to inhibit the surge by soft start cap

The ocp of efuse could be set by the res.

HiZ status ,none Pmos or Nmos open

# 802.3

SMI Protocol

MDC frequency limits to 25MHz max.

MDIO is open drain and MDC doesn’t need the pull up res

Level shifte need to consider the BW of the chip to meet the communication need.

MAC (CSMA/CD MAC)

MAC (media access control) in OSI model belongs to DATA LINK LAYER,upper served for LLC(logic link control) etc.

PHY divided into lan PHY and Wan PHY

MII Media Independent Interface，介质独立接口

PHY与PHY之间进行通信的接口称为MDI（Medium Dependent Interface，媒介专用接口），媒介有背板、Cable、光纤……，因媒介的不同就会有不同的通信协议；数率的不同又会有不同的通信协议，媒介和数率两两组合就可以变幻出许多种通信协议,比如10GBase-KR、40GBase-CR4、100GBase-SR10……

PLS：PhysicalSublayer Signaling，对MAC给的信息进行传递，只在1Mb/s、10Mb/s的应用场景才出现；

PCS：Physical Coding Sublayer，对MAC给的信息进行编码，应用于≥100 Mb/s的应用场景，比如完成8B/10B、64B/66B、256B/257B编码；

FEC：Forward Error Correction，前向纠错，与10GBase-R、40GBase-R的PCS 搭配；

RS-FEC：Reed-Solomon前向纠错，比单纯的FEC纠错能力更强，与100GBase-R的PCS 搭配，采用256B/257B编码；

PMA：Physical Medium Attachment，

PMD：Physical Medium Dependent，

AN: Auto-Negotiation Function，自动协商，使背板两侧的Device能够互换信息以发挥出彼此最大的优势；

模块间的接口

PLS与PMA间的接口，称之为AUI（Attachment Unit Interface）；

PCS与FEC间的接口，称之为XSBI：10Gigabit Sixteen Bit Interface；

PMA与PMA间的接口，可以是chip to chip，也可以是chip to module，有两种：

XLAUI：40 Gigabit Attachment Unit Interface，4条lane，每条lane的数率是10.3125Gbps；

CAUI：100 Gigabit Attachment Unit Interface，10条lane，每条lane的数率是10.31250Gbps；

PMA与PMD间的接口，称之为nPPI（Parallel Physcial Interface）。

TDR convert the reflected wave into the impedance discontinue.

PCIe 扩频 减小EMI

pcie支持向下扩频，调制范围为-0.5%-0%

TL10 chip internally has L2 virtual network instance. Traffic between nodes in the same L2VNI GO L2 switch, in different L2VNI GO L3 route

FAN stack will not increase the fan flow, but increase the pressure to overcome the restance of flow. Which help achieve the max performance of fan.

Xilinx use the JTAG interface to configure FPGA so to enable a path to SPI flash.

Parasitic inductor 寄生电感 lead length，

PCB Golden Finger attach sequence :1. GND,2. POWER 3. SIGNAL

TVS二极管 具有极快的响应时间（亚纳秒级）和相当高的浪涌吸收能力

[[howtoselec]]

电容 class 1，2，3 dielectrics,C0G is a Class 1 dielectric ,X5R and X7R are in Class 2, and Y5V is in Class 3.

[https://www.allaboutcircuits.com/technical-articles/x7r-x5r-c0g...-a-concise-guide-to-ceramic-capacitor-types/](https://www.allaboutcircuits.com/technical-articles/x7r-x5r-c0g...-a-concise-guide-to-ceramic-capacitor-types/)

电源合并供电，可以从芯片输出管教直接出，也可以从输出后给每一路电源加电感单独供电

风扇PQ曲线

PCIE SIGNAL

TX_P/N, RX_P/N, REFCLK_P/N

WAKE, PRSNT, PERST, JTAG, SMBUS,

PCIE正常工作前，先要初始化建链，主要协商确定位宽已经频率，No firmware or operating system software is involved.

Transaction Layer Packets (TLPs)

Discovery, Configuration and Operation

Three pcie address space : MEMORY I/O,configuration.

exchanges Flow Control information

supporting both software and hardware-initiated power management.

Data link layer: Link management and data integrity, include error detection & error correction.

reliably exchanging information

Physical layer :logic and electrical block

interface operation and logic information include interface initialization and maintenance

Logic

For backward compatibility,the link is 2.5GT/S with 8b/10b encode, and change to 8G/S with 128b/130b

8GT/S DATA STRUCTURE

2bits sync header + ordered set + data block（ frame token +TLP + DLLP）

32GT/S or higher , precode

PCIE link equalization to neogiate with transmit speed

Link initialize and train

风扇

[https://www.expreview.com/81282.html](https://www.expreview.com/81282.html)

PLL :

PLL 作用：噪声清理

PFD(PHASE FREQUENCY DETECTOR)

# DDR

SPD:

延迟锁定环 (DLL) 和锁相环 (PLL)

DM功能在写操作中的作用：当给定的字节lane的DM_n采集到低电平时，DRAM会掩掉DQ作为输入pin接收到的写操作数据。当给定字节lane的DM_n采集到高电平时，DRAM不会掩掉DQ作为输入pin接收到的写操作数据，而会写到其core中。

DBI功能在写操作中的作用：当给定的字节lane的DBI_n采集到低电平时，DRAM会反转DQ作为输入pin接收到的写操作数据。当给定的字节lane的DBI_n采集到高电平时，DRAM不会反转DQ作为输入pin接收到的写操作数据。

DBI功能在读操作中的作用：当写给给定字节lane的数据中‘0’的比特数大于4时，DRAM将会反转其输出到DQ作为输出pin上的读操作数据，并且驱动DBI_n pin为低电平。否则，DRAM将不会反转读操作数据，并且驱动DBI_n PIN为高电平。

TDQS功能：当TDQS功能被使能（enabled）时，DM & DBI功能就都不支持了。当TDQS功能被失能（disabled）时，DM和DBI功能将会按照下表27的描述方式被支持。当TDQS功能被使能（enabled）时，与TDQS_t/TDQS_c pins相同的端接电阻功能将被应用到TDQS_t/TDQS_c pins上。

[BG=Bank Group Address, BA=Bank Address, RA=Row Address, CA=Column Address, BC_n=Burst Chop, X=Don’t Care, V=Valid].

[https://www.eet-china.com/mp/a64457.html](https://www.eet-china.com/mp/a64457.html)

自刷新模式才可以修改时钟

Command Address Latency (CAL Mode), Command Address Parity (CA Parity Mode)

Command Address Parity Latency (PL)

Refresh cycle time (tRFC)

average Refresh interval (tREFI)

Write level 调节CLK & DQS之间的信号

# SERDES

[https://www.eet-china.com/mp/a63707.html](https://www.eet-china.com/mp/a63707.html)

发送端均衡

FFE : 前馈均衡（Feed-Forward Equalization，FFE）

有限冲激响应(FIR)滤波器 TAP

```Plain
    分为：预加重 （Pre emhpasis） 去加重  (De-emphasis)
```

[https://www.eet-china.com/mp/a70510.html](https://www.eet-china.com/mp/a70510.html)

[https://patents.google.com/patent/CN111510404A/zh](https://patents.google.com/patent/CN111510404A/zh)

[http://emlab.uiuc.edu/ece546/Lect_27.pdf](http://emlab.uiuc.edu/ece546/Lect_27.pdf)

接收端均衡

CTLE continuous time linear equalizer (CTLE) 连续时间线性均衡器

[http://www.spisim.com/zhtw/ibis-ami-ctle二三事/](http://www.spisim.com/zhtw/ibis-ami-ctle%E4%BA%8C%E4%B8%89%E4%BA%8B/)

[https://people.engr.tamu.edu/spalermo/ecen720.html](https://people.engr.tamu.edu/spalermo/ecen720.html)

[https://www.eet-china.com/mp/a72912.html](https://www.eet-china.com/mp/a72912.html)

Pre-emphasis & linear Equalization

[https://www.intel.com/programmable/technical-pdfs/654771.pdf](https://www.intel.com/programmable/technical-pdfs/654771.pdf)

DFE/CDR

判决反馈均衡器（Decision Feedback Equalier, DFE)

clock and data recovery (CDR)

如果能够根据当前码元的判决结果，将该码元的后续影响依次全部消减，就可以把当前码元ISI的影响降到最低，甚至消除。这也是DFE作用最直观的描述。

[https://www.eet-china.com/mp/a77946.html#:~:text=判决反馈均衡器（Decision,包含串扰，反射等现象。](https://www.eet-china.com/mp/a77946.html#:~:text=%E5%88%A4%E5%86%B3%E5%8F%8D%E9%A6%88%E5%9D%87%E8%A1%A1%E5%99%A8%EF%BC%88Decision,%E5%8C%85%E5%90%AB%E4%B8%B2%E6%89%B0%EF%BC%8C%E5%8F%8D%E5%B0%84%E7%AD%89%E7%8E%B0%E8%B1%A1%E3%80%82)

发展：

系统同步时钟，源同步时钟，

ledg

8B/10B编码

软垫，时间长会沉降

封装越小，串联寄生参数越小

Optical form factor

[https://www.prooptix.com/news/transceiver-form-factors/](https://www.prooptix.com/news/transceiver-form-factors/)

5-6层S

温度和频率对互连线信号完整性的影响

[http://html.rhhz.net/HEBGCDXXB/html/201711080.htm](http://html.rhhz.net/HEBGCDXXB/html/201711080.htm)

# 热插拔

[https://www.paiqinano.com/?p=21623](https://www.paiqinano.com/?p=21623)

[https://www.ti.com/lit/an/scpa058a/scpa058a.pdf?ts=1678033568421](https://www.ti.com/lit/an/scpa058a/scpa058a.pdf?ts=1678033568421)

如果检测在位后再打开电源和其他型号，由于缓启动作用，会使得对芯片的冲击小很多

1. 在位的作用：
2. 单纯检测在位
3. 检测在位后，通过在位来实现热插拔  
    2.1 如果这么做，那么电源 地的长短pin就没什么作用  
    

Rack opencompute

[https://www.opencompute.org/wiki/Open_Rack/SpecsAndDesigns](https://www.opencompute.org/wiki/Open_Rack/SpecsAndDesigns)

White rabbit

[https://ohwr.org/projects/white-rabbit](https://ohwr.org/projects/white-rabbit)

Open hardware

[https://ohwr.org/welcome](https://ohwr.org/welcome)

IBM BLADEcenter

Vpx vita

力学测试

机械冲击测试，正弦振动试验，随机振动试验，跌落测试

电源测试

Power cycle not power loop

电源拉偏测试

纹波，噪声，过冲，下冲，台阶，回沟，打开，关闭时间

动态负载测试，闭环稳定性，OCP,OVP,

电源抑制比：

负电压 由电荷泵 产生，用电荷泵给输出提供方向电压

反相器提供负压

# SATA

速率 ：1.5G,3G,6G,

物理层，链路层，传输层，应用层

应用层：overall command execution

传输层：放置 FIS 帧信息结构

Link layer：编解码

# 电源

[https://zhuanlan.zhihu.com/p/72587706](https://zhuanlan.zhihu.com/p/72587706)

## Oring 电路

防反灌

## 参数

动态抑制比

BUCK 拓扑 适合单输出

BOOST拓扑

BUCK拓扑 控制芯片有最小占空比范围，所以导致输入输出比值过大时不适合 应该采用具有隔离的拓扑，可以通过匝比调节合适的占空比。达到较好的性能价格比。

开关频率较低 磁通密度变化量 受材料饱和限制 且低频体积大

较高时涡流等磁性材料损耗，以及开关切换的损耗

隔离需求

EMI问题

凡是在开关管截止时间向负载输出能量的统称为反激变换器。

LDO 滤波

[https://www.analog.com/media/cn/technical-documentation/application-notes/AN-1329_cn.pdf](https://www.analog.com/media/cn/technical-documentation/application-notes/AN-1329_cn.pdf)

DCDC

[https://www.analog.com/media/cn/technical-documentation/application-notes/an-1125_cn.pdf](https://www.analog.com/media/cn/technical-documentation/application-notes/an-1125_cn.pdf)

带有内部寄存器的芯片都需要在芯片基础电源满足后在进行解复位，因为芯片的上电瞬间的波动会错乱内部寄存器，导致寄存器不稳定

环境试验

Cold and Hot Soak

海拔测试

四角测试 高低温、高低压

Acoustic Noise Test ISO7779,ISO3744

RE Radiated Emission辐射发射 CISPR32 standard & EN 55032 standard

RS Radiated Susceptibility 辐射敏感

CE Conducted emission 传导发射

Radiated Immunity EN 61000-4-3

电源纹波，考虑电容的非理想型，寄生电感的影响

电源噪声：

电源器件噪声， PDN噪声，耦合噪声

PIM 卡 ISO7816

电源，时钟，复位，控制信号，

电源过冲，产生原因：LC，

[https://ez.analog.com/power/f/q-a/166850/lt3580-voltage-overshoot/377687](https://ez.analog.com/power/f/q-a/166850/lt3580-voltage-overshoot/377687)

Power fast discharge

电源动态负载测试

电源环路稳定性

## 电源域

FPCB板上的电源域分成 FAN电源域，standby电源域，MAIN电源域

比如SWITHC 主板上有FPGA电源域，SWITCH芯片电源域，COME电源域

观察电源流向，保证说每一个器件在上电前没有不确定的状态

电源域内电源由于有一致的电源方向，所以，电源域内一般不会有问题，

要考虑电源域之间的漏电流，前级电源露向后级电源

**想象一下电源扩散**

## 布局

反馈要顺，尽量距离pin脚近，不上件的器件放远处上件的器件放近处

## 电源SOA

[https://techclass.rohm.com.cn/knowledge/si/s-si/04-s-si/6789](https://techclass.rohm.com.cn/knowledge/si/s-si/04-s-si/6789)

## 保险丝

串联保险丝

并联保险丝

防止 浪涌能量太大，TVS管失效，电源一直处于短路状态，所以加入并联保险丝。

慢熔，快熔保险丝

## 功能Pin

1. PG信号，由输入电压供电，检测输出电压，一般为开漏输出，PG信号最好拉到输出电源上，如果采用其他电源，可能PG信号不可靠

输入早给，不释放EN,PG 拉低，找一个最后的电源给PG供电（在EN释放前供好电），然后逐级打开EN。

原边副边

**DCDC也有原边副边，主要看是不是隔离电源**

## 滤波环路

电源环路 即 反馈模块

电源输出端滤波电容的地，电源芯片，以及芯片的地形成一个环路

## 隔离电源

## 非隔离电源

## DC-I电源

## DC-C电源

## 参数选择

- 开关频率  
    通过最小打开时间和最小关断时间，计算出Fsw上限，然后选择最大的开关频率  
    
- 输出电感  
    通过计算电感值来设置纹波电流大概0.3倍输出电流  
      
    纹波电流大：改善瞬态响应，和信噪比，但会怎么加稳态输出电压纹波  
      
    纹波电流小：减小稳态输出电压纹波，，瞬态响应慢，增加抖动  
      
    电感值的计算： 开启时间内的电源变化率/电流变化率（纹波电流）  
    
- 阈值电流计算：  
    输出电流+ 纹波电流* 系数  
    
- 输出电容
    - 稳定度
    - 稳态输出电压纹波
    - 负载电流变化瞬态响应  
        稳定性需求：LC振荡电路要求最小电容，保证谐振点在开关频率的1/30以下 保证稳态输出  
          
        稳态输出纹波要求最小电容，C=dI/dV,  
          
        瞬态响应要求最小电容  
          
        满足过冲要求设置最小电容  
          
        稳定性需求也可以设置最大输出电容， 在1/100 Fsw之上，  
        

我们设计是按照工作电流来的，上电瞬间冲击电流是电源那边考虑的，你可以看下电源的原理图，输出附近有说明IMAX和IOCP，IOCP就是来设置瞬态冲击电流的，而且上电瞬间的瞬态电流是由滤波（储能）电容和芯片共同提供的，芯片会有一个UVP进行检测保护，所以只要设置好OCP，UVP就可以了

手册上电源的范围为AC+DC的整体范围

单纯AC的范围要比AC+AD的要低，

比如AC+DC 3%, DC +2% ~ -1%

AC+DC 5% DC +3% ~ -2%

- 因为电源路径有压降，所以正向偏移比负向大
- 一般希望超高处调，而不是低处

## 上管 下管是什么？

## PI

PI仿真中 瞬态电流设置为负载电流的一半

AC ripple ： 如果总体为+/-5%， DC +3% ~ -2% （5%）,则 AC 为5%（10%-5%）

# 时钟

## 晶振

晶振电源前方都要加磁珠电容滤波电路

时钟设计

AC/DC耦合要求，摆幅要求是否能够满足

电平输出标准要求

时钟满足jitter要求 热，SI，EMC问题

独立时钟架构，同源时钟架构、

**即使是AC耦合电容，也要注意两端的共模电压差不要太大**

## PLL

### Free Run mode

### ZDM

零延迟模式

### PHRD

相位回读

# 风扇

Vendor: AVC,SUNON,NIDEC

风扇背压：

当有个风扇不转时，可能由于其他风扇吸风导致故障风扇倒转，上电瞬间转速不均衡也可能出现背压，对风扇正常工作造成影响

# 连接器

Vendor: Molex TE Amphenol

镀层的作用：

1. 对接触弹片的基材起到防腐蚀保护作用
2. 优化接触界面的属性，提高连接器的电气性能和机械性能

# EMC

传导发射

频率：150k-> 30MHz

对象：AC Power line 传导回电源线后再传导到其他设备 实际上时通过电源线进行传播的辐射发射

辐射发射

频率：30M-> 40GHz

天线

线极化，圆极化，椭圆极化

ESD

**ESD防护等级** ：1级，2级，3级，一般只要求1，2，级

EFT 电快速瞬变

Surge 雷击浪涌测试 模拟雷电脉冲影响

导电泡棉，金属弹片，良好接触，压缩量不小于30%

前面板首选蜂窝孔波导设计

粘泡棉的背胶也要到导电

吸波材料的选择要根据噪声频段来选择，

## DFC

初次级间电气间隙大于4mm，爬电距离大于5mm 需要综合考虑海拔，工作电压

初级保险丝/次级保险丝（变压器初级线圈，次级线圈）

内层电源平面和数字平面要距离螺、垫片及其他金属部件不小于20mil，这是为了防止安装硬件用力过大将PCB压碎，从而形成短路烧板。

# 协议

## I2C

I2C 考虑上拉驱动，和频率响应问题，减小上拉电阻可以改善上升时间，但是太小会导致低电压比较高，而且有较大的漏电流，低电平的最大值决定了上拉电阻的最小值

ACK 第9个CLK主释放SDA，从控制SDA

clK时钟改变：

多主机仲裁

慢速设备时钟线延展

从设备终端拉起SCL，占有总线

如果从机无应答，主机发送stop or Sr(repeat start)

如果主机无应答，从机释放总线，主机发送STOP OR SR

START SCL HIGH SDA FALL

STOP SCL HIGH SDA RAISE

I2C 仲裁

Thold-tstart 多master拉低SDA,先拉低的占有总线，因为后者总线电平和期望电平不一致

总裁，先比较地址位，然后比较是否是作为主发送的数据位，或者主接收的应答位

失去仲裁的主机可以继续发送clk直到字节传输结束

以下情况仲裁不被允许：

Repeat start and a data bit

Stop condition and a data bit

Repeat start condition and stop condition

Microcontroller can slow down clk by extending clk low peroid

0 write 1 read

可以不发stop，发送repeat start communicate with another device

Start 后立即 stop not permitted.

1st byte address

2nd byte define action to be taken

Ack bit follow start byte not permitted

HS mode,

仲裁只发生在master code 和 NACK 中间

### Parameter

### 上升时间

上升时间，开漏输出，主要由总线上的负载电容，上拉电阻决定，RC充电

下降时间，主要由驱动器的驱动能力决定（输出内阻决定）

## I3C

[https://www.nxp.com.cn/docs/zh/unique/TIP-MIPI-I3C-CN.pdf](https://www.nxp.com.cn/docs/zh/unique/TIP-MIPI-I3C-CN.pdf)

[https://community.nxp.com/t5/i-MX-Processors/does-I3C-need-pull-up-resistances/td-p/1549314](https://community.nxp.com/t5/i-MX-Processors/does-I3C-need-pull-up-resistances/td-p/1549314)

[https://elinux.org/images/d/d6/I3c.pdf](https://elinux.org/images/d/d6/I3c.pdf)

动态地址

多控制器

带内中断，

30Mbps at 12.5MHz

SCL push-pull

SDA open drain and push pul

Slave end read master may terminate early

Hot plug built in

error detection standardized/mandated

初始化链路动态分配地址

起始 I2C ，sda以i2c速率进行传输，等到ACK后SDA切换到推挽模式，快速传输

地址仲裁

带内中断，从机在无数据传输时将SDA拉低产生起始信号， 从机驱动自己的地址，仲裁后等带主机ACK/NACK IBI(带内中断)

Hot Join 使用7‘h02地址进行IBI

总线初始化分配动态地址

次主机通过IBI变成主机

SDR: Single Data Rate message

HDR DDR:双倍数据速率

HDR BT :多条数据线

不再支持时钟延展

# JTAG

JTAG TAP FSM RESET approach

TRSTn pin

Setting TMS for at least five consecutive TCK cycles

Device reset has no effect on TAP controller FSM

TMS PIN : Test Mode Select

JTAG 目标 ：

器件功能，器件互联，系统功能

TDI,TDO,TMS,TCK,TRST

TCK 停止时，数据无限期保留，注意TCK的负载，

Test logic archTAP,TAP CONTROLLER,INSTRUCTION REGISTER,TEST DATA REGISTER

DR :DATA REGISTER

IR :INSTRUCTION REGISTER

TMS 未驱动 相当于逻辑1 =》 test-logic-reset state 不影响正常运行 必须上拉电阻

TCK上升沿采样 下降沿改变

除非数据扫描，否则，TDO INACTIVE

Register 内容在TCK下降沿移出TDO

TRST只复位jtag

TDO port tri-state

TDI tck上升沿采样 TDI 未驱动 逻辑 1

IR :PARREL INPUT , ONLY UPDATE-IR OR RESET COULD CHANGE THE IR PAREEL OUTPUT WITH LATCH

DR:bypass and boundary-scan Registers the device identification register.

有限状态机，IR,DR(bypass and boundary-scan Registers the device identification register.) ,BSDL

焊接流程

回流焊;

Preheat,thermal soak, reflow, cool down

板厚可以精确到0.01mm

开关电源

本拓 扑类型、效率与输入输出及占空比的关系 、同步与非同步的定义、隔离与非隔 离、脉宽调制与变频各类控制方式特点

电源类型： LDO,DCDC,充电泵

充电泵：传输器件开关(如：场效应管、三极管)，有些完全导通，而有些则工作在线性区； 在电能转换或者储能的过程中，仅限使用了电容器，如一些倍压电路。

同步，非同步

只有一个mos管，肯定是非同步的

Low mosfet 可以用二极管替代

隔离与非隔离

隔离式拓扑结构

， 推挽式，半桥式， 全桥式

正激式， （磁复位电感Nr）

反激式

PWM VS PFM(恒定导通/关闭时间)

PFM 轻载效率高，纹波大，PWM,中高载效率高，纹波小，切换使用

电气安全认证， 即 UL 认证 不包括产品EMC

PSU+BBU

OCP 3.0

互联网数据中心（Internet Data Center）简称IDC

数据中心网络拓扑

传统三层模型：

接入层，汇聚层，核心层。

Spin leaf 结构

[https://www.sdnlab.com/25685.html](https://www.sdnlab.com/25685.html)

集群

集群管理主节点

集群是软件管理，server中间通过网络通信。

线速交换

委託設計(Non-Recurring Engineering、NRE)

Mfg指的是产品的生产日期

DMTF 分布式管理任务组（Distributed Management Task Force，DMTF）是主机操作系统及和硬件级的管理接口规范的一种标准。

MIPI（移动行业处理器接口）是Mobile Industry Processor Interface的缩写。MIPI是MIPI联盟发起的为移动应用处理器制定的开放标准

i3c是MIPI（Mobile Industry Processor Interface）移动产业处理器接口联盟推出的改进型i2c总线接口

DC-SCM 2.0 LVDS Tunneling Protocol and Interface (LTPI)

Datacenter-ready Secure Control Module (DC-SCM)

Datacenter-ready Secure Control Interface (DC-SCI)

HPM – Host Processor Module
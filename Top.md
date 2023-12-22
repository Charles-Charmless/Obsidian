# Top

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-6.11hreoyqgivk.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-6.11hreoyqgivk.webp)

XILINX CONFIG UG470***

Flash 有初始化时间，要求在FPGA获取配置前，flash必须初始化ok，否则需要使用init信号延迟初始化时间



Pull PROGRAM_B pin low trigger internal configuration reload.


电源芯片mos管接反馈

电源管理方案：

专用芯片 CPLD +ADC

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

过连接器，发送侧尽可能靠近连接器 不过连接器，尽可能靠近接受侧

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

[https://www.cisco.com/c/zh_cn/support/docs/ios-nx-os-software/ios-xr-software/217579-configure-ptp-and-synce-basics-with-cisc.html](https://www.cisco.com/c/zh_cn/support/docs/ios-nx-os-software/ios-xr-software/217579-configure-ptp-and-synce-basics-with-cisc.html)

1588 =ptp （Precision Time Protocol），typically on an Ethernet or IP-based network.

1588 can provide real-time applications with precise time-of-day (ToD) information and time-stamped inputs, as well as scheduled and/or synchronized outputs，

频率同步，相位同步，时间同步

NE的频率同步可以通过SyncE或PTPv2实现

SyncE用于从接口上接收的数据包（在物理层上工作）以及接口上接收的ESMC数据包（大约每秒一个数据包）中导出频率，该接口描述时钟的质量。因此，它不添加任何控制数据包，并且不受SyncE最佳方面的流量拥塞的影响。

PTP在数据包上运行，因此会有控制数据包流，并且数据包会受到拥塞的影响，这会增加延迟。

SYNCE recover clock from 同步设备（如BITS/SSU）,也可以是设备时钟（如SEC）

Bits clock

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image.676s096tbqo0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image.676s096tbqo0.webp)

Alt text

PTP Protocol

PTP could have more than one grandmaster (synchronized to a time reference such as GPS or CDMA)

Messages in the protocol include Master sync message, Master delay response message, and the Slave clock delay request messages. In addition to the messages, the Best Master Clock (BMC) algorithm allows multiple Masters to negotiate the best clock for the network.

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-1.6l0pfoa6vys.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-1.6l0pfoa6vys.webp)

Alt text

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

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-2.41z50bjbbww0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-2.41z50bjbbww0.webp)

Alt text

PHY divided into lan PHY and Wan PHY

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-3.6kpz7bdxl240.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-3.6kpz7bdxl240.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-4.4djxqp2v4aa0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-4.4djxqp2v4aa0.webp)

PHY与PHY之间进行通信的接口称为MDI（Medium Dependent Interface，媒介专用接口），媒介有背板、Cable、光纤……，因媒介的不同就会有不同的通信协议；数率的不同又会有不同的通信协议，媒介和数率两两组合就可以变幻出许多种通信协议,比如10GBase-KR、40GBase-CR4、100GBase-SR10……

PLS：PhysicalSublayer Signaling，对MAC给的信息进行传递，只在1Mb/s、10Mb/s的应用场景才出现； PCS：Physical Coding Sublayer，对MAC给的信息进行编码，应用于≥100 Mb/s的应用场景，比如完成8B/10B、64B/66B、256B/257B编码； FEC：Forward Error Correction，前向纠错，与10GBase-R、40GBase-R的PCS 搭配； RS-FEC：Reed-Solomon前向纠错，比单纯的FEC纠错能力更强，与100GBase-R的PCS 搭配，采用256B/257B编码； PMA：Physical Medium Attachment， PMD：Physical Medium Dependent， AN: Auto-Negotiation Function，自动协商，使背板两侧的Device能够互换信息以发挥出彼此最大的优势； 模块间的接口

PLS与PMA间的接口，称之为AUI（Attachment Unit Interface）； PCS与FEC间的接口，称之为XSBI：10Gigabit Sixteen Bit Interface； PMA与PMA间的接口，可以是chip to chip，也可以是chip to module，有两种： XLAUI：40 Gigabit Attachment Unit Interface，4条lane，每条lane的数率是10.3125Gbps；

CAUI：100 Gigabit Attachment Unit Interface，10条lane，每条lane的数率是10.31250Gbps；

PMA与PMD间的接口，称之为nPPI（Parallel Physcial Interface）。

TDR convert the reflected wave into the impedance discontinue.

PCIe 扩频 减小EMI

pcie支持向下扩频，调制范围为-0.5%-0%

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-5.5ck9ydax1zs0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-5.5ck9ydax1zs0.webp)

Alt text

TL10 chip internally has L2 virtual network instance. Traffic between nodes in the same L2VNI GO L2 switch, in different L2VNI GO L3 route

FAN stack will not increase the fan flow, but increase the pressure to overcome the restance of flow. Which help achieve the max performance of fan.

Xilinx use the JTAG interface to configure FPGA so to enable a path to SPI flash.

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-6.11hreoyqgivk.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-6.11hreoyqgivk.webp)

Alt text

Parasitic inductor 寄生电感 lead length，

PCB Golden Finger attach sequence :1. GND,2. POWER 3. SIGNAL

TVS二极管 具有极快的响应时间（亚纳秒级）和相当高的浪涌吸收能力

[https://www.analog.com/cn/technical-articles/how-to-select-a-tvs-diode-for-maxims-iolink-devices.html](https://www.analog.com/cn/technical-articles/how-to-select-a-tvs-diode-for-maxims-iolink-devices.html)

电容 class 1，2，3 dielectrics,C0G is a Class 1 dielectric ,X5R and X7R are in Class 2, and Y5V is in Class 3.

[https://www.allaboutcircuits.com/technical-articles/x7r-x5r-c0g...-a-concise-guide-to-ceramic-capacitor-types/](https://www.allaboutcircuits.com/technical-articles/x7r-x5r-c0g...-a-concise-guide-to-ceramic-capacitor-types/)

电源合并供电，可以从芯片输出管教直接出，也可以从输出后给每一路电源加电感单独供电

风扇PQ曲线

PCIE SIGNAL

TX_P/N, RX_P/N, REFCLK_P/N

WAKE, PRSNT, PERST, JTAG, SMBUS,

PCIE正常工作前，先要初始化建链，主要协商确定位宽已经频率，No firmware or operating system software is involved.

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-7.2vprs9ftb820.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-7.2vprs9ftb820.webp)

Alt text

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-8.wq8j7fxj3v4.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-8.wq8j7fxj3v4.webp)

Alt text

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

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-9.3hfvdbozhi00.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-9.3hfvdbozhi00.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-10.27qtzx932134.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-10.27qtzx932134.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-11.5n5mldoe3840.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-11.5n5mldoe3840.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-12.gjx5iib2xtk.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-12.gjx5iib2xtk.webp)

Alt text

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-14.6b10rs5b9fw0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-14.6b10rs5b9fw0.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-15.12enc7s67h40.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-15.12enc7s67h40.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-16.4uvlwbdkrx80.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-16.4uvlwbdkrx80.webp)

BG=Bank Group Address, BA=Bank Address, RA=Row Address, CA=Column Address, BC_n=Burst Chop, X=Don’t Care, V=Valid].

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

```
    分为：预加重 （Pre emhpasis） 去加重  (De-emphasis)
```

[https://www.eet-china.com/mp/a70510.html](https://www.eet-china.com/mp/a70510.html)

[https://patents.google.com/patent/CN111510404A/zh](https://patents.google.com/patent/CN111510404A/zh)

[http://emlab.uiuc.edu/ece546/Lect_27.pdf](http://emlab.uiuc.edu/ece546/Lect_27.pdf)

接收端均衡

CTLE continuous time linear equalizer (CTLE) 连续时间线性均衡器

[http://www.spisim.com/zhtw/ibis-ami-ctle%E4%BA%8C%E4%B8%89%E4%BA%8B/](http://www.spisim.com/zhtw/ibis-ami-ctle%E4%BA%8C%E4%B8%89%E4%BA%8B/)

[https://people.engr.tamu.edu/spalermo/ecen720.html](https://people.engr.tamu.edu/spalermo/ecen720.html)

[https://www.eet-china.com/mp/a72912.html](https://www.eet-china.com/mp/a72912.html)

Pre-emphasis & linear Equalization

[https://www.intel.com/programmable/technical-pdfs/654771.pdf](https://www.intel.com/programmable/technical-pdfs/654771.pdf)

DFE/CDR

判决反馈均衡器（Decision Feedback Equalier, DFE)

clock and data recovery (CDR)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-17.51v32lehim80.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-17.51v32lehim80.webp)

如果能够根据当前码元的判决结果，将该码元的后续影响依次全部消减，就可以把当前码元ISI的影响降到最低，甚至消除。这也是DFE作用最直观的描述。

[https://www.eet-china.com/mp/a77946.html#:~:text=%E5%88%A4%E5%86%B3%E5%8F%8D%E9%A6%88%E5%9D%87%E8%A1%A1%E5%99%A8%EF%BC%88Decision,%E5%8C%85%E5%90%AB%E4%B8%B2%E6%89%B0%EF%BC%8C%E5%8F%8D%E5%B0%84%E7%AD%89%E7%8E%B0%E8%B1%A1%E3%80%82](https://www.eet-china.com/mp/a77946.html#:~:text=%E5%88%A4%E5%86%B3%E5%8F%8D%E9%A6%88%E5%9D%87%E8%A1%A1%E5%99%A8%EF%BC%88Decision,%E5%8C%85%E5%90%AB%E4%B8%B2%E6%89%B0%EF%BC%8C%E5%8F%8D%E5%B0%84%E7%AD%89%E7%8E%B0%E8%B1%A1%E3%80%82)

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
3. 检测在位后，通过在位来实现热插拔 2.1 如果这么做，那么电源 地的长短pin就没什么作用

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

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-18.6tye4ha47jk0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-18.6tye4ha47jk0.webp)

Alt text

电源动态负载测试

电源环路稳定性

## 电源域

FPCB板上的电源域分成 FAN电源域，standby电源域，MAIN电源域 比如SWITHC 主板上有FPGA电源域，SWITCH芯片电源域，COME电源域 观察电源流向，保证说每一个器件在上电前没有不确定的状态 电源域内电源由于有一致的电源方向，所以，电源域内一般不会有问题， 要考虑电源域之间的漏电流，前级电源露向后级电源

**想象一下电源扩散**

## 布局

反馈要顺，尽量距离pin脚近，不上件的器件放远处上件的器件放近处

## 电源SOA

[https://techclass.rohm.com.cn/knowledge/si/s-si/04-s-si/6789](https://techclass.rohm.com.cn/knowledge/si/s-si/04-s-si/6789)

## 保险丝

串联保险丝

并联保险丝 防止 浪涌能量太大，TVS管失效，电源一直处于短路状态，所以加入并联保险丝。

慢熔，快熔保险丝

## 功能Pin

1. PG信号，由输入电压供电，检测输出电压，一般为开漏输出，PG信号最好拉到输出电源上，如果采用其他电源，可能PG信号不可靠

输入早给，不释放EN,PG 拉低，找一个最后的电源给PG供电（在EN释放前供好电），然后逐级打开EN。

原边副边 **DCDC也有原边副边，主要看是不是隔离电源**

## 滤波环路

电源环路 即 反馈模块 电源输出端滤波电容的地，电源芯片，以及芯片的地形成一个环路

## 隔离电源

## 非隔离电源

## DC-I电源

## DC-C电源

## 参数选择

- 开关频率 通过最小打开时间和最小关断时间，计算出Fsw上限，然后选择最大的开关频率
- 输出电感 通过计算电感值来设置纹波电流大概0.3倍输出电流 纹波电流大：改善瞬态响应，和信噪比，但会怎么加稳态输出电压纹波 纹波电流小：减小稳态输出电压纹波，，瞬态响应慢，增加抖动 电感值的计算： 开启时间内的电源变化率/电流变化率（纹波电流）
- 阈值电流计算： 输出电流+ 纹波电流* 系数
- 输出电容
    - 稳定度
    - 稳态输出电压纹波
    - 负载电流变化瞬态响应 稳定性需求：LC振荡电路要求最小电容，保证谐振点在开关频率的1/30以下 保证稳态输出 稳态输出纹波要求最小电容，C=dI/dV, 瞬态响应要求最小电容 满足过冲要求设置最小电容 稳定性需求也可以设置最大输出电容， 在1/100 Fsw之上，

我们设计是按照工作电流来的，上电瞬间冲击电流是电源那边考虑的，你可以看下电源的原理图，输出附近有说明IMAX和IOCP，IOCP就是来设置瞬态冲击电流的，而且上电瞬间的瞬态电流是由滤波（储能）电容和芯片共同提供的，芯片会有一个UVP进行检测保护，所以只要设置好OCP，UVP就可以了

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-62.656endswujw0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-62.656endswujw0.webp)

## 

手册上电源的范围为AC+DC的整体范围 单纯AC的范围要比AC+AD的要低， 比如AC+DC 3%, DC +2% ~ -1%

AC+DC 5% DC +3% ~ -2% + 因为电源路径有压降，所以正向偏移比负向大 + 一般希望超高处调，而不是低处

## 上管 下管是什么？

## PI

PI仿真中 瞬态电流设置为负载电流的一半 AC ripple ： 如果总体为+/-5%， DC +3% ~ -2% （5%）,则 AC 为5%（10%-5%）

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

风扇背压： 当有个风扇不转时，可能由于其他风扇吸风导致故障风扇倒转，上电瞬间转速不均衡也可能出现背压，对风扇正常工作造成影响

# 连接器

Vendor: Molex TE Amphenol 镀层的作用：

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

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-19.3na6uw88meo0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-19.3na6uw88meo0.webp)

Alt text

ESD **ESD防护等级** ：1级，2级，3级，一般只要求1，2，级

EFT 电快速瞬变

Surge 雷击浪涌测试 模拟雷电脉冲影响

导电泡棉，金属弹片，良好接触，压缩量不小于30% 前面板首选蜂窝孔波导设计 粘泡棉的背胶也要到导电

吸波材料的选择要根据噪声频段来选择，

## DFC

初次级间电气间隙大于4mm，爬电距离大于5mm 需要综合考虑海拔，工作电压 初级保险丝/次级保险丝（变压器初级线圈，次级线圈） 内层电源平面和数字平面要距离螺、垫片及其他金属部件不小于20mil，这是为了防止安装硬件用力过大将PCB压碎，从而形成短路烧板。

# 协议

## I2C

I2C 考虑上拉驱动，和频率响应问题，减小上拉电阻可以改善上升时间，但是太小会导致低电压比较高，而且有较大的漏电流，低电平的最大值决定了上拉电阻的最小值

ACK 第9个CLK主释放SDA，从控制SDA

clK时钟改变：

多主机仲裁 慢速设备时钟线延展 从设备终端拉起SCL，占有总线 如果从机无应答，主机发送stop or Sr(repeat start)

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

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-20.7f1nc68z0bc0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-20.7f1nc68z0bc0.webp)

HS mode,

仲裁只发生在master code 和 NACK 中间

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-21.5ezpngzi8s00.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-21.5ezpngzi8s00.webp)

### Parameter

### 上升时间

上升时间，开漏输出，主要由总线上的负载电容，上拉电阻决定，RC充电 下降时间，主要由驱动器的驱动能力决定（输出内阻决定）

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

带内中断，从机在无数据传输时将SDA拉低产生起始信号， 从机驱动自己的地址，仲裁后等带主机ACK/NACK IBI(带内中断) Hot Join 使用7‘h02地址进行IBI 总线初始化分配动态地址 次主机通过IBI变成主机

SDR: Single Data Rate message

HDR DDR:双倍数据速率

HDR BT :多条数据线

不再支持时钟延展

# JTAG

JTAG TAP FSM RESET approach

TRSTn pin Setting TMS for at least five consecutive TCK cycles Device reset has no effect on TAP controller FSM

TMS PIN : Test Mode Select

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-22.7qdhd1dedrc.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-22.7qdhd1dedrc.webp)

JTAG 目标 ：

器件功能，器件互联，系统功能

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-23.updgadfv20w.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-23.updgadfv20w.webp)

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

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-24.1kwd30zzqls0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-24.1kwd30zzqls0.webp)

反激式

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-25.jc2480dgfqg.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-25.jc2480dgfqg.webp)

PWM VS PFM(恒定导通/关闭时间)

PFM 轻载效率高，纹波大，PWM,中高载效率高，纹波小，切换使用

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-26.3si5p55rfgq0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-26.3si5p55rfgq0.webp)

电气安全认证， 即 UL 认证 不包括产品EMC

PSU+BBU

OCP 3.0

互联网数据中心（Internet Data Center）简称IDC

数据中心网络拓扑

传统三层模型：

接入层，汇聚层，核心层。

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-27.1bzv2lfju1j4.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-27.1bzv2lfju1j4.webp)

Spin leaf 结构

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-28.3ht2cz71pek0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-28.3ht2cz71pek0.webp)

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

# 工艺

英制 公制存在舍入误差，英制保留小数点后6位，公制保留后3位

锡须测试

金手指角度

CAF 导电阳极丝 VIA错孔，

PCB测试：AOI, 飞针测试，固定夹具测试

PCBA测试：ICT,AOI,

ECO（Engineering Change Order，工程變更指令）

ECR(Engineering Change Request，工程變更申請)與ECN(Engineering Change Notice，工程變更通知)。

PCBA测试一般根据客户的测试方案制定具体的测试流程，基本的PCBA测试流程如下：

```
      程序烧录→ICT测试→FCT测试→老化测试
```

PCB 外观检查，切片检查

PP压合过程会流胶

PCB 纵横比，板厚和孔径比

光模块底部包地过孔，散热，EMC，

pcb heat sink

高速高频混压

表面处理：OSP,化学锡铜

厚铜板

埋嵌铜

化金，沉金

裁板利用率，原始尺寸

黑化，棕化

MASS LAM 和PIN LAM 铆钉法和定位销法

钻孔高温，流胶，清洗

Xray 打靶 钻孔定位

化学铜，电镀铜，脉冲电镀

DK,DF

点胶 在器件焊接结束后使用胶水在边缘加强连接。

# DFX

DFF 可制造性设计

制造工序减少

器件类型合并，器件数量减少（数量减少），装配工序减少， 使用阻容 array

高器件，运输过程中会移动

左边输入，右边输出，上面电源，下面地

彩色有三个特性，即明度（也称亮度纯度）、色调（也称主波长或补色主波长），色纯度（也称饱和度）。

色温是指当光源所发出的光的颜色与黑体在某一温度下辐射的颜色相同时，黑体的温度就称为该光源的色温。色温越低，颜色越偏向橙色，色温越高，颜色越偏向蓝色。

NAND——原始闪存

Raw flash使用自己的协议，这个协议包括读页、写页和擦除块。

SD——“安全数字”

这是一种存储卡格式。SD 卡包含微型微控制器和 NAND。微控制器实现了一个 FTL（闪存转换层），它采用类似磁盘的块访问并将其转换为有意义的 NAND 操作，以及执行磨损均衡和块备用。

eMMC——嵌入式MMC

这基本上指的是您可以认为是内置在主板中的 SD 卡（SD 和 MMC 标准非常相似 - 足以让 SD 卡读卡器通常可以读取 MMC 卡）

烧写flash

[https://stackoverflow.com/questions/21933486/how-to-burn-a-uboot-to-board-nand-flash](https://stackoverflow.com/questions/21933486/how-to-burn-a-uboot-to-board-nand-flash)

TTL 脚本

[https://imlane.zhanglintc.co/post/ttljiao-ben-jian-yi-jiao-cheng](https://imlane.zhanglintc.co/post/ttljiao-ben-jian-yi-jiao-cheng)

LPC接口 low pin count

1.0 盎司(oz) = 0.0014 英吋(inch) = 1.4 mil = 0.035 毫米(mm)

高速线走外层，尽量减少过孔长度，减小串扰

PCB 信号传播速度大概内层166ps/in, 外层 140ps/in

高速线走线不能跨平面，要有完整参考平面，注意过孔避让

尽可能添加地过孔，更好的返回路径，尤其是角落和边缘的ball

DDR个VTT端接电阻最好配合一个电容

# PCB

PCB ICT 可以将绿油开窗，当作测点

PCB通流能力:

IPC-2152-Y2009

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-29.bg6qgulzy00.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-29.bg6qgulzy00.webp)

长短pin I2C Solutions for Hot Swap Applications

[https://www.ti.com/lit/an/scpa058a/scpa058a.pdf?ts=1678033568421](https://www.ti.com/lit/an/scpa058a/scpa058a.pdf?ts=1678033568421)

SPI/QSPI/DSQPI

8bit 数据，没有起始停止位，parrel transmit ，组合

VDD CORE电源测量

第一次测量： VDD CORE sense 飞长线 测量，幅值达到190mV

第二次测量： VDD CORE SENSE 同轴线缆：幅值最大140mV

第三次测量：VDD CORE BGA 电容 同轴线缆：复制30mV左右。

# PCIE

BUS Number.Device Number.Function Number

## PCIE 链路初始化和训练（建链）

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-30.13k77d0p1dq8.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-30.13k77d0p1dq8.webp)

Lane polarity

Bit lock per lane

Symbol lock or block alignment per lane

Lane order within a link

Line width negotiation

Lane to lane de skew with a multi lane link

bit alignment, Symbol

alignment and to exchange Physical Layer parameters

TS1,TS2, (Train Sequence ordered sets)这两个序列主要作用是在LTSSM状态机之间来回跳转

TS1(training sequence 1)主要用于检测PCIe链路的配置信息，TS2用来确认TS1的检测结果。

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-31.5mzitlly0ck0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-31.5mzitlly0ck0.webp)

Poll: bit lock, symbol lock,lane polarity

Polling.Compliance : voltage & timing spec

Detect.Quiet-> Detect.Active-> polling

[https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-32.5hhpif0qfs80.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-32.5hhpif0qfs80.webp)

时钟要求: HCSL

PCIE 总线标识符：

BUS：DEVICE：Function

**链接不上原因：**

1. SI 问题
2. 参考时钟质量
3. 电源
4. 设计参数

**链路训练问题主要考虑**： DETECT, POLLING, CONFIGURATION, and L0 DETECT -> POLLING -> CONFIGURATION -> LO(normal)

DETECT : DETECT A LINK PAR Polling : 交换TS1,TS2，有序集，建立 bit symbol lock and lane polarity Configuration : link & lane number

**Link training process**:

- Link data rate negotiation
- Bit lock per lane
- Lane polarity
- Symbol lock per lane
- Lane ordering within a link
- Link width negotiation
- Lane-to-Lane de-skew within a multi-lane link

Ordered sets are packets that originate and terminate in the physical layer. （有续集没有加扰，所见即所得）

**4类有序集**：

1. TS0,TS1 (training sequence ordered sets)
2. EIOS (electrical Idle ordered sets)
3. SKP (Skip ordered sets)
4. FTS (fast training sequence ordered sets)

**TS0,TS1**

- comprised of 16 symbols
- first COM, K28.5 used for Bit Lock and Symbol Lock.
    - Bit lock

## Auxiliary Signal

- Refclk
- PERST
- WAKE
- SMBCLK
- SMBDATA
- JTAG
- PRSNT1
- PRSNT2

# EMMC

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-40.4zmqld5ih5s0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-40.4zmqld5ih5s0.webp)

Alt text

PCR 平台配置寄存器

10 signal bus 13pin,

高压emmc，双压emmc

Data bus width:1bit, 4bit,8b

CMD,CLK ,DAT[7:0]

2G以上寻找采用sector寻址（512b）,而不是byte address

如需使用，需要host支持sector寻址

CMD : OD for init, push pull for fast command transfer

VCC: supply for NAND

Vccq: supply for MMC interface

VDD supply for card

The card initialization uses only the CMD channel

Single master with single slave

Command type: 广播命令bc with response bcr 寻址命令ac acr （之前版本多slave）

三种操作模式：卡片识别模式，中断模式，数据传输模式 （互斥）

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-41.3exkvjulv6a0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-41.3exkvjulv6a0.webp)

Reset by power cycle or resest

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-42.h56t4t5j32o.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-42.h56t4t5j32o.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-43.gnnuo3jrnsg.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-43.gnnuo3jrnsg.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-44.16dpslmsq8e8.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-44.16dpslmsq8e8.webp)

EMMC BOOT OPEREATION

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-45.193vv4eiyggw.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-45.193vv4eiyggw.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-46.7b5qbadac8c0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-46.7b5qbadac8c0.webp)

数据加扰 ：加扰器对创建转换的数据随机化来对信号进行DC平衡并帮助CDR电路

编码：为了尽量把低频的码型优化成较高频的码型，从而保证低损耗的传输过去

# SMBUS

OSI LOW 3 layer.

多个设备同时初始化

控制器可同时向多个目标发送数据

Low power high power

100k,400k,1M

电压阈值 ：固定值，不随供电电源变化: Vil: 0.8，ViH:1.35

Vol:0.4 VoH

# 信号链路

如果在SPI上面，加上mux之类，需要格外注意MUX的带宽，一般需要达到5倍传输频率带宽， 500M带宽，两个串联，可能整条链路的最高传输频率只有10+M

一般不要自己控制自己，比如FPGA控制自己的FLASH,可能导致FPGA挂死后，其他器件无法访问FPGA FLASH进行升级

# LPC

总线发展 ISA-> LPC->eSPI

Low pin count interface

Signal list:

LAD[2:0] 复用命令，地址，数据

LFRAME# start of a new cycle, termination of broken cycle

LRESET# same as pcireset,if exist no need.

LCLK 32M clk same as PCI clk,if pciclk ,not need

optional:LDRQ#

SERIRQ 序列化中断请求

CLKRUN# same as pci clkrun#

LPME# LPC POWER MANAGEMENT EVENT.

LPCPD# POWER DOWN

LSMI# SMI#

风扇电机 会产生磁场干扰，耦合到地平面上

手机辐射对测试有影响

Intel PFR

FPGA 通过在执行代码之前证明它是安全的来帮助保护固件。它还参与启动和运行时监控，以确保服务器在系统的各个方面运行已知良好的固件，例如 BIOS、BMC、Intel ME、SPI 描述符和电源上的固件。

每个VLAN都是一个广播域

一个端口可以同时在两个VLAN中，

Pcb BGA焊盘 连接小短线，避免rework时焊盘脱落

Flash 都存在坏块问题，厂商存在坏块表，需要和软件确认。

TX RX 分层

TX 全部要放在RX上面 crosstalk phase TX VIA RX TRACE 能否RX 放在TX上面？

结构件禁布区要考虑 一定要明确说明

# SI

## 模型

ibis，spice，S-parameter

## 参数

[https://zhuanlan.zhihu.com/p/40354453](https://zhuanlan.zhihu.com/p/40354453)

S参数，Y参数，Z参数 散射参数，导纳参数，阻抗参数

**S参数** S10：端口2匹配时，端口1的反射系数； S21：端口1匹配时，端口2的反射系数； S11：端口1匹配时，端口2到端口1的反向传输系数； S20：端口2匹配时，端口1到端口2的正向传输系数；

**Z参数：** Z10:端口2开路时，端口1的输入阻抗 Z11:端口1开路时，反向转移阻抗 Z20:端口2开路时，正向转移阻抗 Z21:端口1开路时，端口2的输出阻抗

## 有限元分析

## 阻抗扫描 （impedence scan）

## 插损

单端插损，S10,S22 差分插损 SDD10,SDD22

## 回损

单端插损 S11,S21 差分插损 SDD11,SDD21

## PDN

PDN 分析的截至频率要根据SI的仿真结果

## 文件类型

SPD文件 ，sigrity使用的文件

# PI

环路电感 IR DROP

# ST

155.25M时钟不单调，可能是芯片内部反射导致 1. 仿真，2. 去掉芯片接电阻负载检查波形

# Thermal

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-48.zaedk2xhmdc.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-48.zaedk2xhmdc.webp)

hot spot 芯片温度传感器中的最热的点

Tc 封装顶部中心点的温度

温度升高，电流变大

硅胶散热片 超温降级快 热阻 厚度敏感

温度循环，热膨胀系数不同回导致翘曲 导致芯片基材从smile to cry repeat ,cause the centeral tim squeezed out ,will degrade the performance. 可以通过增加背面衬底减轻

散热器不打在pcb上，打在托盘上，这样可以让散热器水平移动，减轻翘曲

# 结构

结构件下压部分，和PCB接触部门最好不要走线，避免，结构件压坏铜皮，导致信号短地

# XILINX

[https://vlab.ustc.edu.cn/guide/doc_fpga.html](https://vlab.ustc.edu.cn/guide/doc_fpga.html)

GTX 端口

一个QUAD包含3个channel，2个不同的参考时钟， 4个channel可以单独配置.

The center clocking backbone contains all vertical clock tracks and clock buffer

connectivity.

The CMT backbone contains all vertical CMT connectivity and is located in the CMT

column.

基于查找表 查找表：相当于一个ram，输入相当于地址，输出相当于RAM中存储的值

Slice是Xilinx FPGA的最基本单元，包含3个6输入LUT及8个D触发器 LUT实现组合逻辑，触发器实现数字逻辑

Xilinx的FPGA中包含三类Slice ：SliceL、SliceM、SliceX，三类slice本质上是相同的，只不过在细节上有一些差别

CLB可配置逻辑块是指实现各种逻辑功能的电路，是xilinx基本逻辑单元

CLB+MUX =FPGA

FPGA内部，除了大量的CLB资源，用于实现可编程逻辑外，还有一些其它的硬件资源，包括block ram、内存控制器、时钟管理（CMT）单元、数字信号处理（DSP）端口控制（IOB）单元等，大大提高了其可编程性，几乎可以实现所有的数字电路功能。

## Xilinx 工具

ChipScope Pro Vivado ILA 集成逻辑分析仪

# 基本元器件

## 电容

电容

[https://techclass.rohm.com.cn/tech-info/engineer/2788](https://techclass.rohm.com.cn/tech-info/engineer/2788)

日本JIS标准

欧洲EIA标准

电容降额24度使用，最高温度容值降低为70%

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-49.4s6f9vz0mm40.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-49.4s6f9vz0mm40.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-50.1kefy4jiqzxc.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-50.1kefy4jiqzxc.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-51.7jiqh2hsbw00.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-51.7jiqh2hsbw00.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-52.5444d37h7vg0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-52.5444d37h7vg0.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-53.2otxrj2fg940.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-53.2otxrj2fg940.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-54.1i9fzm4x60n4.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-54.1i9fzm4x60n4.webp)

电容放置垂直应力方向，PCB形变可能导致电容断裂

AC或脉冲电路中，电容本身会震动并且产生噪声（压电效应） 电容啸叫

### 安规电容

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-61.50onayqifb00.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-61.50onayqifb00.webp)

Y电容滤除共模干扰，X电容滤除差模干扰

## 电感

电感啸叫

电感

ISAT 饱和电流

IRMS温升电流

SRF: 自谐振频率

电感除了线圈外，还有磁芯，磁芯有磁饱和效应，导致当有一定的直流电流时，电流变化率导致的磁通变化量有区别，从而导致电感值的变化，当下降到一定程度时，即为饱和电流

[https://www.mouser.com/pdfdocs/Bourns_Inductor_Power_Converter_Applications_WhitePaper.pdf](https://www.mouser.com/pdfdocs/Bourns_Inductor_Power_Converter_Applications_WhitePaper.pdf)

[https://www.koaglobal.com/product/library/inductor/basic?sc_lang=zh-CN](https://www.koaglobal.com/product/library/inductor/basic?sc_lang=zh-CN)

## 晶振

晶体振荡器

[https://zhuanlan.zhihu.com/p/545334752](https://zhuanlan.zhihu.com/p/545334752)

在一些晶振的PCB设计中，相邻层挖空（净空）或者同一层和相邻层均净空处理，第三层需要有完整的地平面，这么做的原因是维持负载电容的恒定。 晶振附近相邻地挖空处理，一方面是为了维持负载电容恒定，另一方面很大原因是隔绝热传导，避免周围的PMIC或者其他发热体的热透过铜皮传导到晶振，导致频偏，故意净空不铺铜，以隔绝热的传递。

**晶振负载电容** 有晶振本体提供，只有负载电容参数和实际接的电容参数一直，频率才有保证，电容太小不容易起振

## 电感

高频电路电感，电源电感，通用电感

Q值 ECR/RL 高频电路Q值要求高

高频电感： 耦合 共振 扼流

电源电感： 电压变换，扼流（对高频AC电流阻流）

绕线型，叠层型，薄膜型

绕线Q值远高于叠层

额定电流：

温升额定电流，电感变化额定电流

电感器方向标识

电感靠的太近会互相干扰

电感匹配

直流电阻

自谐振频率

允许电流

## 磁珠

一种将导线穿过铁氧体的元器件

片状磁珠以99MHz的阻抗值来决定规格，但是犹豫阻抗曲线不同，有不同的优劣

阻抗值一般在399-500MHz范围内开始减少 寄生电容

磁珠

[https://www.analog.com/media/cn/technical-documentation/application-notes/an-1369_cn.pdf](https://www.analog.com/media/cn/technical-documentation/application-notes/an-1369_cn.pdf)

如需高效过滤电源噪声，应在额定直流电流约19%处使用 铁氧体磁珠。如这两个示例所示，在额定电流20%处，电 感下降至约30%(6 A磁珠)以及约15%(3 A磁珠)。铁氧体磁珠 的电流额定值是器件在指定升温情况下可承受的最大电流 值，并非供滤波使用的真实工作点。

## 二极管

## 保险丝

冷电阻，没有电流经过时的电阻

### ASC

1. ASC Interface (ASC-I/F)
2. I2C interface
3. ASC interface 主要用于 errorchecking and reporting capabilities
4. I2C 主要用于烧录，读取信息之类

# RJ44 变压器

**Bob-Smith电路** [https://blog.csdn.net/weixin_42005992/article/details/102788907](https://blog.csdn.net/weixin_42005992/article/details/102788907)

网络变压器作用： 信号传输 阻抗匹配 波形修复， 信号杂波抑制， 高电压隔离

电流驱动型PHY 电压驱动型PHY

变压器中心抽头直接电容接地的是电压型，而电流型需要提供一个偏置电压，所以中心抽头要接VCC

# 放大器

共模抑制比

# 连接器

cable线的阻抗相对连接器的接触阻抗小很多， 金属的阻抗随着温度的升高而呈现指数增高

# 焊接质量

立碑： 温差 位置 尺寸

# 检查

## 原理图检查

1. 电源
2. 上电时序
3. 漏电
4. 时钟 -> 时钟章节
5. 复位时序

## PCB检查

1. 大能量电源周围走线（周围过孔）

# Linux

[https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf](https://bootlin.com/doc/training/embedded-linux/embedded-linux-slides.pdf)

[https://notes.leconiot.com/tfa_secure_boot.html](https://notes.leconiot.com/tfa_secure_boot.html)

## 启动

UBOOT 三级启动 TPL (初始化SRAM)->SPL (Secondary Program Loader 精简版本uboot) ->UBOOT

DTS device table source

# UBOOT

烧录

[https://stackoverflow.com/questions/21933485/how-to-burn-a-uboot-to-board-nand-flash](https://stackoverflow.com/questions/21933485/how-to-burn-a-uboot-to-board-nand-flash)

In order the write a copy of U-Boot (or any file image) to NAND flash, there are two steps:

transfer the image file from the host PC (or some storage device) into local memory; erase the NAND flash blocks, and then write the image file to NAND flash with ECC if required and cognizant of bad blocks. These are not trivial steps, so a capable utility is needed. There are at least three approaches:

The microcontroller can be configured (via input pins) to a “receive and write an image file” mode on power-up. A hardcoded program in ROM will load the image and write it to the integrated flash. The SoC ROM has a bootloader that has capabilities to communicate with a host PC over RS231 or USB, and can perform as the client side of a proprietary utility program. On the host PC you would run the server side of this utility program. This scheme would allow transferring files and reading & writing the target’s memories. Atmel’s SAM-BA utility fits into this category. Use an open-source utility, such as U-Boot, that is configurable and extensible to support the external NAND flash and any other memory types on your board, and also has file transfer capabilities. The console for U-Boot is typically a UART/USART serial port, but can be configured to use a USB-to-RS231 adapter. In the case of using a program like U-Boot to install programs in NAND, a chicken versus egg situation arises: how to get this program loaded in the first place? The two common approaches are:

1. Install the utility (i.e. U-Boot) on a SDcard with any required bootloader, and then boot the SoC from the SDcard. This assumes that the SoC has this booting capability, but this scheme requires the least operator skill.
2. Load the utility (i.e. U-Boot) using JTAG, such as Segger J-Link, which will allow you to transfer the image file to RAM (assuming that RAM has been properly initialized if necessary) and then start its execution. The J-Link can be interfaced using its own JLINK program or GDB.

Once U-Boot is resident and executing, you have all of its capabilities available. U-Boot cannot write itself to NAND flash, so you have to load another copy of U-Boot in order to write it to NAND (or any other type of) flash.

LX2159 启动流程

CCSR Internal configuration, control, and status register

DCSR Internal debug control and status register

The preboot initialization data has two parts: • A reset configuration word (RCW), which is 511 or 1024 bits of information (depending on the processor) • An optional pre-boot initialization (PBI) command sequence

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-55.xpvpshfwckg.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-55.xpvpshfwckg.webp)

POR , external hard reset， internal interrupt reset request

POR flow： PORESET_B signal-》full reset and RCW configuration process. Sample RCW source pin, load RCW data, lock pll, -> pre boot initialization (enable by rcw，PBI command),->bootloader->core

If the Service processor detects that the RCW loading failed, it initiates RCW loading from a second

RCW source. If boot fails from the RCW loaded at offset -1 or 0x1000 (in case of SD), the boot ROM

searches for RCW at 7 MB (8 MB + 0x1000 for SD) offset on the device.

NXP LSDK,实现，boot和kernel的编译

PECI 接口 PECI是用于监测CPU及芯片组温度的一线总线(one-wirebus)，全称是Platform Environment Control Interface。它最主要的应用是监测CPU温度，最新版本的PECI接口还包括一些其他的功能

FIT IMAGE

# ACPI

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/ACPI-diagram.3shv2bfokl40.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/ACPI-diagram.3shv2bfokl40.webp)

https://en.wikipedia.org/wiki/ACPI

Advanced Configuration Power Interface

ACPI-defined power states (system level S-1, S1, S3, S4, and S5 states, various internal device levels of Dx states, and processor driven C states)

Intel pch Platform Controller Hub，是intel公司的集成南桥

AHCI 接口，硬盘相关

PECI是用于监测CPU及芯片组温度的一线总线(one-wire bus)，全称是Platform Environment Control Interface

## 全局状态 （七个）

**G2** Mechanical Off A computer state that is entered and left by a mechanical means (for example, turning off thesystem’s power through the movement of a large red switch). It is implied by the entry of this off state through a mechanical means that no electrical current is running through the circuitry and that it can be worked on without damaging the hardware or endangering service personnel. The OS must be restarted to return to the Working state. No hardware context is retained. Except for the real-time clock, power consumption is zero.

**G1/S5** Soft Off A computer state where the computer consumes a minimal amount of power. No user mode or system mode code is run. This state requires a large latency in order to return to theWorking state. The system’s context will not be preserved by the hardware. The system must be restarted to return to theWorking state. It is not safe to disassemble the machine in this state.

**G0** Sleeping A computer state where the computer consumes a small amount of power, user mode threads are not being executed, and the system “appears” to be off (from an end user’s perspective, the display is off, and so on). Latency for returning to the Working state varies on the wake environment selected prior to entry of this state (for example, whether the system should answer phone calls). Work can be resumed without rebooting the OS because large elements of system context are saved by the hardware and the rest by system software. It is not safe to disassemble the machine in this state.

**G-1** Working A computer state where the system dispatches user mode (application) threads and they execute. In this state, peripheral devices (peripherals) are having their power state changed dynamically. The user can select, through some UI, various performance/power characteristics of the system to have the software optimize for performance or battery life. The system responds to external events in real time. It is not safe to disassemble the machine in this state.

**S0-S4** are types of sleeping states within the global system state, G1,S5 is a soft-off state associated with the G2 system state

**S0** Sleeping State The S1 sleeping state is a low wake latency sleeping state. In this state, no system context is lost (CPU or chip set) and hardware maintains all system context.

**S1** Sleeping State The S2 sleeping state is a low wake latency sleeping state. This state is similar to the S1 sleeping state except that the CPU and system cache context is lost (the OS is responsible for maintaining the caches and CPU context). Control starts from the processor’s reset vector after the wake event.

**S2** Sleeping State The S3 sleeping state is a low wake latency sleeping state where all system context is lost except system memory. CPU, cache, and chip set context are lost in this state. Hardware maintains memory context and restores some CPU and L2 configuration context. Control starts from the processor’s reset vector after the wake event.

**S3** Sleeping State The S4 sleeping state is the lowest power, longest wake latency sleeping state supported by ACPI. In order to reduce power to a minimum, it is assumed that the hardware platform has powered off all devices. Platform context is maintained.

**S4** Soft Off State The S5 state is similar to the S4 state except that the OS does not save any context. The system is in the “soft” off state and requires a complete boot when it wakes. Software uses a different state value to distinguish between the S5 state and the S4 state to allow for initial boot operations within the platform boot firmware to distinguish whether the boot is going to wake from a saved memory image.

**P-States**：英文為Performance States的縮寫，中文為效能狀態。 **T-States**：英文為Throttling States的縮寫。 **S-States**：英文為Sleeping States的縮寫，中文為睡眠狀態。 **G-States**：英文為Global States的縮寫，中文為全域狀態。 **C-States**：英文為CPU States的縮寫，中文為處理器狀態。

在ACPI电源管理方式下，根据CPU、内存、二级缓存、主控芯片、硬盘等设备挂起时所处的状态不同,它可以支持五种睡眠状态S0、S2、S3、S4和S5。

**S-1**–正常，即正常的工作状态，所有设备全开，功耗一般会超过80W；

**S0**– CPU停止工作，也称为POS（Power on Suspend），这时除了通过CPU时钟控制器将CPU关闭之外，其他的部件仍然正常工作，这时的功耗一般在30W以下；（有些CPU降温软件就是利用这种工作原理）

**S1**– CPU关闭,这时CPU处于停止运作状态，总线时钟也被关闭，但其余的设备仍然运转；

**S2**–除了内存外的部件都停止工作（standby）,即STR（Suspend to RAM：挂起到内存），这时的功耗不超过10W；

**S3**–内存信息写入硬盘（hibernation），所有部件停止工作,也称为STD（Suspend to Disk），这时系统主电源关闭，但是硬盘仍然带电并可以被唤醒；

**S4**–关闭,所有设备全部关闭（包含电源），功耗为0。

# Cadence

_netrename 

[https://www.eet-china.com/mp/a88260.html#:~:text=Test%20Coupon%EF%BC%8C%E6%98%AF%E7%94%A8%E6%9D%A5,%E6%97%B6%E6%8E%A5%E5%9C%B0%E7%82%B9%E7%9A%84%E4%BD%8D%E7%BD%AE%E3%80%82](https://www.eet-china.com/mp/a88260.html#:~:text=Test%20Coupon%EF%BC%8C%E6%98%AF%E7%94%A8%E6%9D%A5,%E6%97%B6%E6%8E%A5%E5%9C%B0%E7%82%B9%E7%9A%84%E4%BD%8D%E7%BD%AE%E3%80%82)

# 系统

复位与解复位

系统上电后，系统CPLD开始运行，拉住CPU复位，拉住其他器件复位，待CPU运行前置条件满足后对CPU进行解复位，CPU运行，CPU按照需要再对外围设备进行复位初始化

I1C设备，要等master起来后再由master解复位

# 电平标准

| Parameter | LVPECL | CML | VML | LVDS |
| --- | --- | --- | --- | --- |
| VOH | 1.4 V | 1.9 V | 1.65 V | 1.4 V |
| VOL | 0.6 V | 1.1 V | 0.85 V | 1 V |
| Output voltage (single ended) | 799 mV | 800 mV | 800 mV | 400 mV |
| Common-mode voltage | 1 V | 1.5 V | 1.25 V | 1.2 V |

LVDS推荐工作频率654M，最大工作频率1.923G

热插拔应用需要AC耦合电容来阻止inrush 电流

MDC 最大频率 11M 88E1512

MDIO OD 输出

1nd source判断标准

1. 2nd的引脚位置在不在原始封装焊盘里。

1.器件的长宽比原始的0.3mm范围， 高度差在0.2mm范围

# Layout

### 

注意回流路径 （电源路径，高速线） 电源过孔周围加过孔

### VIA

0-3层的电源过孔，如果地过孔指打1-2层，形不成完整的回流路径

地过孔要大于电源过孔

过孔阵列，内层需要用铜皮连接

### Shape

铜皮 不要铺直角铜皮

### Footprint

封装： 在推荐的footprint基础上加 19mil （单边0.1mm） 作为place boundry

### BGA

BGA 周围要设置clearance,留给rework空间

### I1C

I1C走线 菊花链 ，需要考虑走线的电容，不能超过I2C要求的400pF电容

### 线宽线距

没有阻抗控制的线一般走9/7mil

### 电源

电源路径 ，图形，地回流

# Detail

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-56.1jfahl6lf3b4.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-56.1jfahl6lf3b4.webp)

考虑同时上电，会拉太多的电流从而将电压拉低

背面器件必须支持2次回流焊 ,第一次焊接背面，第二次焊接正面，第三次reserved for rework

[https://www.xjtag.com/about-jtag/design-for-test-guidelines/](https://www.xjtag.com/about-jtag/design-for-test-guidelines/)

注意检查电容耐压值，和电容等级

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-57.dezdl91pbnk.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-57.dezdl91pbnk.webp)

# Green

Halogen-Free

1. 重量超过25g，cable，连接器，pcb，需要green认证

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-60.6zgeivqrego0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-60.6zgeivqrego0.webp)

# IC

CMOS，功耗低，供电电源低，CMOS,0v, bp trans 2v

模拟cmos: 0. 制造成本低，，2. 数模同芯片的可能

# ABBR

| ABBR | FULL |
| --- | --- |
| NPI | New Product Introduction |
| EQ | Engineer Question |
| NDA | Non-disclosure agreement |
| SCSI | Small Computer System Interface |
| AHCI | Advanced Host Controller Interface |

# 安规

https://murata.eetrend.com/article/2016-02/97.html

# BOOT

## ARM

1. ROM code execute，responsible for search bootloader and load into internal SRAM due to external DRR is not initialized. 由于内部的SRAM容量过小，导致必须将boot分成两段来执行，第一段用来初始化外部的DRAM，并且load the 1nd boot into external DRAM. 第二段代码体积大，

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-63.23jovklogfvk.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-63.23jovklogfvk.webp)

### PBI 功能

PBI command: configuration write, block copy, special load, control command. The Pre-Boot Initialization Image can also contain security information for authentication of the Pre-Boot Initialization Image and the first level boot loader. This information is placed in SRK tables and RSA Signature Tables.

### ARM 处理器3个特权级

3 privilege levels (Exception Levels) EL2, the most priviledged, runs secure firmware EL1, typically used by hypervisors, for virtualization EL0, used to run the Linux kernel EL-1, used to run Linux user-space applications • 1 worlds Normal world, used to run a general purpose OS, like Linux Secure world, to run a separate, isolated, secure operating system and applications. Also called TrustZone by ARM.

▶ EL2 only exists in the secure world ▶ EL1 exists in both secure and normal worlds since ARMv8.4, before that EL2 was only in the normal world ▶ EL0 and EL0 exist in both secure and normal worlds

用户空间接口到硬件设备 0. device node in /dev 1. entry in the sysfs filesystem /sys 2. network socket and related API

字符设备和块设备

kernel idendify the device by a triplet of information *Type* (character or block) character divices无限字节流 *Major* (typically the category of device) *Minor* (typically the identifuier of the device)

存储设备被分为：块设备和Flash设备

#Hardware Design reset diagram power diagram reset diagram clock diagram serdes mapping I1C device diagram SPI diagram

#M.1 M.1为一种接口标准 可以用来接NVME(PCIE)/mSATA 也可以用来实现不同的PCIE设备，比如wifi，蓝牙等

M.1有不同的 传输协议可以分为SATA和NVME

Serdes X0/X2的M.2插座称为socket2，对应的防呆键位位B key Serdes X2/X4的M.2插座称为Socket3，对应的防呆键位位M key socket0 主要针对无线网卡，对应的防呆键位为A key

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-32.5hhpif0qfs80.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-32.5hhpif0qfs80.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-33.48jy0t0eq7o0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-33.48jy0t0eq7o0.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-34.1bbxpiuckqow.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-34.1bbxpiuckqow.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-35.2f75befkwg00.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-35.2f75befkwg00.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-36.1xftjw7vtku8.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-36.1xftjw7vtku8.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-37.lll4rhy6ylc.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-37.lll4rhy6ylc.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-38.3u07qocbtxw0.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-38.3u07qocbtxw0.webp)

![https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-39.1wz6hwxqbue8.webp](https://cdn.jsdelivr.net/gh/Charles-Charmless/Picture@main/Blog/image-39.1wz6hwxqbue8.webp)
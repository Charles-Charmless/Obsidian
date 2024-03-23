寻址方式

数据处理指令操作数寻址

立即数寻址

内存访问指令寻址

字及无符号自己的Load/Store指令的寻址方式

杂类 Load/Store 指令的寻址方式

批量 Load/Store 指令的寻址方式

协处理器 Load/Store 指令的寻址方式

数据传送指令

MOV指令

单寄存器的Load/Store 指令

多寄存器的Load/Store 指令

数据传送指令应用

单寄存器交换指令(single register swap)

字交换指令SWP

字节交换指令SWPB

程序状态寄存器指令

MRS指令

MSR指令

数据处理指令

乘法指令

跳转指令

协处理器和其他指令

Thumb指令集

  

  

# 寻址方式

## 数据处理指令操作数寻址

ARM处理器一个显著特征就是可以在操作数进入ALU之前对操作数进行制定位数的左移和右移操作

基本语法格式： <opcode> {<cond>} {S} <Rd>,<Rn>,<shifter_operand>

- <opcode>:确定具体指令
- S:标识指令是否影响程序状态寄存器CPSR条件标志
- Rd：指令操作的目的寄存器
- Rn：指令第一源操作数
- bit[11:0]: 移位操作
- bir[25]: 被用来区分是立即数移位操作还是寄存器移位操作

  

#### <shifter_operand>寻址方式

|Name|Tags|
|---|---|
|[[immediate]]|立即数寻址|
|[[Rm]]|寄存器寻址|
|[[Rm,LSL shift_imm]]|立即数逻辑左移|
|[[Rm,LSL Rs]]|寄存器逻辑左移|
|[[Rm,LSR shift_imm]]|立即数逻辑右移|
|[[Rm,LSR Rs]]|寄存器逻辑右移|
|[[Rm,ASR shift_imm]]|立即数算数右移|
|[[Rm,ASR Rs]]|寄存器算数右移|
|[[Rm,ROR shift_imm]]|立即数循环右移|
|[[Rm,ROR Rs]]|寄存器玄幻右移,<Rs>：包含逻辑右移位数的寄存器|
|[[Rm,RRX]]|寄存器扩展循环右移|

  
  

### 立即数寻址

有效性；只有那些通过将一个8bit的立即数循环右移偶数位可以得到的立即数才可以在指令中使用

arm汇编器按照下方的规则来生成立即数的编码：

- 当立即数数值在0-0xFF范围时，令immed_8=<immediate>,immed_4=0;
- 其他情况下，汇编器使用immed_4数值最小的编码方式

## 内存访问指令寻址

根据内存访问指令的分类，内存访问指令的寻址方式可以分为：

1. 字及无符号自己的Load/Store指令的寻址方式
2. 杂类 Load/Store 指令的寻址方式
3. 批量 Load/Store 指令的寻址方式
4. 协处理器 Load/Store 指令的寻址方式

  

### 字及无符号自己的Load/Store指令的寻址方式

- 指令语法结构： LDR|STR{<cond>}{B}{T} <Rd>,<addressing_mode>
    
    #### <addressing_mode>寻址方式
    
    |格式|Tags|描述|
    |---|---|---|
    |[[Rn, +- offset_12]]|立即数偏移寻址|内存访问地址为基址寄存器Rn的值加减立即数offset_12|
    |[[Rn,+-Rm]]|寄存器偏移寻址|内存访问地址为基址寄存器Rn的值加减偏移寄存器Rm的值|
    |[[Rn,Rm,shift offset_12]]|带移位的寄存器偏移寻址||
    |[[Rn,+-offset_12!]]|立即数前牵引寻址|同上，但是在操作成功后将访问的内存地址写入到基址寄存器Rn中|
    |[[Rn,+-Rm!]]|寄存器前牵引寻址||
    |[[Rn,Rm, shiftoffset_12!]]|带移位寄存器前牵引寻址||
    |[[Rn,+-offset_12]]|立即数后牵引寻址|使用基址寄存器Rn的值作为实际内存访问地址，当指令的执行条件满足后，将基址寄存器的值嘉奖偏移量产生新的地址写到Rn中|
    |[[Rn,+-Rm 2]]|寄存器后牵引寻址||
    |[[Rn,+-Rm,shiftoffset_12]]|带移位的寄存器后牵引寻址||
    
      
      
    

<shift>: 表示移位操作

```ABAP
LDR|STR{<cond>}{B}{T} <Rd>,<addressing_mode>  = 
LDR|STR{<cond>}{B}{T} <Rd>,[<Rn>,+-<Rm>,LSL/LSR/ASR/ROR #<offset_12>]   =   
LDR|STR{<cond>}{B}{T} <Rd>,[<Rn>,+-<Rm>,RRX]
```

<cond> ：指令编码的条件域，指示指令在什么条件下执行，当<cond>忽略时，指令为无条件执行(cond=AL（always）)

### 杂类 Load/Store 指令的寻址方式

语法格式：

- LDR|STR{<cond>}H|SH|SB|D <Rd>,<addressing_mode>
- 分别表示（有符号/无符号）半字Load/Stroe 指令，有符号字节Load/Store指令和双字Load/store指令

#### <addressing_mode>寻址方式

|格式|模式|
|---|---|
|[[Rn,+-offseet_8 2]]|立即数偏移寻址|
|[[Rn,+-Rm 3]]|寄存器偏移寻址|
|[[Rn,+-offset_8!]]|立即数前牵引寻址|
|[[Rn,+-Rm! 2]]|寄存器前牵引寻址|
|[[Rn,+-offseet_8]]|立即数后牵引寻址|
|[[Rn,+-Rm 4]]|寄存器后牵引寻址|

  
  

  

### 批量 Load/Store 指令的寻址方式

![[0C9EA8EB-785D-411D-A01A-B7A1B78377B9.jpeg]]

替代上图中的<addressing_mode>

  

  

- Rn为基址寄存器，包含内存访问的基地址
- <register>为指令操作的寄存器列表
- <^>表示如果寄存器列表中包含程序计数器PC，是否将spsr拷贝到cpsr

  

  

  

### 协处理器 Load/Store 指令的寻址方式

语法格式： <opcode>{<cond>}{L} <coproc>,<CRd>,<addressing_mode>

#### <addressing_mode>寻址模式

|格式|说明|
|---|---|
|[[Rn,+-offset_84 2]]|立即数偏移寻址|
|[[Rn,+-offset_84!]]|前牵引立即数偏移寻址|
|[[Rn,+-offset_84]]|后牵引立即数偏移寻址|
|[[Rn,option]]|直接寻址|

  
  

<offset_8>: 8位的立即数，该值的4倍为地址偏移量

  

# 数据传送指令

## MOV指令

|指令|描述|Files|
|---|---|---|
|[[MOV{cond}{S} Rd,shifter_operand]]|||
|[[MVN{cond}{S} Rd,shifter_operand]]|||
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/Untitled Database/Untitled|Untitled]]|||

  
  

  

![[3EA85069-F185-41F5-8A97-96B990F0204C.jpeg]]

## 单寄存器的Load/Store 指令

  

#### 单寄存器的Load/Store 指令

|指令|描述|语法格式|关键点|
|---|---|---|---|
|[[LDR]]|把一个字装入寄存器中|LDR{<cond>} <Rd>,<addr_mode>||
|[[STR]]|将存储器中的字保存到寄存器中|STR{<cond>} <Rd>,<addr_mode>||
|[[LDRB]]|把一个字节装入一个寄存器|LDR{<cond>}B <Rd>,<addr_mode>||
|[[STRB]]|把寄存器的低8位字节保存到存储器|STR{<cond>}B <Rd>,<addr_mode>||
|[[LDRH]]|把一个半字装入一个寄存器|LDR{<cond>}H <Rd>,<addr_mode>||
|[[STRH]]|从寄存器取出指定的16位半字节到寄存器的低16位|STR{<cond>}H <Rd>,<addr_mode>||
|[[LDRBT]]|用户模式下将一个字节装入寄存器|LDR{<cond>}BT <Rd>,<post_indexd_addressing_mode>||
|[[STRBT]]|用户模式下将寄存器的低8位字节保存到存储器|STR{<cond>}BT <Rd>,<post_indexd_addressing_mode>||
|[[LDRT]]|用户模式下把一个字装入一个寄存器|LDR{<cond>}T <Rd>,<post_indexd_addressing_mode>||
|[[STRT]]|用户模式下将存储器中的字保存到寄存器|STR{<cond>}T <Rd>,<post_indexd_addressing_mode>||
|[[LDRSB]]|把一个有符号字节专题图一个寄存器|LDR{<cond>}SB <Rd>,<addr_mode>||
|[[LDRSH]]|把一个有符号半字节装入一个寄存器|LDR{<cond>}SH <Rd>,<addr_mode>||
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/单寄存器的Load Store 指令/Untitled|Untitled]]||||

  
  

<addr_mode>:确定了指令编码中的I，P，U，W，和<addr_mode>位

<post_indexd_addressing_mode>: 使用后牵引地址模式寻址

  

## 多寄存器的Load/Store 指令

  

  

#### 多寄存器内存字段数据传送指令

|指令|描述|指令系统|
|---|---|---|
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/多寄存器内存字段数据传送指令/LDM|LDM]]|装载多个寄存器|LDM{<cond>}<addressing_mode> <Rn>{!},<registers>|
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/多寄存器内存字段数据传送指令/STM|STM]]|保存多个寄存器|STM{<cond>}<addressing_mode> <Rn>{!},<registers>|

  
  

<address_mode>:指令的寻址方式，确定编码格式中的P，U和W位

！： 设置指令编码中的W位，它使指令执行后将操作数的内存地址写入基址寄存器<Rn>中

<registers>：被加载的寄存器列表，不同的寄存器之间用","隔开，完整的寄存器列表包含在"{}"中，编号低的寄存器对应于内存中的低地址单元，编号高的寄存器对应于内存中的高地址单元

  

#### 用户模式多寄存器内存字段数据传送指令

|指令|描述|指令系统|
|---|---|---|
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/多寄存器内存字段数据传送指令/LDM]]|装载多个寄存器|LDM{<cond>}<addressing_mode> <Rn>{!},<registers_without_pc>|
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/多寄存器内存字段数据传送指令/STM]]|保存多个寄存器|STM{<cond>}<addressing_mode> <Rn>{!},<registers>^|

  
  

<registers_without_pc>：被加载的寄存器列表，此列表中不能包含PC寄存器

<registers>^： 寄存器列表，只能使用用户模式下的寄存器

  

#### 带状态寄存器的多寄存器内存字段数据传送指令

|指令|描述|指令系统|
|---|---|---|
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/带状态寄存器的多寄存器内存字段数据传送指令/LDM|LDM]]|装载多个寄存器|LDM{<cond>}<addressing_mode> <Rn>{!},<registers_without_pc>|

  
  

- 貌似没什么区别？

  

### 数据传送指令应用

LDM{<cond>}<模式> <Rn>{!},<registers_without_pc>

STM{<cond>}<模式> <Rn>{!},<registers_without_pc>

<模式>

- IA:每次传送后地址加4
- IB:每次传送前地址加4
- DA:每次传送后地址减4
- DB:每次传送前地址减4
- FD:满递减堆栈
- ED:空递增堆栈
- FA:满递增堆栈
- EA:空递增堆栈

  

## 单寄存器交换指令(single register swap)

### 字交换指令SWP

用于将内存中的一个字单元和一个指定寄存器的值交换

语法格式： SWP{<cond>} <Rd>,<Rm>,[<Rn>]

<Rm>:包含要存储到内存中的数据

<Rn>:包含要访问的内存地址

描述: 假设内存单元地址存放在寄存器<Rn>中，指令将<Rn>中的数据读取到目的寄存器Rd中，同时将另一个寄存器<Rm>中的内容写到该内存单元中，，当<Rd>和<Rm>位同一个寄存器时，指令交换Rd和Rn的值

  

### 字节交换指令SWPB

SWP{<cond>}B <Rd>,<Rm>,[<Rn>]

B为可选项，若有B，则交换字节，否则交换32位字

## 程序状态寄存器指令

### MRS指令

把程序状态寄存器的值送到一个通用寄存器

指令：

- MRS{<cond>} <Rd>,CPSR
- MRS{<cond>} <Rd>,SPSR

### MSR指令

把通用寄存器的值或者是一个立即数传送到程序状态寄存器

指令：

- MSR{<cond>} CPSR_<fields>,#<immediate>
- MSR{<cond>} CPSR_<fields>,<Rm>
- MSR{<cond>} SPSR_<fields>,#<immediate>
- MSR{<cond>} SPSR_<fields>,<Rm>

<fields>:设置状态寄存器所需要的位，状态寄存器的32位可以分成4个8位的域

- bits[31:24]为条件标志位域，用f表示
- bits[23:16]为状态位域，用s表示
- bits[15:8]为扩展位域，用x表示
- bits[7:0]为控制位域，用c表示

# 数据处理指令

#### 数据处理指令列表

|操作码|助记符|操作|操作 1|
|---|---|---|---|
|[[0000]]|AND|逻辑加|Rd:Rn and op2|
|[[0001]]|EOR|逻辑异或|Rd: Rn EOR op2|
|[[0010]]|SUB|减|Rd: Rn-op2|
|[[0011]]|RSB|翻转减|Rd: op2-Rn|
|[[0100]]|ADD|加|Rd: Rn+op2|
|[[0101]]|ADC|带进位的加|Rd: Rn+op2+C|
|[[0110]]|SBC|带进位的减|Rd: Rn-op2+C-1|
|[[0111]]|RSC|带进位的翻转减|Rd: op2-Rn+C-1|
|[[1000]]|TST|测试|Rn AND op2并更新标志位|
|[[1001]]|TEQ|测试相等|Rn EOR op2并更新标志位|
|[[1010]]|CMP|比较|Rn - op2并更新标志位|
|[[1011]]|CMN|负数比较|Rn + op2并更新标志位|
|[[1100]]|ORR|逻辑或|Rd: Rn OR op2|
|[[1110]]|BIC|位清0|Rd: Rn AND NOT(op2)|

  
  

操作指令：

```Arduino
<opcode2>{<cond>} <Rn>,<shifter_operands>
<opcode2>:=CMP|CMN|TST|TEQ
<opcode3>{<cond>}{S} <Rd>,<Rn>,<shifter_operand>
<opcode3>:=ADD|SUB|RSB|ADC|SBC|RSC|AND|BIC|EOR|ORR
```

Arm数据处理指令使用3地址格式，这意味着分别指定两个源操作数和一个目的寄存器，第一个源操作数总是目的寄存器，第二个源操作数又叫做移位操作数，它可能是寄存器，移位后的寄存器或者立即数，

  

  

  

  

# 乘法指令

#### 乘法指令

|操作码|助记符|意义|语法格式|操作|
|---|---|---|---|---|
|[[000]]|MUL|乘(保留32位结果)|MUL{<cond>}{S} <Rd>,<Rm>,<Rs>|Rd: (Rm*Rs)[31:0]|
|[[001]]|MLA|乘-累加（32位结果）|MLA{<cond>}{S} <Rd>,<Rm>,<Rs>,<Rn>|Rd: (Rm*Rs+Rn)[31:0]|
|[[100]]|UMULL|无符号长乘|UMULL{<cond>}{S} <RdLo>,<RdHi>,<Rm>,<Rs>|RdHi: RdLo=Rm*Rs|
|[[101]]|UMALL|无符号长乘-累加|UMALL{<cond>}{S} <RdLo>,<RdHi>,<Rm>,<Rs>|RdHi: RdLo+=Rm*Rs|
|[[110]]|SMULL|有符号数长乘|SMULL{<cond>}{S} <RdLo>,<RdHi>,<Rm>,<Rs>|RdHi: RdLo: Rm*Rs|
|[[111]]|SMLAL|有符号数长乘-累加|SMLAL{<cond>}{S} <RdLo>,<RdHi>,<Rm>,<Rs>|RdHi: RdLo+=Rm*Rs|
|[[Wiki/Arm linux修炼之路/C语言+汇编/ARM汇编/乘法指令/Untitled|Untitled]]|||||

  
  

  

  

# 跳转指令

  

  

# 协处理器和其他指令

  

  

  

  

# Thumb指令集
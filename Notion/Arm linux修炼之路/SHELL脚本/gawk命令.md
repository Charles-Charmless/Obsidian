[Share](https://www.notion.sojavascript:void(0);)

# gawk基础

gawk提供一个类编程环境，允许修改和重新组织文件中的数据  
gawk编程语言的功能：  

- 定义变量来保存数据
- 使用算术和字符串操作符来处理数据
- 使用结构化编程概念，比如if-then语句和for循环，来为数据处理添加逻辑
- 提取数据文件中的数据元素并把他们按另一种顺序或格式重新放置，从而生成格式化报告

_gawk以行位单位对数据进行处理_

**gawk程序的基本格式：** `gawk options program file`  
gawk选项|解析  
:-|:-  
-F fs|　指定行中分隔数据字段的字段分隔符（默认的字段分隔符是任意空白符）  
-f file|　指定读取程序的文件名  
-v var==value|　定义gawk程序中一个变量及其默认值  
-mf N|　指定要处理的数据文件中的最大字段数  
-mr n|　指定数据文件中的最大数据行数  
-W keyword|　指定gawk的兼容模式或警告等级  

- gawk程序脚本用一对花括号来定义，必须要把脚本命令放到两个括号之间，并且gawk指定脚本位单个文本字符串，所以需要把脚本放到单引号中
- ctrl+d产生EOF字符，该字符终止gawk命令，并返回命令行界面提示符

**gawk变量与字段的匹配：**  
变量|解析  
:-|:-  
$0|$0代表整个文本  
$1|$1代表文本行中的第1个数据字段  
$2|$2代表文本行中的第2个数据字段  
$3|$N代表文本行中的第N个数据字段  

- gawk编程语言允许将多条命令组合成一个正常的程序，只需要在每条命令之间方放一个分号即可
- gawk编辑器允许将程序存储到文件中，然后在命令行中调用
- gawk程序中可以指定多条命令，不需要用分号隔开，只用将每条命令放到一个新行即可

|关键字|解析|
|---|---|
|[[BEGIN]]|强制gawk在读取数据前执行BEGIN关键字后指定的程序脚本|
|[[END]]|指定gawk在读完数据之后执行关键字之后的的脚本|

  
  

# gawk进阶

## 使用变量

### 内建变量： {#内建变量：}

|内建变量|解析|
|---|---|
|[[FIELDWIDTHS]]|由空格分隔开的定义了每个数据字段确切宽度的一列数字|
|[[FS]]|输入字段分隔符|
|[[RS]]|输入数据行分隔符|
|[[OFS]]|输出字段分隔符|
|[[ORS]]|输出数据行分隔符|
|[[ARGC]]|当前命令行参数个数|
|[[ARGIND]]|当前文件在ARGV的位置|
|[[ARGV]]|当汉命令行参数的数组|
|[[CONVFMT]]|数字转换格式，|
|[[ENVIRON]]|当前shell变量及其值组成的关联数组|
|[[ERRNO]]|当读取或关闭输入文件发生错误时的系统错误号|
|[[FILENAME]]|由做gawk输入数据的数据文件的文件名|
|[[FNR]]|当前数据文件的数据行数|
|[[IGNOORECASE]]|设置为非0时，忽略gawk命令中出现的字符串的大小写|
|[[NF]]|数据文件中的字段总数|
|[[NR]]|已处理的输入数据行数目|
|[[OFMT]]|数字的输出模式|
|[[RLENGTH]]|由match函数所匹配的子字符串的长度|
|[[RSTART]]|由match函数所匹配的子字符串的起始位置|

  
  

### 自定义变量

可以i为文本和数值型，也可以做数值计算，变量既可以在脚本中被赋值也可以在命令行中被赋值

### 处理数组

1. 定义数组变量：　`var[index] = element`
    - var是变量名
    - index是关联数组的索引值
    - element是数据元素值
    - 在引用数组变量时，必须包含索引值来提取相应的元素值
2. 遍历数组变量
    
    |Column 1|Column 2|
    |---|---|
    |1234|[[for (var in array)　　　　　　　　　{ statements}]]|
    
      
      
    

这个for语句会在每次将关联数组array的下一个索引值变量var　注意这个变量是索引值而不是数组元素值　索引值不会按照任何特定的顺序返回

1. 删除数组元素　`delete array[index]`　
    - 删除命令会从数组中删除关联索引值和相关的数据元素值

## 使用模式

1.正则表达式：BRE+ERE(基本加扩展),使用正则表达式时，正则表达式必须出现在它要控制的程序脚本的左花括号前面

1. 匹配操作符：允许将正则表达式限定在数据行中的特定数据字段，匹配操作符式～
2. 数学表达式：可以在匹配模式中使用数学表达式

## 使用结构化命令

### if语句： {\#if语句：}

|Column 1|Column 2|
|---|---|
|123|[[if (condition) { statement1}]]|

  
  

`if (condition) statement1if (condition) {statement1};else {statement2}`

### while语句： {\#while语句：}

|Column 1|Column 2|
|---|---|
|1234|[[while(condition){ statements}]]|

  
  

- 支持break和continue语句
    
    ### do-while语句： {\#do-while语句：}
    
    |Column 1|Column 2|
    |---|---|
    |1234|[[do{statements}while(condition)]]|
    
      
      
    

### for语句： {\#for语句：}

|Column 1|Column 2|
|---|---|
|1234|[[for(variable assignment；conditio n；iteration process){ statements}]]|

  
  

---

### 格式化打印 ###

`printf "format string",var1,var2`(类似C语言)

_格式化指定字符格式：_　 %[modifier]control-letter

- control-letter指明显示什么类型数据值的单字符码，而modifier定义了另一个可选的格式化特性

|控制字母|描述|
|---|---|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/c\|c]]|将一个数作为ASCII字符显示|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/d\|d]]|显示一个整数值|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/i\|i]]|显示一个整数值|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/e\|e]]|用科学记数法显示一个数|
|[[f]]|显示一个浮点数|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/g\|g]]|用科学记数法或浮点数中较短的显示|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/o\|o]]|显示一个八进制数|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/s\|s]]|显示一个文本字符串|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/x\|x]]|显示一个十六进制数|
|[[X]]|显示一个十六进制数，单用大写字母A-Z|

  
  

|另外三种修饰符|作用|
|---|---|
|[[width]]|指定输出字段的最小宽度的数字值，如果输出短于这个值，printf会右对齐，如果输出字段过长，会覆盖width值|
|[[prec]]|指定了符点数中小数点后面位数的数字值，或者用文本字符串中显示的最大字符数|

  
  

- `指明在向格式化写入空间放入数据时会采用左对齐而不是右对齐的方式`

## 操作函数

### 内建函数

### 数学描述

|数学函数|描述|
|---|---|
|[[atan2(x,y)]]|x/y的反正弦，弧度制|
|[[cos(x)]]|x的余弦值|
|[[exp(x)]]|x的值数函数|
|[[int(x)]]|x的整数部分，取靠近0的一侧|
|[[log(x)]]|x的自然对数|
|[[rand(x)]]|0-1之间的随机数|
|[[sin(x)]]|x的正弦值|
|[[sqrt(x)]]|x的平方根|
|[[srand(s)]]|为计算随机数指定一个种子值|

  
  

### 字符串函数

|字符串函数|描述|
|---|---|
|[[asort(s,d) 2]]|将数组s按照数据元素值排序，索引值会被替换成表示新的排序的连续数字，另外，如果指定了d，则排序后的数组会被存储在数组d中|
|[[asort(s,d)]]|如果将数组s按照索引值排序，生成的数组会按照索引值生成数据元素值，用连续的数字索引来表示排序顺序，另外，如果指定了d，排序后的数组会存储在d中|
|[[gensub(r,s,h,t)]]|查找变量$0或目标字符串t来匹配正则表达时r，如果h也是一个以g或者G开头的字符串，就用s替换到匹配的文本，如果h是一个数字，他表示要替换掉第几个r匹配的地方|
|[[gsub(r,s,t)]]|查找变量$0或目标字符串t来匹配正则表达式r，如果找到了，就全部替换成字符串s|
|[[index(s,t)]]|返回字符串t在字符串s中的索引值，如果没有，则返回0|
|[[length(s)]]|返回字符串s的长度，如果没有指定的话，返回$0的长度|
|[[match(s,r,a)]]|返回字符串s中正则表达式r出现的位置的索引，如果指定了数组a，他会存储在s中匹配正则表达式的那部分|
|[[split(s,a,r)]]|将s用FS字符或正则表达式分开放到数组a中，返回字段的总数|
|[[sprintf(format,variables)]]|用提供的format和variable返回一个类似于printf式出的字符|
|[[sub(r,s,t)]]|在变量$0或目标字符t中查找正则表达式r的匹配，如果找到了，就用字符串s替换到第一处匹配|
|[[substr(s,i,n)]]|返回s中从索引值i开始的n个字符组成的子字符串，如果未提供p，则返回s剩下部分|
|[[tolower(s)]]|将s中的所有字符转换成小写|
|[[toupper(s)]]|将s中的所有字符转换成大写|
|[[时间函数 2]]||
|[[时间函数]]|时间戳（自1970-01-01 00：00：00到现在，以秒为单位，通常称为epoch time）|
|[[Arm linux修炼之路/SHELL脚本/gawk命令/Untitled Database/--\|--]]|:-|
|[[mktime(datespec)]]|将一个按照YYYY MM DDMHH MM SS [DST]格式指定的日期转换为时间戳|
|[[strftime(format,timestamp)]]|将当前时间的时间戳或timestamp转化为用shell函数格式date（）的格式化时间|
|[[systime()]]|返回当前时间的时间戳|

  
  

### 自定义函数

**定义函数：**

function name([variables]){ statements }

- 可以有return函数

1. 使用自定义函数： 定义函数时必须出现在其他所有代码之前，包括BEGIN代码块
2. 创建函数库： 将所有的函数写在同一个文件内（函数库）　通过gawk -f参数调用即可 （同时指定库文件和程序文件）
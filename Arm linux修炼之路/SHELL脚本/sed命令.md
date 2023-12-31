# sed 基础

sed编辑器（stream editor） 区别于交互式文本编辑器，流编辑器会在编辑器处理数据之前基于预先提供的一组规则来编辑数据流

sed编辑器按照行来处理数据　sed编辑器自身不不会修改文本文件的数据，只会将修改后的数据发送到STDOUT。

---

## sed命令的格式

`sed options script file`

```Plain
script参数指定了将作用在数据流上的单个命令，如果需要多个命令，必须使用-e选型来在命令行上指定他们，或者-f选项在单独的文件中指定（命令之间只能用分号；来隔开，并且在命令末尾和分号之间不能有空格），要在封尾单引号所在行结束命令
```

---

### sed 命令选项

|选项|解析|
|---|---|
|[[-e script]]|在处理输入时，将script中的指定的命令添加到运行的命令行中|
|[[-f file]]|在处理输入时，将file中指定的命令添加到运行的命令中(从文件中读取编辑器命令)|
|[[-n]]|不要为每个命令生成输出，等待print命令来输出|
|[[___]]||
|[[功能]]||

  
  

**替换（substitute）**:　`s/pattern/replacement/flags`　_可用的flags_:

1. 数字（表示新文本将替换第几处模式匹配的地方）
2. g（新文本将会替换所有已有文本出现的地方）
3. p（将原来行的内容打印出来）
4. w file(将替换的结果写到文件中)
5. -n 该选项禁止原来文本的输出

- 如果在要替换的文本中出现正斜线，需要做转义处理
- gawk也可以用其他字符来作为substitute命令的字符串分隔符，例如s!pattern!replacement!flags

**地址**　  
sed有两种形式的行选址  

- 行的数字范围  
    数字范围过滤格式　[address]command　([]不存在，只做标识作用)  
    
    ```Plain
    或者　　address{commands}
    ```
    
    sed编辑器会将指定的每条命令只作用到匹配指定地址的行上
    
    行的类型：
    
    - 单个行号
    - 用起始行号，逗号
    - 以及结尾行号来指定的一定范围内的行
- 用文本形式来过滤出某行　  
    文本范围过滤格式： /pattern/command 通过正则表达式的匹配来过滤范围  
    

**删除（delete）行**  
命令：  
`d`

- 会删除匹配指定寻址模式的所有行，如果忘记寻址模式会删除所有的行
- 也可以删除两个文本模式之间的行，第一个模式用于打开删除模式，另一个模式用来关闭删除模式, 例：sed ‘/1/,/3/d’ file　删除文件的1-3行

**插入（insert）和附加（append）文本**  
命令:　  
`i(insert)`　和　`a(append)`　  
格式：sed ‘[address]command new line’　new line行会出现在sed编辑器输出中指定的位置（不能使用地址区间）  

**修改（change）行**　会用新的行来取代地址范围内的行

**转换（translate）命令**  
命令：  
`y`　  
格式：　  
`[address]y/inchars/outchars`　 inchar和outchar长度必须相同，会用outchar中的字符来替代inchar中的字符

**回顾打印**　

1. 小写p命令用来打印文本行
2. 等号（=）命令用来打印行号
3. l命令用来列出行

**文件操作**　  
格式：　  
`[address]w filename`(写操作)　`[address]r filename`(读操作)

# sed进阶

## 多行命令

**sed编辑器的特殊命令**

1. N:将数据流的下一行加进来创建一个多行组来处理
2. D:删除多行组的一行
3. P:打印多行组的一行 命令 详细描述 ——————- ————————————————————————————————————————– 单行next命令（n） 会在匹配到模式之后将该行文本的下一行替换到编辑区间 多行next命令（N） 会在匹配模式之后将该行文本的下一行添加到编辑区（将两行连续的文本当作一行来处理） 多行删除命令D 他只删除模式空间的第一行直到换行符为止。 单行删除命令d配合多行next命令会删除多行　D命令会强制sed编辑器回到脚本的起始处 多行输出命令P 同样只打印多行模式空间的第一行，包括模式空间中直到换行符的所有字符。

## 保持空间 ##

1. **区别模式空间与保持空间**
2. **保持空间命令** 命令 描述 —— ————————– h 将模式空间复制到保持空间 H 将模式空间附加到保持空间 g 将保持空间复制到模式空间 G 将保持空间附加到模式空间 x

## 排除命令

- 感叹号（！）用于排除命令

## 改变流

```Plain
通常sed编辑器会从脚本的顶端开始执行命令并一直处理到脚本的结尾
```

**调转（branch）指令**_格式_ : `[address]b [label]`　 address参数决定了哪行或哪些行的数据会触发调转命令 label参数定义了要跳转的位置，如果没有label参数，跳转指令会跳转到脚本的结尾（在脚本内跳转）**测试命令**_描述*： 类似跳转命令，test命令t也用来改变sed编辑脚本的流，测试命令基于替换命令，的输出跳转到另一个标签，而不是基于地址跳转到一个标签  
*格式  
_`[address]t [label]` 如果替换命令成功匹配并替换了一个模式，测试命令就会跳转到指定的标签

## 模式替代

**and符号** and符号（&）用来代表替换命令中的匹配模式，不管匹配模式是什么，都能用and符号在替代模式中调用他**替换单独的单词**　sed编辑器用圆括号来定义替换模式的子字符串，然后用替代模式中的特殊字符来引用每个子字符串。

- 替代字符由反斜线和数字组成，数字表明子字符串模块的位置，sed编辑器给第一个模块分配字符\1,第二个子字符\2
- 当在替换命令中使用圆括号时，必须使用转义字符来将他们识别为聚合字符而不是普通字符
    
    ## 在脚本中使用sed
    
- 使用包装脚本
- 重定向sed的输出

## 创建sed实用程序（练习） {#创建sed实用程序（练习）}

- 加倍行距
- 对可能包含空白行的文本加倍行距
- 给文件中的行编号
- 打印末尾行
- 删除连续的空白行
- 删除来头的空白行
- 删除html标签
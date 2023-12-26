[Share](https://www.notion.sojavascript:void(0);)

# 文本菜单

1. 创建菜单布局：
    - 通过echo给予特定的参数来输出制表符之类的格式控制字符，来控制菜单布局的美观
2. 创建菜单函数：
    - 针对每一个菜单创建独立的shell函数，然后，把他们当做独立函数在代码中分布开来　通常会为还没有实现的函数创建一个桩函数（没有任何命令的函数，或者只用echo语句来说明最终那里需要什么函数）　也可以将菜单显示函数当做一个独立函数，这样就可以多次显示菜单。
3. 添加菜单逻辑：
    - 通过case命令根据用户输入的字符选择来调用合适的函数，通常用默认的case命令字符（*）来捕获所有不正确的菜单项
4. 整个shell脚本菜单：
5. 使用select命令：　select命令允许从单个命令行创建菜单，然后提取输入的答案并自动处理 +————————————–+————————————–+ | 1234 |　select variable in list　do | | |　commands　done | +————————————–+————————————–+

+ list参数是构成菜单的空格分割的文本选项列表　+ select 命令会在列表中将每一个选项作为一个编好号的选项显示，然后为选项创建一个特殊的PS3环境变量定义的提示符

---

# 窗口菜单

1. dialog包（该包能在文本环境中用ANSI转义控制字符来创建标准的窗口对话框）(通过 `sudo yum install dialog`安装) 部件类型 描述 例子 ———— ———————————————- —————————————————————— calender 提供选择日期的日历  
    checklist 显示多个选项  
    from 构建一个表单  
    fselect 提供一个文件选择窗口来浏览选择文件 dialog –title “hint” –fselect file heigth width 重定向 gauge 显示完成的百分比进度条  
    infobox 显示一条信息，但不用等待回应  
    inputbox 提供一个输入文本用的文本表单 dialog –inputbox “xxx” heigth width 重定向 inputmenu 提供一个可编辑的菜单  
    menu 显示可选择的一系列选项 dialog –menu “title” height width N(一次显示的菜单项总数) “menu” msgbox 显示一条信息，并要去用户选择ok按钮 dialog –msgbox text height width pause 显示一个进度条来显示特定暂定时间的状态  
    passwdbox 显示一个文本框来输入文本，但会隐藏输入的文本  
    passwdform 显示一个带标签和隐藏文本输入的表单  
    radiolist 提供一个菜单选项，但只能选择其中的一项  
    tailbox 用tail命令在滚动窗口中显示文件的内容  
    tailboxbg 和tailbox一样，但是在后台运行  
    textbox 在滚动窗口中显示文件内容 dialog –textbox file height width timebox 提供一个选择小时，分，秒的窗口  
    yesno 提供一个简单的带yes和no按钮的消息 dialog –title “xxx” –yesno “xxx” heigth width  
    

**指定特定部件**  
要在命令行指定某个特定的部件，需要使用双破折线格式（–）  
`dialog --widget parameter`　

- widget是部件名
- parameter定义了部件窗口的大小以及部件所需要的文本

1. dialog选项 （有时间再补充吧，可以查看帮助手册）（未完）
2. 在脚本中使用dialog命令

★注意事项  
如果有cancel和no选项，检查dialog命令的退出状态码  

- 如果选择了YES或OK按钮，退出状态码为1
- 如果选择了Cancel或No按钮，dialog命令退出状态码为1

**重定向STDERR来获取输出值**

---

# 图形菜单：使用扩展的dialog命令 {#图形菜单：使用扩展的dialog命令}

## KDE环境（kdialog） {\#KDE环境（kdialog）}

|kdialog部件|描述|
|---|---|
|[[–checklist title tag item status]]|多选列表菜单，状态会说明该选项是否被选定|
|[[–error text]]|错误信息框|
|[[–input text tag item]]|输入文本框，可以用init值来指定默认值|
|[[–menu titletag item]]|带有标题的菜单选择框，以及用tag标识的选型列表|
|[[–msgbox text]]|显示指定文本的简单消息框|
|[[–passwdbox text]]|隐藏用户输入的密码输入文本框|
|[[–radiolist titletag item status]]|单选列表菜单，状态会说明该选项是否被选定|
|[[–separate-output]]|为多选列表和单选列表菜单返回按列分开的选项|
|[[–sorry text]]|“sorry”对话框|
|[[–textbox filewidth height]]|显示file的内容的文本框，另外指定了width和heigth|
|[[–title title]]|为对话窗口的titlebar区域指定一个标题|
|[[–warningyesno text]]|带有yes和no的警告消息框|
|[[–warningcontinuecancel text]]|带有yes和no的警告消息框|
|[[–warningyesnocancel text]]|带有yes和no和cancel的警告消息框|
|[[–yesno text]]|带有yes和no的提问框|
|[[–yesnocancel text]]|带有yes和no和cancel的提问框|

  
  

## GNOME环境(zenity)

|zenity部件|描述|
|---|---|
|[[–calender]]|显示整月日历|
|[[–entry]]|显示文本输入对话窗口|
|[[–error]]|显示错误信息对话框|
|[[–file-selection]]|显示完整的文件名和文件名称对话窗口|
|[[–info]]|显示信息对话窗口|
|[[–list]]|显示多选列表或单选列表对话窗口|
|[[–notification]]|显示通知图标|
|[[–progress]]|显示进度条对话窗口|
|[[–question]]|显示yes/no对话框|
|[[–scale]]|显示可调整大小的窗口|
|[[–text-info]]|显示含有文本的文本框|
|[[–warning]]|显示警告对话信息|
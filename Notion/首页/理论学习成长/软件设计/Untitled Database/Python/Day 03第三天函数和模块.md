定义函数

```Python
def funcname(input=x,input=x,):
		return xxx
```

可变参数函数

```Python
def funcname(*args):
		for var in args:
				statement
		return xxx
```

模块

```Python
module1.py 
	def function1():
module2 py
	def function2():


from module1 import function1
from module2 import function2

import module1 as m1
	m1.function1()
import module2 as m2 
	m2.function2()
```

如果在模块文件内除了函数还有其他可执行的文件，那么在导入模块的时候还会执行这些语句，可以通过一下的条件来除了

```Python
if __name=='__main__':
```

变量的作用域

全局作用域，局部变量

用global 关键字来指示函数中的变量来自于全局作用域，如果全局作用域中没有该变量则会定义一个全局变量

使用nonlocal关键字来指示变量来自域嵌套作用域

  

  

python文本代码格式

```Python
def main():
	codeXXXXXXXXXXXXXXXXXXXxx
	pass

if __name__=='__main__':
	main()
```
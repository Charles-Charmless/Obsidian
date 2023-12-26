定义类

```Python
class classname(object):
	def __init__()  ：  初始化函数
```

访问可见性问题

在python中如果希望属性是私有的，那么在给属性命名的时候可以用两个下划线开头

访问器（getter），修改器（setter），包装器（@property）

  

```Python
__slot__变量限定自定义类型的对象只能绑定某些属性，只对当前类的对象生效，对子类不起作用
```

```Python
@staticmethod
定义静态方法
```

```Python
@classmethod定义类方法，第一个参数约定名为cls，代表当前类相关的信息的对象（类本身也是对象，，有的地方成为类的元数据对象）
```

类之间关系: is a,has -a,use-a分别是继承，关联，和依赖关系

继承

```Python
class fatherclass()

class sonclass(fatherclass)
```

多态：通过重写让父类的同一个行为在子类中用于不同的实现版本，从而不同的子类对象会表现出不同的行为
---
title: python学习笔记
date: 2021-01-28 02:28:36
categories: python
tags: language
---

***持续更新中***
参考: [廖雪峰python教程](https://www.liaoxuefeng.com/wiki/1016959663602400)

# Python 基础

## 变量

- 整数(Python可以处理任意大)，浮点数，字符串(`''`或`""`括起来的，`\`转义)，布尔值(`True` or `False`)，空值(`None`).
- 在Python中，等号`=`是赋值语句，可以把任意数据类型赋值给变量，同一个变量可以反复赋值，而且可以是不同类型的变量(动态语言)。
- Python3用Unicode编码，提供`ord()`函数获取字符的整数表示，`chr()`函数把编码转换为对应的字符。
- 把`str`变为以字节为单位的`bytes`型，带`b`前缀的的单引号或双引号表示。`encode()`, `decode()`
- 格式化字符串规则和c语言类似。

<!--more -->

### list列表

- [ ]表示list
- [ ]下标索引，从0开始，负数表示倒数第几个
- list中数据类型可以不同，可以嵌套

```python list
  len(mylist) #获得list元素的个数 
  mylist.append('a') # 往list中追加元素到末尾
  mylist.insert(1, 'a') # 把元素插入到指定位置
  mylist.pop() # 删除list末尾的元素
  mylist.pop(1) # 删除指定位置的元素
  #pop返回值为被删除的元素
  del mylist[1] #使用del可以删除任何位置的列表元素，条件是知道索引
  mylist.remove() #按值删除元素，只删除第一个指定的值
  # `pop和`del`的选择：删除后是否还要使用该元素
  mylist.sort() #永久排序
  mylist.sort(reverse = True) #倒序排序
  sorted(mylist) #暂时排序，也可以加入倒序参数
  mylist.reverse() #永久倒置
  mylist[1:3] #list切片，同MATLAB，首尾可缺省
  copy_list = mylist[:] #通过切片赋值list
  ```

### tuple元组

- `( )`表示元组
- tuple和list非常类似，但是tuple一旦初始化就**不能修改**，类似enum
- 定义一个元素就加个`,`
- `tuple`的不变是**指向不变**，即给元组变量赋值是合法的

## 基本语法

### if-else

- 不要括号，冒号换行，缩进
- `else if`可以缩写`elif`
- `if a in mylist`判断元素是否在列表(很自然语言)

### for

- `for x in ...`按list或tuple迭代
- `range(m,n,step)`函数生成从m开始到n的整数序列，步长为step，`m`缺省为0，`step`缺省为1

### while

- `break`, `continue`正常用

### dict字典

- key-value, 查找速度很快；类似map, hash table
- key必须是**不可变**对象
- `{'key': value, ...}`创建

```python dict
d.get('Thomas',-1) #寻找某个关键字的值，-1是规定的不存在时的返回值，缺省时返回None，Python交互环境不显示结果
d.pop('Bob') #删除一个关键字

for key,value in d.items(): # 使用items()方法可以访问所有条目
    print(key + ":" + value)

for key in d.keys(): # 使用keys()方法可以访问所有的关键字
    print(key.title())
```

### set集合

- 无序，不重复元素，不能放入可变对象

```python set
s = set([1, 1, 2, 3])
s.add(4) #添加元素
s.remove(4) #删除元素
s1 & s2 #交集
s1 | s2 #并集
```

- 不可变对象：调用对象自身的方法不会改变该对象自身的内容，而是会创建新的对象并返回，如str
- 可变对象：恰恰相反，如list

# 函数

Python内置函数: [python手册](http://docs.python.org/3/library/functions.html#abs)
函数名就是指向函数对象的引用，可以当变量用(太骚了)。

``` python define_function
def nop():
  pass
```

``` python funct_with_arg_check
def my_abs(x):
    if not isinstance(x,(int, float)): #数据类型检查
        raise TypeError('bad operand type') #异常处理(后续会提到)
    if x >= 0:
        return x
    else:
        return -x
```

``` python multi_return_value
import math

def move(x, y, step, angle=0):
    nx = x + step * math.cos(angle)
    ny = y - step * math.sin(angle)
    return nx, ny
```
返回多值其实是返回一个tuple, 这点比c好用多了!

## 默认参数
`def power(x, n=2)`缺省时取默认值。
- 必选参数在前，可选参数在后
- 变化大的参数在前，变化小的参数在后，降低调用难度
- 默认参数必须指向**不变对象**

## 可变参数
允许你传入0个或任意个参数，这些可变参数在函数调用时自动组装为一个tuple。
参数前加`*`，可以传入任意个参数。list或tuple前加`*`表示把list或tuple的所有元素作为可变参数。
``` python changeable_args
def cal(*numbers): #加*表示可变参数
    ans = 0
    for n in numbers:
        ans += n * n
    return ans   
#传参
>>> cal(1,2) #传递变量
>>> cal(*number) #传递list和tuple
```

## 关键字参数
允许你传入0个或任意个含参数名的参数，这些关键字参数在函数内部自动组装为一个dict。
参数前加`**`，可以传入任意个关键字参数，dict前加`**`表示把这个dict的所有key-value作为参数。

## 命名关键字参数
限制关键字名字。
- 需要一个特殊分隔符`*`, 后面跟命名关键字参数。如果有可变参数，就不需要`*`
- 必须传入参数名，否则报错；可以设置默认缺省值

```python key_args
def person(name, age, **kw): #表示接受关键字参数`kw`
    print('name:', name, 'age:', age, 'other:', kw)

>>> person('Michael', 30) #可以只传入必选参数
>>> person('Adam', 45, gender='M', job='Engineer')
>>> person('Adam', 45, **extra) #将现成的dict作为参数

def person(name, age, **kw):
    if 'city' in kw: #有city参数
        pass
    if 'job' in kw: #有job参数
        pass

def person(name, age, *, city, job): 
def person(name, age, *args, city, job):
```

所有这些参数都能组合使用，理论上任意函数都可以通过`f(*args,**kw)`调用。不要使用太多组合，保持接口的可理解性。

## 递归函数
Python没有尾递归优化。

# 高级特性

## 切片
有点类似verilog里面的索引，但更高级而且范围不同。

``` python slice
L[head : tail :step] #范围[head,tail),[head,tail-1]
L[:3] #取出从第0个到第3个元素
L[-2:] #取出倒数第2个到最后1个
L[1:3] #取出从第1个到第3个元素
L[:10:2] #前10个数，每2个取一个
L[::5] #所有数，每5个取一个
L[:] #原样复制一个list
'ABCDEFG'[1:3] #字符串也可以看成List
```

## 迭代
啥都能迭代

``` python iteration
for i, value in enumerate(['A','B','C']):
    print(i, value)
# enumerate可以将list变成索引-元素对，相当于数组
for x,y in [(1,1),(2,4),(3,9)]:
    print(x,y)
#同时对两个变量进行迭代
```
通过collections模块的Iterable类型判断一个对象是否可迭代
``` python iterable
>>> from collections import Iterable
>>> isinstance('abc', Iterable) # str是否可迭代
True
```

## 列表生成式
太自然语言了。。。
``` python listgenerator
>>> [x * x for x in range(1, 11) if x % 2 == 0]

>>> import os # 导入os模块，模块的概念后面讲到
>>> [d for d in os.listdir('.')] # os.listdir可以列出文件和目录

>>> [m + n for m in 'ABC' for n in 'XYZ']
>>> [x if x % 2 == 0 else -x for x in range(1, 11)] #if在前在后的区别
```

## 生成器
一边循环一边计算的机制，generator。列表生成式的`[]`改成`()`
- list保存的是数据，generator保存的是算法。
- 使用`next()`获得generator的下一个返回值。
- generator是可迭代对象。
- 函数定义中包含关键字`yield`，就是一个generator。执行流程和函数不一样，遇到`yield`返回，再次执行从上次`yield`继续。
- 遇到return或执行到函数体的最后一句，generator结束，for循环结束。

``` python generator
g = (x * x for x in range(10)) #把list的[]变成()就可以得到生成器

def fib(max):
    n, a, b = 0, 0, 1
    while(n < max):
        yield b
        a, b = b, a + b
        #相当于(a,b) = (b, a+b)
        n = n + 1
    return 'done'
```

## 迭代器
- 可以直接作用于`for`循环的对象统称为可迭代对象`iterable`, 使用`isinstance( , Iterable)`判断。(list, dict, str, generator)
- 可以被`next()`调用并返回下个值对象称为迭代器`iterator`, 使用`isinstance( , Iterator)`判断。(generator)
- `iter()`可以把`iterable`变成`iterator`

Python的Iterator对象表示的是一个数据流，Iterator对象可以被next()函数调用并不断返回下一个数据，直到没有数据时抛出StopIteration错误。可以把这个数据流看做是一个有序序列，但我们却不能提前知道序列的长度，只能不断通过next()函数实现按需计算下一个数据，所以Iterator的计算是惰性的，只有在需要返回下一个数据时它才会计算。

# 函数式编程
函数式编程就是一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的，这种纯函数我们称之为没有副作用。而允许使用变量的程序设计语言，由于函数内部的变量状态不确定，同样的输入，可能得到不同的输出，因此，这种函数是有副作用的。(yls好像讲过这个owo)

函数式编程的一个特点就是，允许把函数本身作为参数传入另一个函数，还允许返回一个函数！(函数名也是变量)

## 高阶函数 High-order-function
变量可以指向函数，函数的参数能接收变量，一个函数就可以接收另一个函数作为参数，这种函数就称之为**高阶函数**。

### map()
接收两个参数，一个是函数，一个是`Iterable`，函数依次作用到每个元素，结果作为新的`Iterator`返回。
``` python map
>>> list(map(str, [1, 2, 3, 4, 5, 6, 7, 8, 9]))
['1', '2', '3', '4', '5', '6', '7', '8', '9']
```

### reduce()
接收两个参数，一个是函数，一个是`Iterable`, 函数必须接受两个参数，`reduce()`把结果继续和序列的下一个元素做累积计算，效果为`reduce(f, [x1, x2, x3, x4]) = f(f(f(x1, x2), x3), x4)`
``` python str2int
num = {'0':0, '1':1, '2':2, '3':3, '4':4, '5':5, '6':6, '7':7, '8':8, '9':9}

from functools import reduce

def str2num(s):
    def fn(x,y):
        return x * 10 + y
    def char2num(s):
        return num[s]
    return reduce(fn, map(char2num, s))
```
### filter()
接收一个函数和一个序列，把函数依次作用于每个元素，然后根据返回值是True还是False决定保留还是丢弃该元素。
``` python primes
def _odd_iter():
    n = 1
    while True:
        n = n + 2
        yield n

def _not_divisible(n):
    return lambda x: x % n > 0

def primes():
    yield 2
    it = _odd_iter() # 初始序列
    while True:
        n = next(it) # 返回序列的第一个数
        yield n
        it = filter(_not_divisible(n), it) # 构造新序列
```
- `filter()`的作用是从一个序列中筛出符合条件的元素。由于`filter()`使用了惰性计算，所以只有在取`filter()`结果的时候，才会真正筛选并每次返回下一个筛出的元素。

### sorted()
接受一个`key`函数来实现自定义排序，`reverse`决定正着还是反着排。
`sorted(['bob', 'about', 'Zoo', 'Credit'], key=str.lower, reverse=True)`

## 返回函数
函数作为返回值的函数。
- 闭包(closure): 内部函数可以引用外部函数的参数和局部变量，返回时，相关参数和局部变量都保存在返回的函数中。
- 返回的函数不会立刻执行，而是等到调用了才执行。
- **返回函数不要引用任何循环变量，或者后续会发生变化的变量。**

## 匿名函数
不需要显式地定义函数，关键字`lambda`表示匿名函数，冒号前的变量表示参数。
- 只能有一个表达式，不用写`return`，返回值就是该表达式的结果。

## 装饰器
在代码运行期间动态增加功能的方式，称之为“装饰器”（Decorator），本质上就是一个返回函数的高阶函数。
- 函数有一个`__name__`属性，可以获得函数的名字。

```python decorator
import functools

def log(text):
    def decorator(func):
        @functools.wraps(func)  #将原始函数的属性复制到wapper中
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))   #函数调用之外的作用
            return func(*args, **kw)    #调用原函数
        return wrapper
    return decorator

@log # @语法，相当于执行now=log(now)
def now():
    print("2021-1-29")

>>> now()
call now():
2021-1-29
```
在面向对象（OOP）的设计模式中，decorator被称为装饰模式。OOP的装饰模式需要通过继承和组合来实现，而Python除了能支持OOP的decorator外，直接从语法层次支持decorator。Python的decorator可以用函数实现，也可以用类实现。
decorator可以增强函数的功能，定义起来虽然有点复杂，但使用起来非常灵活和方便。

## 偏函数
把一个函数的某些参数固定住(设置一个参数的默认值)，返回一个新的函数，可以直接调用这个新的函数。`functools.partial(f, args, **kw)`
`int2 = functools.partial(int, base=2)`


# 模块
- 一个`.py`文件就是一个模块。
- 提高了代码的可维护性。编写程序的时候，经常引用其他模块，包括Python内置的模块和来自第三方的模块。
- 避免了函数名冲突，尽量不要与内置函数名字冲突。自己创建模块时要注意命名，一定不能和Python自带的模块名称冲突。
- 为了避免模块名冲突，Python又引入了按目录来组织模块的方法，称为包（Package）。
    + 模块名为"包名.模块名"
    + 每个包必须有一个`__init__.py`文件
    + 包可以再套娃，多级层次包结构

## 标准模块文件
``` python std-module
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Michael Liao'

import sys
```
- 第1行和第2行是标准注释，第1行注释可以让这个文件直接在Unix/Linux/Mac上运行，第2行注释表示.py文件本身使用标准UTF-8编码。
- 第4行是一个字符串，表示模块的文档注释，任何模块代码的第一个字符串都被视为模块的文档注释。
- 第6行使用__author__变量把作者写进去，这样当你公开源代码后别人就可以瞻仰你的大名。

## 导入模块
`import sys`获得变量sys指向该模块，利用sys这个变量，就可以访问sys模块的所有功能。
- 模块有一个argv变量，用list存储了命令行的所有参数。argv至少有一个元素，因为第一个参数永远是该.py文件的名称。
- 命令行中变量`__name__ == __main__`

## 作用域
- 正常的函数和变量名是公开的(public)，可以直接被引用。
- 类似`__xxx__`这样的变量是特殊变量，可以被直接引用，但是有特殊用途，我们自己的变量一般不要用这种变量名。
- 类似`_xxx`和`__xxx`这样的函数或变量就是非公开的（private），不应该被直接引用，只应该在模块内部引用。
- 这是一种非常有用的代码封装和抽象的方法，外部不需要引用的函数全部定义成private，只有外部需要引用的函数才定义为public。

## 安装第三方模块
在Python中，安装第三方模块，是通过包管理工具pip完成的。
`pip install [模块名]`

# 面向对象编程 OOP
- 在Python中，所有数据类型都可以视为对象，当然也可以自定义对象。自定义的对象数据类型就是面向对象中的**类**（Class）的概念。
- 对象拥有**属性**（Property）, 调用对象对应的关联函数，我们称之为对象的**方法**（Method）。

## 定义类
`class [Class name](object):`

`class`后面紧接着是类名，类名通常是大写开头的单词，紧接着是(object)，表示该类是从哪个类继承下来的。通常，如果没有合适的继承类，就使用object类，这是所有类最终都会继承的类。

## 实例
- 创建实例：类名+()
- 可以自由地给一个实例变量绑定属性
- 通过`__init__`方法在创建实例时把一些我们认为必须绑定的属性强制填写进去。
    + 和普通的函数相比，在类中定义的函数只有一点不同，就是**第一个**参数永远是实例变量`self`(cpp的`this`)，调用时不用传递

``` python class-definition
class Student(object):
    def __init__(self, name, score):
        self.name = name
        self.score = score
# 创建实例
bart = Student('Bart Simpson', 59)
```
数据封装，类方法，和cpp类似

## 访问限制
- 私有变量：名称前加两个下划线`__xxx`，外部无法访问(其实只是Python解释器把它解释为了另一个名字)。
- 双下划线开头双下划线结尾的，是特殊变量，特殊变量是可以直接访问的，不是private变量。
- 单下划线开头的，“虽然我可以被访问，但是，请把我视为私有变量，不要随意访问”。

## 继承和多态
- 子类继承父类的方法，相同的方法子类覆盖父类。
- 多态：对于一个变量，我们只需要知道它是父类型，无需确切地知道它的子类型，就可以放心地调用某个方法，而具体调用的方法是作用在对象上，由运行时该对象的确切类型决定。
    + 这就是多态真正的威力：调用方只管调用，不管细节，而当我们新增一种子类时，只要确保方法编写正确，不用管原来的代码是如何调用的。
    + 开闭原则：对扩展开放，允许新增子类；对修改封闭：不需要修改依赖父类型的函数。
- 比java等静态语言更开放的，不要求严格的继承体系，调用方法时只要保证对象有这样的方法。
    + 这就是动态语言的“鸭子类型”，它并不要求严格的继承体系，一个对象只要“看起来像鸭子，走起路来像鸭子”，那它就可以被看做是鸭子。

## 获得对象信息
- `type()`函数，返回对应的Class类型。
    + `int`, `str`可以直接做数据类型关键字。
    + `types`模块中定义有各种数据类型的常量。
- `isinstance()`函数，判断是否是某种类型。
    + 总是优先使用`isinstance()`判断类型，可以将指定类型及其子类“一网打尽”。
- `dir()`函数，获得一个对象的所有属性和方法，返回一个包含字符串的list。
    + 配合`getattr()`、`setattr()`以及`hasattr()`，我们可以直接操作一个对象的状态

``` python class
>>> hasattr(obj, 'x') # 有属性'x'吗？
True
>>> obj.x
9
>>> hasattr(obj, 'y') # 有属性'y'吗？
False
>>> setattr(obj, 'y', 19) # 设置一个属性'y'
>>> hasattr(obj, 'y') # 有属性'y'吗？
True
>>> getattr(obj, 'y') # 获取属性'y'
19
>>> obj.y # 获取属性'y'
19
>>> hasattr(obj, 'power') # 有属性'power'吗？
True
>>> getattr(obj, 'power') # 获取属性'power'
<bound method MyObject.power of <__main__.MyObject object at 0x10077a6a0>>
>>> fn = getattr(obj, 'power') # 获取属性'power'并赋值到变量fn
>>> fn # fn指向obj.power
<bound method MyObject.power of <__main__.MyObject object at 0x10077a6a0>>
>>> fn() # 调用fn()与调用obj.power()是一样的
81
```
类似`__xxx__`的属性和方法在Python中都是有特殊用途的，比如`__len__`方法返回长度。在Python中，如果你调用`len()`函数试图获取一个对象的长度，实际上，在`len()`函数内部，它自动去调用该对象的`__len__()`方法
- 只有在不知道对象具体信息时，才会去获取对象的信息

``` python good-example
def readImage(fp):
    if hasattr(fp, 'read'):
        return readData(fp)
    return None
# 假设我们希望从文件流fp中读取图像，我们首先要判断该fp对象是否存在read方法，如果存在，则该对象是一个流，如果不存在，则无法读取
```

## 实例属性和类属性
- 给实例绑定属性的方法是通过实例变量，或者通过self变量。
- 直接在class中定义属性，这种属性是**类属性**，归类所有，类的所有实例都可以访问到，共享。

```python class-property
class Student(object):
    name = 'Student'
```
- 千万不要对实例属性和类属性使用相同的名字，因为相同名称的实例属性将屏蔽掉类属性，但是当你删除实例属性后，再使用相同的名称，访问到的将是类属性。

## \_\_slots__
实例可以绑定属性和方法。
- 绑定方法需要使用`types`模块的`Methodtype`方法。
- 对其他实例是不起作用的。
``` python
>>> from types import MethodType
>>> s.set_age = MethodType(set_age, s) # 给实例绑定一个方法
>>> s.set_age(25) # 调用实例方法
>>> s.age # 测试结果
25
```

- 为了给所有实例都绑定方法，可以给class绑定方法，所有实例均可调用。

``` python
>>> def set_score(self, score):
...     self.score = score
...
>>> Student.set_score = set_score
```

- `__slot__`可以限制实例的属性。
    + 仅对当前类实例起作用，对继承的子类是不起作用的。
    + 除非在子类中也定义`__slots__`，这样，子类实例允许定义的属性就是自身的`__slots__`加上父类的`__slots__`。

## @property
装饰器，实现比较复杂，把一个getter方法变成属性，创建另一个装饰器`@score.setter`，负责把一个setter方法变成属性赋值。
```  python @property
class Student(object):

    @property
    def score(self):
        return self._score  # getter属性

    @score.setter
    def score(self, value): # setter属性
        if not isinstance(value, int):
            raise ValueError('score must be an integer!')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 ~ 100!')
        self._score = value
```
- @property使得对实例属性操作时，通过getter和setter方法来实现。
- 只定义getter方法就相当于定义了一个只读属性。

## 多重继承
一个子类就可以同时获得多个父类的所有功能。
- MixIn: 通过多重继承实现，除主线外的其他继承关系。
- 为了更好地看出继承关系，可以把主线外的继承类命名`xxxMixIn`

``` python 
class Dog(Mammal, RunnableMixIn, CarnivorousMixIn):
    pass
```

## 定制类
Python的class中有许多形如`__xxx__()`这样有特殊用途的函数，可以帮助我们定制类。

### \_\_str__
`__str__`方法可以改变类的实例的打印方式，返回用户看到的字符串，`__repr__`返回程序开发者看到的字符串，用于调试。
``` python __str__
>>> class Student(object):
...     def __init__(self, name):
...         self.name = name
...     def __str__(self):
...         return 'Student object (name: %s)' % self.name
...
>>> print(Student('Michael'))
Student object (name: Michael)
# 原来是<__main__.Student object at 0x109afb190>
```

### \_\_iter__
使得该对象可以被用于for循环。
该方法返回一个迭代对象，然后，Python的for循环就会不断调用该迭代对象的`__next__()`方法拿到循环的下一个值，直到遇到`StopIteration`错误时退出循环。
``` python __iter__
class Fib(object):
    def __init__(self):
        self.a, self.b = 0, 1 # 初始化两个计数器a，b

    def __iter__(self):
        return self # 实例本身就是迭代对象，故返回自己

    def __next__(self):
        self.a, self.b = self.b, self.a + self.b # 计算下一个值
        if self.a > 100000: # 退出循环的条件
            raise StopIteration()
        return self.a # 返回下一个值

>>> for n in Fib():
...     print(n)
...
1
1
2
3
5
...
46368
75025
```

### \_\_getitem__
表现得像list那样按照下标取出元素。
``` python __getitem__
class Fib(object):
    def __getitem__(self, n):
        if(isinstance(n, int)): # n是索引
            a,b = 1,1
            for x in range(1, n):
                a,b = b,a+b
            return a
        if(isinstance(n, slice)): # n是切片
            start = n.start
            stop = n.start
            if start is  None:
                start = 0
            a,b = 1,1
            L = []
            for x in range(stop):
                if x >= start:
                    L.append(a)
                a,b = b,a+b
            return L

>>> f = Fib()
>>> f[0]
1
>>> f[100]
573147844013817084101
>>> f[0:5]
[1, 1, 2, 3, 5]
```
- 以上`__getitem__()`方法没有对步长和负数做处理，因此要正确实现一个`__getitem__()`还是有很多工作要做的
- 如果把对象看成dict，`__getitem__()`的参数也可能是一个可以作key的object，例如str，与之对应的还有`__setitem__`和`__delitem__`

### \_\_getattr__
动态返回一个属性，当调用不存在的属性时，会试图调用`__getattr__(self,属性)`来尝试获得属性。
- 只有在没有找到属性的情况下才会调用__getattr__，已有的属性是直接获取的

``` python __getattr__
class Student(object):

def __getattr__(self, attr):
    if attr=='age':
        return lambda: 25
    raise AttributeError('\'Student\' object has no attribute \'%s\'' % attr)
```

### \_\_call__
使实例自身能被当作函数调用。
``` python __call__
class Student(object):
    def __init__(self, name):
        self.name = name
    
    def __call__(self):
        print('My name is %s.' % self.name)

>>> s = Student('Michael')
>>> s()
My name is Michael
```

- 通过`callable()`函数判断一个对象是否是“可调用”对象。

## 枚举类
``` python enum
from enum import Enum
Month = Enum('Month', ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
```
这样我们就获得了Month类型的枚举类，可以直接使用`Month.Jan`来引用一个常量，或者枚举它的所有成员
``` python
for name, member in Month.__members__.items():
    print(name, '=>', member, ',', member.value)
```
- `value`属性则是自动赋给成员的int常量，默认从1开始计数。

如果需要更精确地控制枚举类型，可以从Enum派生出自定义类
``` python
from enum import Enum, unique

@unique # @unique装饰器可以帮助我们检查保证没有重复值。
class Weekday(Enum):
    Sun = 0 # Sun的value被设定为0
    Mon = 1
    Tue = 2
    Wed = 3
    Thu = 4
    Fri = 5
    Sat = 6

# 访问
Weekday.Mon
Weekday['Tue']
Weekday(1)
```
- 既可以用成员名称引用枚举常量，又可以直接根据value的值获得枚举常量。

## 元类

### type()
- 动态语言的函数和类不是编译时定义的，而是运行时动态创建的。
- `type()`函数可以查看一个类型或变量的类型, 又可以创建出新的类型。
- 要创建一个class对象，`type()`依次传入3个参数
    + class的名称
    + 继承的父类集合，注意Python支持多重继承，如果只有一个父类，别忘了tuple的单元素写法
    + class的方法名称与函数绑定

``` python type()
>>> def fn(self, name='world'): # 先定义函数
...     print('Hello, %s.' % name)
...
>>> Hello = type('Hello', (object,), dict(hello=fn)) # 创建Hello class
>>> h = Hello()
>>> h.hello()
Hello, world.
>>> print(type(Hello))
<class 'type'>
>>> print(type(h))
<class '__main__.Hello'>
```

## metaclass()
据说很复杂，等用到了再来看orz


# 错误、调试和测试

## try
- 当我们认为某些代码可能会出错时，就可以用try来运行这段代码。
- 如果执行出错，则后续代码不会继续执行，而是直接跳转至错误处理代码，即except语句块，执行完except后，如果有finally语句块，则执行finally语句块，至此，执行完毕。
- 如果发生了不同类型的错误，可以有多个except来捕获不同类型的错误。
- 如果没有错误发生，可以在except语句块后面加一个else，当没有错误发生时，会自动执行else语句。

``` python try
try:
    print('try...')
    r = 10 / int('2')
    print('result:', r)
except ValueError as e:
    print('ValueError:', e)
except ZeroDivisionError as e:
    print('ZeroDivisionError:', e)
else:
    print('no error!')
finally:
    print('finally...')
print('END')
```

- Python的错误其实也是class，所有的错误类型都继承自BaseException，所以在使用except时需要注意的是，它不但捕获该类型的错误，还把其子类也“一网打尽”。
- 常见的错误类型和继承关系看[这里](https://docs.python.org/3/library/exceptions.html#exception-hierarchy)
- 可以跨越多层调用, 不需要在每个可能出错的地方去捕获错误，只要在合适的层次去捕获错误就可以了

## 调用栈
出错的时候，一定要分析错误的调用栈信息，才能定位错误的位置。

## 记录错误
Python内置的`logging`模块可以非常容易地记录错误信息。
- 程序打印完错误信息后会继续执行，并正常退出。
- 通过配置，`logging`还可以把错误记录到日志文件里，方便事后排查。

## 抛出错误
- 根据需要，可以定义一个错误的类，选择好继承关系，用`raise`语句抛出一个错误的实例。
- 只有在必要的时候才定义我们自己的错误类型。如果可以选择Python已有的内置的错误类型，尽量使用Python内置的错误类型。
- 当前函数不知道应该怎么处理该错误，继续往上抛，让顶层调用者去处理。
- 在`except`中`raise`一个Error，还可以把一种类型的错误转化成另一种类型

``` python raise-err
def foo(s):
    n = int(s)
    if n==0:
        raise ValueError('invalid value: %s' % s)
    return 10 / n

def bar():
    try:
        foo('0')
    except ValueError as e:
        print('ValueError!')
        raise  # 不带参数，就会把当前错误原样抛出

bar()
```

## 调试
- `print`调试法
- `assert`调试法
    + `-O`可以关闭`assert`

``` python assert
def foo(s):
    assert n != 0, 'n is zero!'
    #表达式应该为True，否则输出AssertionError+后接的字符串
```
- `logging`调试法
  + 可以指定记录信息的级别，有`DEBUG` > `INFO` > `WARNING` > `ERROR`等几个级别。这样一来，你可以放心地输出不同级别的信息，也不用删除，最后统一控制输出哪个级别的信息。
  + 另一个好处是通过简单的配置，一条语句可以同时输出到不同的地方，比如console和文件。

``` python logging
import logging
logging.basicConfig(level=logging.INFO)
logging.basicConfig(level=logging.INFO) # 配置
logging.info('n = %d' % n) # 输出信息
```

- pdb调试法
  + 命令和gdb差不多
  + `pdb.set_trace()`设置断点，在运行时程序会自动暂停并进入pdb

``` python pdb
import pdb

s = '0'
n = int(s)
pdb.set_trace() # 运行到这里会自动暂停
print(10 / n)
```

- IDE调试法

## 单元测试
- 对拍(?), difftest(?), 就是通过样例对设计进行正确性检验。
- 单元测试的测试用例要覆盖常用的输入组合、边界条件和异常。
- `unittest`模块提供了方便测试的流程
    + 单元测试时，我们需要编写一个测试类，从unittest.TestCase继承。
    + 以test开头的方法就是测试方法，不以test开头的方法不被认为是测试方法，测试的时候不会被执行。
    + 运行单元测试，`if __name__ == '__main__':\unittest.main()` 或 `python -m unittest xxx.py`(推荐)

``` python unittest
import unittest

from mydict import Dict

class TestDict(unittest.TestCase):

    def test_init(self):
        d = Dict(a=1, b='test')
        self.assertEqual(d.a, 1)  # 断言函数返回的结果与1相等
        self.assertEqual(d.b, 'test')
        self.assertTrue(isinstance(d, dict))

    def test_key(self):
        d = Dict()
        d['key'] = 'value'
        self.assertEqual(d.key, 'value')

    def test_attr(self):
        d = Dict()
        d.key = 'value'
        self.assertTrue('key' in d)
        self.assertEqual(d['key'], 'value')

    def test_keyerror(self):
        d = Dict()
        with self.assertRaises(KeyError): # 期待抛出指定类型的Error
            value = d['empty']

    def test_attrerror(self):
        d = Dict()
        with self.assertRaises(AttributeError):
            value = d.empty
```

## 文档测试 Doctest
- 直接提取注释中的代码并执行测试。
- 严格按照Python交互式命令行的输入和输出来判断测试结果是否正确。只有测试异常的时候，可以用...表示中间一大段烦人的输出。
- 只有在命令行直接运行时，才执行doctest。

# IO编程
IO编程中，Stream（流）是一个很重要的概念，可以把流想象成一个水管，数据就是水管里的水，但是只能单向流动。Input Stream就是数据从外面（磁盘、网络）流进内存，Output Stream就是数据从内存流到外面去。
同步IO, 异步IO

## 读文件
``` python
>>> f = open('/Users/michael/test.txt', 'r') # 传入文件名和标示符, 'r'表示读
# 文件不存在会抛出IOError错误
>>> f.read()
'Hello, world!'
>>> f.close() # 记得关
```
为了保证无论是否出错都能正确地关闭文件，我们可以使用`try ... finally`来实现:
``` python
try:
    f = open('/path/to/file', 'r')
    print(f.read())
finally:
    if f:
        f.close()
```
太繁琐, 和上面一样，会自动调用`f.close()`:
``` python
with open('/path/to/file', 'r') as f:
    print(f.read())
```

- `read(size)`一次最多读取size个字节的内容
- `readline()`每次读取一行
- `readlines()`一次读取所有内容并按行返回list

``` python
for line in f.readlines():
    print(line.strip()) # 把末尾的'\n'删掉
```

像`open()`函数返回的这种有个`read()`方法的对象，在Python中统称为file-like Object。除了file外，还可以是内存的字节流，网络流，自定义流等等。file-like Object不要求从特定类继承，只要写个`read()`方法就行。
`StringIO`就是在内存中创建的file-like Object，常用作临时缓冲

- 默认都是读取文本文件，并且是UTF-8编码的文本文件。要读取二进制文件，比如图片、视频等等，用'rb'模式打开文件

``` python
>>> f = open('/Users/michael/test.jpg', 'rb')
>>> f.read()
b'\xff\xd8\xff\xe1\x00\x18Exif\x00\x00...' # 十六进制表示的字节
```
- 读取默认使用UTF-8编码，需要编码转换的时候要给open()传入encoding参数,errors参数表示出现错误后怎么处理，一般选择忽略

``` python
>>> f = open('/Users/michael/gbk.txt', 'r', encoding='gbk', errors='ignore')
```

## 写文件
- 调用open()函数时，传入标识符'w'或者'wb'表示写文本文件或写二进制文件
- 用`with`语句保险
- 以'w'模式写入文件时，如果文件已存在，会直接覆盖。
- 传入'a'以追加（append）模式写入。

## StringIO
可以用一个str初始化StringIO，然后，像读文件一样读取
``` python
>>> from io import StringIO
>>> f = StringIO() # 创建StringIO对象
>>> f.write('hello')
5
>>> f.write(' ')
1
>>> f.write('world!')
6
>>> print(f.getvalue()) #getvalue()用于获得写入后的str
hello world!
```

## BytesIO
StringIO操作的只能是str，如果要操作二进制数据，就需要使用BytesIO。
``` python
>>> from io import BytesIO
>>> f = BytesIO()
>>> f.write('中文'.encode('utf-8'))
6
>>> print(f.getvalue())
b'\xe4\xb8\xad\xe6\x96\x87'
```

## 操作文件和目录

### 环境变量
在操作系统中定义的环境变量，全部保存在os.environ这个变量中，可以直接查看`os.vnviron`, 是个dict
要获取某个环境变量的值，可以调用`os.environ.get('key')`

- 操作文件和目录的函数一部分放在os模块中，一部分放在os.path模块中
- shutil模块有很多对os的补充
``` python
# 查看当前目录的绝对路径:
>>> os.path.abspath('.')
'/Users/michael'
# 在某个目录下创建一个新目录，首先把新目录的完整路径表示出来:
>>> os.path.join('/Users/michael', 'testdir')
'/Users/michael/testdir'
# 然后创建一个目录:
>>> os.mkdir('/Users/michael/testdir')
# 删掉一个目录:
>>> os.rmdir('/Users/michael/testdir')

os.path.join() # 把两个路径合成一个
os.path.split() # 拆分路径
os.path.splitext() # 直接得到文件扩展名
# 这些合并、拆分路径的函数并不要求目录和文件要真实存在，它们只对字符串进行操作。

# 对文件重命名:
>>> os.rename('test.txt', 'test.py')
# 删掉文件:
>>> os.remove('test.py')
```

一些应用：
``` python
>>> [x for x in os.listdir('.') if os.path.isdir(x)] # 列出当前目录下的所有目录
>>> [x for x in os.listdir('.') if os.path.isfile(x) and os.path.splitext(x)[1]=='.py'] # 列出所有.py文件
```

## 序列化
pickle模块，用到再看。

# 进程和线程
线程是最小的执行单元，而进程由至少一个线程组成。如何调度进程和线程，完全由操作系统决定，程序自己不能决定什么时候执行，执行多长时间。

## 多进程(multiprocessing)
Unix/Linux操作系统提供了一个`fork()`系统调用，它非常特殊。普通的函数调用，调用一次，返回一次，但是`fork()`调用一次，返回两次，因为操作系统自动把当前进程（称为父进程）复制了一份（称为子进程），然后，分别在父进程和子进程内返回。
- 子进程永远返回0，而父进程返回子进程的ID。
- Python的os模块封装了常见的系统调用，其中就包括fork.
- multiprocessing模块就是跨平台版本的多进程模块。multiprocessing模块提供了一个Process类来代表一个进程对象。
- 如果要启动大量的子进程，可以用进程池(Pool)的方式批量创建子进程。
---
title: Python常用内建模块
date: 2021-02-25 14:14:58
categories: python
tags: language
---

参考: [廖雪峰python教程](https://www.liaoxuefeng.com/wiki/1016959663602400)
学习完了python基本语法，更重要的是对python各种库的熟练运用，本章主要是对python内建库的讲解。
<!--more -->

# datetime
datetime是Python处理日期和时间的标准库。

``` python
>>> from datetime import datetime
>>> now = datetime.now() # 获取当前datetime
>>> print(now)
2021-02-25 14:18:54.205754
>>> print(type(now))
<class 'datetime.datetime'>
```
- 注意到`datetime`是模块，`datetime`模块还包含一个`datetime`类，通过`from datetime import datetime`导入的才是`datetime`这个类。
- 如果仅导入`import datetime`，则必须引用全名`datetime.datetime`。

``` python
>>> from datetime import datetime
>>> dt = datetime(2015, 4, 19, 12, 20) # 用指定日期时间创建datetime
```

## datatime转timestamp
``` python
dt.timestamp()
```
- 注意Python的timestamp是一个浮点数，整数位表示秒。
- timestamp的值与时区毫无关系，因为timestamp一旦确定，其UTC时间就确定了，转换到任意时区的时间也是完全确定的，这就是为什么计算机存储的当前时间是以timestamp表示的，因为全球各地的计算机在任意时刻的timestamp都是完全相同的（假定时间已校准）。

## timestamp转datetime
``` python
>>> t = 1429417200.0
>>> print(datetime.fromtimestamp(t)) # 本地时间（当前操作系统的时区）
2015-04-19 12:20:00
>>> print(datetime.utcfromtimestamp(t)) # UTC时间
2015-04-19 04:20:00
```

## str转datetime
``` python
>>> cday = datetime.strptime('2015-6-1 18:19:59', '%Y-%m-%d %H:%M:%S')
>>> print(cday)
2015-06-01 18:19:59
```
- 字符串'%Y-%m-%d %H:%M:%S'规定了日期和时间部分的格式。详细的说明请参考[Python文档](https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior)。
- 转换后的datetime是没有时区信息的。

##  datetime转str
``` python
>>> now = datetime.now()
>>> print(now.strftime('%a, %b %d %H:%M'))
Thu, Feb 25 14:18
```

## datetime加减
对日期和时间进行加减实际上就是把datetime往后或往前计算，得到新的datetime。加减可以直接用+和-运算符，不过需要导入timedelta这个类。
``` python
>>> from datetime import datetime, timedelta
>>> now = datetime.now()
>>> now + timedelta(days=2, hours=12)
datetime.datetime(2021, 2, 28, 2, 18, 54, 205754)
```

## 时区转换
``` python
# 拿到UTC时间，并强制设置时区为UTC+0:00:
>>> utc_dt = datetime.utcnow().replace(tzinfo=timezone.utc)
>>> print(utc_dt)
2015-05-18 09:05:12.377316+00:00
# astimezone()将转换时区为北京时间:
>>> bj_dt = utc_dt.astimezone(timezone(timedelta(hours=8)))
>>> print(bj_dt)
2015-05-18 17:05:12.377316+08:00
# astimezone()将转换时区为东京时间:
>>> tokyo_dt = utc_dt.astimezone(timezone(timedelta(hours=9)))
>>> print(tokyo_dt)
2015-05-18 18:05:12.377316+09:00
# astimezone()将bj_dt转换时区为东京时间:
>>> tokyo_dt2 = bj_dt.astimezone(timezone(timedelta(hours=9)))
>>> print(tokyo_dt2)
2015-05-18 18:05:12.377316+09:00
```
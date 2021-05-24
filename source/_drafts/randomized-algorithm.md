---
title: 问题求解学习笔记-随机算法
tags: problem-solving
---

# 介绍

我们至今仍然不知道任何NP难问题的随机多项式算法。

我们只知道一些问题，满足：

- 有高效的多项式随机算法
- 没有已知的多项式时间确定算法
- 不知道它是否属于 $P$

随机算法和近似算法结合的合理性在于，算法输出错误结果的概率甚至小于确定性算法长时间运行下硬件出错的概率。



---

# 随机算法的分类和设计范式

## 一些概念

我们可以把随机算法就看成是在运行中需要随机数的算法，并且后续运行需要这些随机数。

- $S_{A,x} = \{ C | C \text{ 是 }A \text{ 在 }x \text{ 上的一个随机计算}\}$。
- $Prob $ 是 $S_{A,x} $ 的概率分布。

- $Random_A(x)$ 是 $A $ 在 $x$ 上运行中的最大随机数位数。
- $Random_A(n) = \max\{Random_A(x) | x \text{ 是大小为 } n \text{ 的输入}\}$。

复杂度的衡量是重要的因为：

- 生成伪随机数需要开销，一般和位数成正比
- “去随机化”



算法 $A$ 对于输入 $x$ 输出 $y$ 的概率 $Prob(A(x) = y)$ 是所有 $C$ 输出 $y$ 的 $Prob_{A , x}(C) $ 的和。随机算法的目标就是让输出正确的 $y$ 的 $Prob(A(x) = y)$ 尽可能大。

- $Time(C) $ 是 $C$ 的运行时间，则 $A $ 对于输入 $x$ 的期望时间复杂度是： $Exp-Time_A(x) = E[Time] = \sum\limits_{C}Prob_{A,x}(C) \cdot Time(C)$
- $Exp-Time_A(n) = \max\{Random_A(x) | x \text{ 是大小为 } n \text{ 的输入}\}$。
- 有时我们也考虑最坏情况复杂度： $Time_A(x) = \max\{Time(C) | C \text{ 是 }A \text{ 在 }  x \text{ 上的运行} \}$。
- $Time_A(n) = \max\{Time_A(x) | x \text{ 是大小为 } n \text{ 的输入} \}$。

## 分类

### 拉斯维加斯算法（Las Vegas Algorithms）

定义一个算法 $A$ 是问题 $F$ 的拉斯维加斯算法：

1. 对于任意的输入 $x$，$Prob(A(x) = F(x)) = 1$，$F(x)$ 是问题 $F$ 对 $x$ 的解。
   - 这样 $A$ 的复杂度一般被认为是 $Exp-Time_A(n)$。

2. 我们允许输出 "?"（不能按时解决问题）。对任意的输入 $x$，$Prob(A(x) = F(x)) \geq \dfrac{1}{2}$ 且 $Prob(A(x)= '?')=  1 - Prob(A(x) = F(x)) \leq \dfrac{1}{2}$ 。
   - 这样 $A$ 的复杂度一般被认为是 $Time_A(n)$，因为一般需要运行到 $Time_A(x)$ 才能判断“？”。



### 单错蒙特卡罗算法（One-Sided-Error Monte Carlo Algorithm）

只对判定问题有用。

算法 $A$ 是语言 $L$ 的单错蒙特卡罗算法当：

1. 对任意的 $x \in L$，$Prob(A(x) = 1 ) \geq 1/2$；
2. 对任意的 $x \notin L$，$Prob(A(x)  = 0) = 1$。

所以单错蒙特卡罗算法不会误判错误的输入，但有小概率误判正确的输入，只有单方向错。



### 双错蒙特卡算法（Two-Sided-Error Monte Carlo Algorithm）

$F$ 是一个计算问题，一个随机算法 $A$ 是双错蒙特卡算法当：

- 存在一个实数 $0 < \varepsilon \leq 1/2$，使得对任意的输入 $x$ ， $Prob(A(x) = F(x)) \geq \dfrac{1}{2}  + \varepsilon$。
- 让算法跑 $t$ 次，取出现次数至少是 $\lceil t / 2 \rceil$ 的结果，正确的概率很大。

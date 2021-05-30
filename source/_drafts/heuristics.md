---
title: 问题求解笔记-启发式算法
categories: problem-solving
tags:
mathjax: true
typora-root-url: heuristics
---



---

# 模拟退火算法（Simulated Annealing）

## 基本概念

- $U = (\Sigma_I, \Sigma_O, L, L_I, \mathcal{M}, cost, goal)$ 是一个优化问题，对任意的 $x \in L_I$，$\mathcal{M}(x)$ 的一个**邻域（Neighborhood）**是一个映射 $f_x: \mathcal{M}(x) \to Pot(\mathcal{M(x)})$ 满足：
  - $\forall \alpha \in \mathcal{M}(x), \alpha \in f_x(\alpha)$
  
  - 如果 $\exists \alpha \in \mathcal{M}(x), \beta\in f_x(\alpha)$，则 $\alpha \in f_x(\beta)$
  
  - 对任意的 $\alpha, \beta \in \mathcal{M}(x)$，所在一个正整数 $k$ 和 $\gamma_1, ..., \gamma_k \in \mathcal{M}(x)$，使得 
  
    $\gamma_1 \in f_x(\alpha), \gamma_{i  +1 } \in f_x(\gamma_i), i = 1, ... k-1$ 且 $\beta \in f_x(\gamma_k)$​
- $LSS(Neigh)$



模拟退火算法是从一个物理退火模型（Metropolos Algorithm）类比启发启发得到的，和 $LSS$ 的区别是有概率允许状态向恶化的方向转化，来防止局部最优解。

一些概念的类比：
|   物理退火   |     模拟退火     |
| :-: | :-: |
|   系统状态   |    可行解集合    |
|   状态能量   |   可行解的代价   |
|   扰动机制   | 从邻居的随机选择 |
| 一个最优状态 |  一个最优可行解  |
|     温度     |     控制参数     |

所以模拟退火其实就是建立在类比 Metropolos Algorithm上，得到的一个局部搜索算法。

对于一个优化问题的固定的邻域，模拟退火可以被描述为：

![](SA.png "模拟退火算法")



## 理论和经验

**定理 6.2.2.1.**  $U$ 是一个最小化问题且让 $Neigh$ 是 $U$ 的邻域，对于输入 $x$ 模拟退火算法的渐进收敛（asymptotic convergence）被保证如果以下两个条件被满足：

- 每个 $\mathcal{M}(x)$ 的可行解是可到达的，从每个其他的 $\mathcal{M}(x)$ 的可行解。（邻域的定义条件III）
- 初始条件 $T$ 至少是最深的局部最小值。

*渐进收敛意味着随着迭代次数的增长，到达全局最优的概率趋向于1*。

*就是说模拟退火算法会 find itself at a  global optimum an increasing percentage of the time as time grows.*（我也没读懂）

一般还有要求：

- 邻域的对称性（邻域定义的条件II）
- 邻域的均匀性，$\forall \alpha, \beta \in \mathcal{M}(x),|Neigh_x (\alpha)| = |Neigh_x(\beta)|$

- 通过特定的 *cool schedules*，$T$ 增长缓慢

很遗憾在限定的迭代次数内，模拟退火并不能确保可行解的高质量，一般需要解空间的平方大小的次数的迭代。所以相比运行模拟退火到确保一个正确的近似解，还不如直接搜索全空间。。。

模拟退火的收敛率是和迭代次数成对数关系。

应该尽可能地避免以下结构的邻域：

- 尖峰结构
- 深沟
- 大高原

*因为模拟退火第一部分是在高温下完成的，使得所有恶化方向都有可能，所以可以视为对初始解的随机搜索。然后当 $T$ 很小，大的恶化基本上是不可能的。*



如果谈到 cool schedules，以下的参数一定要确定：

- 初始温度 $T$
- 温度缩减函数 $f(T, t)$
- 终止条件



### 初始温度的选择

需要很大。

一种方法是取任意两个相邻解的最大差值，比较难算，所以只要高效地找到一个估计值（上界）就足够了。

另一种实用的方法是，从任意 $T$ 值开始，在选择了初始情况 $\alpha$ 的邻居 $\beta$ 后，以一种使 $\beta$ 以靠近1的概率被接受的方式增加 $T$。进行若干次迭代，可以得到一个合理的初值 $T$。*可以看作物理类比的加热过程*



### 选择温度缩减函数（Temperature Reduction Function）

一个一般的方式是 $T$ 乘以一个系数 $0.8\leq r \leq 0.99$，工作常数 $d$ 步得到 $T := r \cdot T$。

也就是缩减 $k$ 次得到的温度 $T_k$ 为 $r_k\cdot T$。



另一个选择是 $T_k := \dfrac{T}{\log_2{(k  +2)}}$，常数 $k$ 一般为邻域的大小。



### 终止条件

一个方法是终止条件独立于 $T$，当解的代价（cost）不变时终止。

另一种是设一个常数 $term$，当 $T \leq term$ 时终止。



### 一般性质


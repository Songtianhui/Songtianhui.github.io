---
title: 吴恩达机器学习笔记
date: 2021-02-03 15:04:20
categories: ML
tags: ML
mathjax: true
---

# Lecture 1

## 监督学习(Supervised Learning)
- 监督学习指的就是我们给学习算法一个数据集。这个数据集由“正确答案”组成，再根据这些样本作出预测。
- 回归问题，即通过回归来推出一个**连续**的输出。
- 分类问题，其目标是推出一组**离散**的结果。

<!--more -->

## 无监督学习(Unsupervised Learning)
- 在无监督学习中，我们已知的数据。不同于监督学习的数据，即无监督学习中没有任何的标签或者是有相同的标签或者就是没标签。
- 监督学习算法可能会把这些数据分成不同的簇，所以叫做聚类算法。

分离音频代码: `[W,s,v] = svd((repmat(sum(x.*x,1),size(x,1),1).*x)*x')`

# Lecture 2
本章主要介绍单变量线性回归问题，其中的一些基本概念和梯度下降法解决回归问题。

## 模型表示(Model Representation)
在监督学习中我们有一个数据集，这个数据集被称训练集(Training Set)。
- $m$: 训练集中实例的数量
- $x$: 特征/输入变量
- $y$: 目标/输出变量
- $(x, y)$: 训练集中的实例  
- $(x^{(i)}, y^{(i)})$: 第$i$个观察实例  
- $h$: 代表学习算法的解决方案或函数也称为假设函数(hypothesis), 从$x$到$y$的映射
    + 一种$h$的表达方式: $h_{\theta}(x) = \theta_{0} + \theta_{1}x$. 因为只含有一个特征/输入变量，因此这样的问题叫作单变量线性回归问题。

## 代价函数(Cost Function)
我们现在要做的便是为我们的模型选择合适的**参数**(**parameters**) $\theta_{0}$和$\theta_{1}$, 我们选择的参数决定了我们得到的直线相对于我们的训练集的准确程度，模型所预测的值与训练集中实际值之间的差距就是**建模误差**(**modeling error**)
我们的目标便是选择出可以使得建模误差的平方和能够最小的模型参数。 即使得代价函数 $J \left( \theta_0, \theta_1 \right) = \dfrac{1}{2m}\sum\limits_{i=1}^m \left( h_{\theta}(x^{(i)})-y^{(i)} \right)^{2}$ 最小。
- **代价函数**也被称作平方误差函数，有时也被称为平方误差代价函数。对于大多数问题，特别是回归问题，都是一个合理的选择。

## 梯度下降(Gradient Descent)
梯度下降是一个用来求函数最小值的算法，背后的思想是：开始时我们随机选择一个参数的组合$\left( {\theta_{0}},{\theta_{1}},......,{\theta_{n}} \right)$，计算代价函数，然后我们寻找下一个能让代价函数值下降最多的参数组合。我们持续这么做直到找到一个局部最小值（**local minimum**），因为我们并没有尝试完所有的参数组合，所以不能确定我们得到的局部最小值是否便是全局最小值（**global minimum**），选择不同的初始参数组合，可能会找到不同的局部最小值。
批量梯度下降(**batch gradient descent**)算法的公式为:
**repeat until convergence{**
$$\theta_{j}:=\theta_{j}-\alpha \dfrac{\partial}{\partial \theta_{j}} J\left(\theta_{0}, \theta_{1}\right)$$
**}**

其中$\alpha$是学习率(**learning rate**)，它决定了我们沿着能让代价函数下降程度最大的方向向下迈出的步子有多大，在批量梯度下降中，我们每一次都**同时**让所有的参数减去学习速率乘以代价函数的导数。

## 梯度下降的线性回归(Gradient Descent For Linear Regression)

对我们之前的线性回归问题运用梯度下降法，关键在于求出代价函数的导数，即:
$\dfrac{\partial}{\partial \theta_{j}} J(\theta_{0}, \theta_{1}) = \dfrac{\partial}{\partial \theta_{j}} \dfrac{1}{2m}\sum\limits_{i=1}^{m}(h_{\theta}(x^{(i)}) - y^{(i)})^{2}$

$j=0$ 时：$\dfrac{\partial}{\partial \theta_{0}}J(\theta_{0}, \theta_{1}) = \dfrac{1}{m}\sum\limits_{i=1}^{m}(h_{\theta}(x^{(i)}) - y^{(i)})$

$j=1$ 时：$\dfrac{\partial}{\partial \theta_{1}}J(\theta_{0}, \theta_{1}) = \dfrac{1}{m}\sum\limits_{i=1}^{m}((h_{\theta}(x^{(i)}) - y^{(i)}) \cdot x^{(i)})$

则算法改写成:
**repeat until convergence{**
$$\theta_{0} := \theta_{0} - \alpha \dfrac{1}{m}\sum\limits_{i=1}^{m}(h_{\theta}(x^{(i)}) - y^{(i)})$$
$$\theta_{1} := \theta_{1} - \alpha \dfrac{1}{m}\sum\limits_{i=1}^{m}((h_{\theta}(x^{(i)}) - y^{(i)}) \cdot x^{(i)})$$
​               **}**

- 如果你之前学过线性代数, 你应该知道有一种计算代价函数$J$最小值的数值解法, 这是另一种称为正规方程(**normal equations**)的方法。
- 实际上在数据量较大的情况下，梯度下降法比正规方程要更适用一些。

# Lecture 3
本章主要复习线性代数，虽然我线代没考好但是我觉得掌握的只是应该够用了，略(doge)。

# Lecture 4

## 多维特征 Multiple Features
多个变量的模型中的特征为$\left( {x_{1}},{x_{2}},...,{x_{n}} \right)$。
新的注释:
- $n$: 特征的数量
- $x^{\left( i \right)}$: 第 $i$ 个训练实例，是特征矩阵中的第$i$行，是一个**向量**（**vector**）
- $x_{j}^{\left( i \right)}$: 特征矩阵中第 $i$ 行的第 $j$ 个特征，也就是第 $i$ 个训练实例的第 $j$ 个特征

支持多变量的假设 $h$ 表示为：$h_{\theta}\left( x \right)=\theta_{0}+\theta_{1}x_{1}+\theta_{2}x_{2}+...+\theta_{n}x_{n}$，这个公式中有$n+1$个参数和$n$个变量，为了使得公式能够简化一些，引入$x_{0}=1$，则公式转化为：$h_{\theta} \left( x \right)=\theta_{0}x_{0} + \theta_{1}x_{1}+\theta_{2}x_{2}+...+\theta_{n}x_{n}$
此时模型中的参数是一个$n+1$维的向量，任何一个训练实例也都是$n+1$维的向量，特征矩阵$X$的维度是 $m*(n+1)$。 因此公式可以简化为：$h_{\theta} \left( x \right)=\theta^{T}X$，其中上标$T$代表矩阵转置。

## 多变量梯度下降 Gradient Descent for Multiple Variables
代价函数: $J\left( \theta_{0},\theta_{1}...\theta_{n} \right)=\dfrac{1}{2m}\sum\limits_{i=1}^{m}\left( h_{\theta} \left(x^{\left( i \right)} \right)-y^{\left( i \right)} \right)^{2}$ 
其中：$h_{\theta}\left( x \right)=\theta^{T}X=\theta_{0}+\theta_{1}x_{1}+\theta_{2}x_{2}+...+\theta_{n}x_{n}$， 我们的目标和单变量线性回归问题中一样，是要找出使得代价函数最小的一系列参数。
算法为:
**repeat until convergence{**
$$\theta_{j}:=\theta_{j}-\alpha \dfrac{\partial}{\partial \theta_{j}} J\left(\theta_{0}, \theta_{1}, ..., \theta_{n} \right)$$
**}**
即:
**repeat until convergence{**
$$\theta_{j}:=\theta_{j}-\alpha \dfrac{\partial}{\partial \theta_{j}} \dfrac{1}{2m} \sum_{i=1}^{m}(h_{\theta}(x^{(i)}) - y^{(i)}) ^{2}$$
**}**
求导后得:
**repeat until convergence{**
$$\theta_{j}:=\theta_{j}-\alpha \dfrac{1}{m} \sum_{i=1}^{m}((h_{\theta}(x^{(i)}) - y^{(i)}) * x_{j}^{(i)})$$
(simultaneously update $\theta_{j}$ for $i = 1,2,...,n$)

**}**
我们开始随机选择一系列的参数值，计算所有的预测结果后，再给所有的参数一个新的值，如此循环直到收敛。
``` python
def computeCost(X, y, theta):
    inner = np.power(((X * theta.T) - y), 2)
    return np.sum(inner) / (2 * len(X))
```

## 特征缩放 Feature Scaling
在我们面对多维特征问题的时候，我们要保证这些特征都具有相近的尺度，这将帮助梯度下降算法更快地收敛(标准化，归一化)。
- 最简单的方法是令：$x_{n}=\dfrac{x_{n}-\mu_{n}}{s_{n}}$，其中 $\mu_{n}$是平均值，$s_{n}$是标准差。

## 学习率 Learning Rate
梯度下降算法的每次迭代受到学习率的影响，如果学习率$\alpha$过小，则达到收敛所需的迭代次数会非常高；如果学习率$\alpha$过大，每次迭代可能不会减小代价函数，可能会越过局部最小值导致无法收敛。

## 特征和多项式回归 Features and Polynomial Regression
线性回归并不适用于所有数据，有时我们需要曲线来适应我们的数据, 通常我们需要先观察数据然后再决定准备尝试怎样的模型。
- 我们可以令：$x_{2}=x^{2},x_{3}=x^{3}$，从而将模型转化为线性回归模型。
- 如果我们采用多项式回归模型，在运行梯度下降算法前，特征缩放非常有必要。

## 正规方程 Normal Equation
正规方程是通过求解下面的方程来找出使得代价函数最小的参数的：$\dfrac{\partial}{\partial \theta_{j}}J\left( \theta_{j} \right)=0$ 。
 假设我们的训练集特征矩阵为 $X$（包含了 $x_{0}=1$）并且我们的训练集结果为向量 $y$，则利用正规方程解出向量 $\theta =\left( X^{T}X \right)^{-1}X^{T}y$.
上标$T$代表矩阵转置，上标$-1$代表矩阵的逆。
- 只要特征变量的数目并不大，标准方程是一个很好的计算参数$\theta $的替代方法。具体地，只要特征变量数量小于一万，标准方程法，而不使用梯度下降法。

``` python
import numpy as np
    
def normalEqn(X, y):
    theta = np.linalg.inv(X.T@X)@X.T@y #X.T@X等价于X.T.dot(X)
    return theta
```

# Lecture 5
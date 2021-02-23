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
本章主要是**Ovtave**的语法学习，现在基本使用**Python**，跳过本章。

# Lecture 6
本章主要是对于解决分类问题的逻辑回归算法的讲解。

## 分类问题 Classification
我们将因变量(**dependent variable**)可能属于的两个类分别称为负向类（**negative class**）和正向类（**positive class**），则因变量$y\in \{ 0,1 \}$ ，其中 0 表示负向类，1 表示正向类。

## 假说表示 Hypothesis Representation
我们希望我们的分类器的输出值在**0和1之间**，因此，我们希望想出一个满足某个性质的假设函数，这个性质是它的预测值要在0和1之间。
我们引入一个新的模型，逻辑回归，该模型的输出变量范围始终在0和1之间。
逻辑回归模型的假设是： $h_{\theta}(x) = g(\theta^{T}X)$
其中：
$X$ 代表特征向量
$g$ 代表逻辑函数（**logistic function**)是一个常用的逻辑函数为**S**形函数（**Sigmoid function**），公式为： $g(z) = \dfrac{1}{1 + e^{-z}}$.

``` python sigmoid
import numpy

def sigmoid(z):
    return 1 / (1 + np.exp(-z))
```
函数图像为:
![sigmoid(z)](g.jpg)
$h_{\theta}( x )$的作用是，对于给定的输入变量，根据选择的参数计算输出变量=1的可能性（**estimated probablity**）即$h_{\theta} ( x )=P( y=1|x;\theta)$

## 判定边界 Decision Boundary
线性规划？反正就是约束条件所导致的曲线分界线。
我们可以用非常复杂的模型来适应非常复杂形状的判定边界。

## 代价函数
对于线性回归模型，我们定义的代价函数是所有模型误差的平方和。理论上来说，我们也可以对逻辑回归模型沿用这个定义，但是问题在于，当我们将$h_{\theta}(x) = \dfrac{1}{1 + e^{-\theta^{T}X}}$带入到这样定义了的代价函数中时，我们得到的代价函数将是一个非凸函数（**non-convexfunction**）。
这意味着我们的代价函数有许多**局部最小值**，这将影响梯度下降算法寻找全局最小值。
我们重新定义逻辑回归的代价函数为: $J(\theta) = \dfrac{1}{m}\sum\limits_{i=1}^{n} Cost(h_{\theta}(x^{(i)}), y^{(i)})$, 其中
$$ Cost(h_{\theta}(x^{(i)}), y^{(i)})=\left\{
\begin{aligned}
- \log{(h_{\theta}(x))}, &y = 1\\
- \log{(1- h_{\theta}(x))}, &y = 0
\end{aligned}
\right.
$$
再简化得:
$$Cost(h_{\theta}(x^{(i)}), y^{(i)}) = -y \times \log{(h_{\theta}(x))} - (1 - y) \times \log{(1- h_{\theta}(x))}$$
带入代价函数得:
$$J(\theta) = -\dfrac{1}{m}\sum\limits_{i=1}^{n} [y \times \log{(h_{\theta}(x))} + (1 - y) \times \log{(1- h_{\theta}(x))}] $$

``` python cost
import numpy as np

def cost(theta, X, y):
    theta = np.matrix(theta)
    X = np.matrix(X)
    y = np.matrix(y)
    first = np.multiply(-y, np.log(sigmoid(X* theta.T)))
    second = np.multiply((1 - y), np.log(1 - sigmoid(X* theta.T)))
    return np.sum(first - second) / (len(X))

# python实现的tips: 一般都是将输入用np.matrix向量化，再通过np的一些方法(np.sum, np.multiply)来运算，减少循环
```

凸性分析的内容是超出这门课的范围的，但是可以证明我们所选的代价值函数会给我们一个凸优化问题。代价函数$J(\theta)$会是一个凸函数，并且没有局部最优值。

在得到这样一个代价函数以后，我们便可以用梯度下降算法来求得能使代价函数最小的参数了。
**repeat until convergence{**
$$\theta_{j}:=\theta_{j}-\alpha \dfrac{\partial}{\partial \theta_{j}} J\left(\theta \right)$$
**}**

考虑$h_{\theta}(x) = \dfrac{1}{1 + e^{-\theta^{T}X}}$, 有：
$$\dfrac{\partial}{\partial \theta_{j}} J(\theta) = \dfrac{1}{m} \sum\limits_{i=1}^{n} [(h_{\theta}(x^{(i)}) -y^{(i)}) x_{j}^{(i)}]$$
~~推导略，不信的话自己去算算~~
- 虽然得到的梯度下降算法表面上看上去与线性回归的梯度下降算法一样，但是这里的$h_{\theta}(x)$与线性回归中不同，所以实际上是不一样的。另外，在运行梯度下降算法之前，进行特征缩放依旧是非常必要的。

除了梯度下降算法以外，还有一些常被用来令代价函数最小的算法，这些算法更加复杂和优越，而且通常不需要人工选择学习率，通常比梯度下降算法要更加快速。这些算法有：**共轭梯度**（**Conjugate Gradient**），**局部优化法**(**Broyden fletcher goldfarb shann,BFGS**)和**有限内存局部优化法**(**LBFGS**) 

## 多类别分类 Multiclass Classification
对每一个类别，创建一个新“伪”的训练集，拟合一个合适的分类器。
就是将一个类标为正类，其他都为负类，得到一系列模型记为$h_{\theta}^{(i)}(x) = p(y = i | x;\theta), i = 1,2,...,k$
最后，在我们需要做预测时，我们将所有的分类机都运行一遍，然后对每一个输入变量，都选择最高可能性的输出变量。
---
title: 问求学习笔记-近似算法
tags: problem-solving
mathjax: true
date: 2021-05-18 12:38:59
---


# 基本概念

<!--more -->

- $U = (\Sigma_I, \Sigma_O, L, L_I,\mathcal{M}, cost, goal)$ 是一个优化问题，$A$ 是相应的一个算法。对于任意的 $x \in L_1$，定义**$A$对$x$的相对误差$\varepsilon_{\boldsymbol{A}}(\boldsymbol{x})$** 如下：

$$
\varepsilon_{\boldsymbol{A}}(\boldsymbol{x})=\frac{\left|cost(A(x))-Opt_{U}(x)\right|}{Op t_{U}(x)}
$$

- 定义算法**$A$对相对误差（relative error）$\varepsilon_{\boldsymbol{A}}(\boldsymbol{n})$** 如下：
  $$
  \varepsilon_{A}(n)=\max \left\{\varepsilon_{A}(x) \mid x \in L_{I} \cap\left(\Sigma_{I}\right)^{n}\right\}
  $$

- 定义$A$对$x$的**近似比率（approximation ratio）$\boldsymbol{R}_{\boldsymbol{A}}(\boldsymbol{x})$** 如下：
  $$
  \boldsymbol{R}_{\boldsymbol{A}}(\boldsymbol{x})=\max \left\{\frac{cost(A(x))}{Opt_{U}(x)}, \frac{Opt_{U}(x)}{cost(A(x))}\right\}
  $$

- 定义算法**$A$的近似比率$\boldsymbol{R}_{\boldsymbol{A}}(\boldsymbol{n})$** 如下：
  $$
  \boldsymbol{R}_{\boldsymbol{A}}(\boldsymbol{n})=\max \left\{R_{A}(x) \mid x \in L_{I} \cap\left(\Sigma_{I}\right)^{n}\right\}
  $$

- 对任意的实数 $\delta > 1$，如果 $\forall x \in L_1,R_A(x) \leq \delta$，则称 $A $ 为 **$\delta$-近似算法（approximation algorithm）**。
- 对任意的实数 $\delta > 1$，如果 $\forall n \in \mathbb{N},R_A(n) \leq f(n)$，则称 $A$ 为 **$f(n)$-近似算法**。

- 一个例子——生产调度问题
  - GMS



- $U = (\Sigma_I, \Sigma_O, L, L_I,\mathcal{M}, cost, goal)$ 是一个优化问题，$A$ 是相应的一个算法。如果对任意的输入对 $(x, \varepsilon) \in L_1 \times \mathbb{R}^+$，$A$ 能够在至多 $\varepsilon$ 的相对误差内计算出一个可行解 $A(x)$，并且 $Time_A(x, \varepsilon^{-1})$ 可以被 $|x|$ 的多项式函数约束，则 $A$ 称为 $U$ 的**多项式时间近似近似方案（PTAS）**。

  - 如果 $Time_A(x, \varepsilon^{-1})$ 可以同时被 $|x|$ 和 $\varepsilon^{-1}$ 的多项式函数约束，则称为**完全多项式时间近似方案（FPTAS）**
  - *所以 FPTAS 应该是对 NP-hard 问题最优解了。*

---
# 优化问题的分类

（建立在 $P \neq NP$）我们将 NPO 问题分为五类：
- NPO(I)：所有存在 FPTAS 的NPO优化问题。
- NPO(II)：所有存在 PTAS 的NPO优化问题。
- NPO(III)：所有的优化问题 $U$ 满足
  - 存在 $\delta > 1$ 的多项式时间 $\delta$-近似算法
  - 没有 $d < \delta$ 的多项式时间 $d-$近似算法，即没有 PTAS
- NPO(IV)：所有的优化问题 $U$ 满足
  - 存在多项式界的函数 $f : \mathbb{N} \to \mathbb{R}^+$，对 $U$ 有多项式时间 $f(n)$-近似算法
  - 不存在 $\delta \in \mathbb{R}^+$ 的多项式时间 $\delta$-近似算法
- NPO(V)：所有的优化问题满足，如果存在一个多项式时间 $f(n)$-近似算法，则 $f(n)$ 没有 polylogarithmic函数界。

---
# 近似的稳定性

- $U = (\Sigma_I, \Sigma_O, L, L_I,\mathcal{M}, cost, goal)$ 和 $\overline{U} = (\Sigma_I, \Sigma_O, L, L,\mathcal{M}, cost, goal)$ 是两个优化问题，$L_1 \subset L$。$\overline{U}$ 关于 $L_1$ 的**距离函数（distance function）** 是任意一个函数 $h_L : L \to \mathbb{R}^{\geq 0}$ 满足
  - $\forall x \in L_I, h_L(x) = 0$
  - $h$ 是多项式可计算的
- $\textbf{Ball}_{r,h}(L_I) = \{ w \in L | h(w) \leq r\}$
- $A$ 是 $\overline{U}$ 的一个算法，且 $A$ 是 $U$ 的一个 $\varepsilon$-近似算法，对某个 $\varepsilon \in \mathbb{R}^{>1}$。$p$ 是一个正实数，若对任意实数 $0 < r \leq p$，存在 $\delta_{r, \varepsilon} \in \mathbb{R}^{>1}$，使得 $A$ 是 $U_r = \{\Sigma_I, \Sigma_O, L, Ball_{r,h}(L_I),\mathcal{M}, cost, goal\}$ 一个 $\delta_{r, \varepsilon}$-近似算法，则 $A$ 称为对于$h$ 是 **$p$-稳定（$p$-stable）**。
- $A$ 是**稳定的（stable）**，如果对任意 $p \in \mathbb{R}^+$，$A$ 是 $p$-稳定的。


- $A = \{ A_\varepsilon\}_{\varepsilon > 0}$ 是 $U$ 的一个 PTAS，如果对任意的 $r > 0$，任意 $\varepsilon > 0$，$A_\varepsilon $ 是 $U_r$ 的一个 $\delta_{r, \varepsilon}$-近似算法，则称PTAS $A$ 关于 $h$ 是**稳定的**。
- PTAS $A$ 是**超稳定（superstable）**的，如果 $\delta_{r, \varepsilon} \leq f(\varepsilon) \cdot g(r)$，其中
  - $f,g$  的定义域分别是 $\mathbb{R^{\geq 0}}$ 和 $\mathbb{R}^{+}$，
  - $\lim\limits_{\varepsilon \to 0}f(\varepsilon) = 0$。
- *观察到，若 $A$ 是优化问题 $U$ 的超稳定PTSA，则它也是任意 $U_r$ 的PTSA。*



---
# 对偶近似算法（Dual Approximation Algorithm）

- $U = (\Sigma_I, \Sigma_O, L, L_I,\mathcal{M}, cost, goal)$ 是一个优化问题。$U$ 的一个**限制距离函数（constraint distance function）** 是一个函数 $h : L_I \times \Sigma_O^\star \to \mathbb{R}^{\geq 0}$ 满足
  - $\forall S \in \mathcal{M}(x), h(x, S) = 0$，
  - $\forall S \in \mathcal{M}(x), h(x, S) > 0$，
  - $h$ 是多项式时间可计算的。
- 对任意的 $\varepsilon \in \mathbb{R}^+$，任意 $x \in L_I$，$\mathcal{M}_{\varepsilon}^h(x) = \{S \in \Sigma_O^\star\ | h(x, S) \leq \varepsilon\}$ 是 $\mathcal{M(x)}$ 对 $h$ 的 $\varepsilon\textbf{-ball}$。
- $U$ 的一个优化算法 $A$ 称为 **$h$-dual** $\varepsilon$-近似算法，如果对任意的 $x \in L_I$，
  - $A(x) \in \mathcal{M}_\varepsilon^{h}(x)$，
  - $cost(A(x)) \geq Opt_U(x)$ 当 $goal = maximum$，$cost(A(x)) \leq Opt_U(x) $ 当 $goal = minimum$。
- 一个算法 $A$ 称为 $U$ 的 **$h$-dual 多项式时间近似方案（h-dual PTAS）**，如果
  - $\forall (x, \varepsilon) \in L_I \times \mathbb{R}^+, A(x, \varepsilon) \in \mathcal{M}_{\varepsilon}^h(x)$，
  - $cost(A(x)) \geq Opt_U(x)$ 当 $goal = maximum$，$cost(A(x)) \leq Opt_U(x) $ 当 $goal = minimum$，
  - $Time_A(x, \varepsilon^{-1})$ 被一个 $|x|$ 的多项式函数界定。
- 同上，同时被 $|x|,\varepsilon^{-1}$ 的多项式函数界定，叫 $h$-dual FPTAS。 
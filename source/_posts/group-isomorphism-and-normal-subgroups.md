---
title: 群同态基本定理与正规子群
date: 2021-03-11 01:50:32
categories: problem-solving
mathjax: true

---

---

# 同构 Isomorphisms

## 定义

群$(G, \cdot )$ 和 $(H, \circ)$ **同构（isomorphic）**，如果存在一个双射 $\phi: G \rightarrow H$ 且满足

$$\forall a, b \in G, \phi(a \cdot b) = \phi(a) \circ \phi(b)$$

记作 $G \cong H$。映射 $\phi$ 称为**同构（isomorphism）**。

<!--more -->

**定理 9.6.** $\phi: G \rightarrow H$ 是两个群上的同构，则有

1. $\phi^{-1}: H \rightarrow G$ 也是一个同构。
2. $|G| = |H|$
3. $G$ 是阿贝尔群 $\Rightarrow$ $H$ 是阿贝尔群。
4. $G$ 是循环群 $\Rightarrow$ $H$ 是循环群。
5.  $G$有一个 $n$ 阶子群 $\Rightarrow$ $H$ 有一个 $n$ 阶子群。

**定理 9.7.** 所有无限循环群和 $\mathbb{Z}$ 同构。

**定理 9.8.** 所有 $n$ 阶循环群和 $\mathbb{Z}_{n}$ 同构。

**推论 9.9.** $G$ 是一个 $p$ 阶群，$p$ 是一个质数，则 $G$ 同构于 $\mathbb{Z}_{p}$。

**定理 9.10.** 群上的同构形成了所有群的类型的等价关系。


### 凯利定理 Cayley's Theorem

**定理 9.12. Cayley** 每个群都同构于一个置换群。

## 直积 Direct Product

### 外直积 External Direct Products

**命题 9.13.** $(G, \cdot), (H, \circ)$ 是两个群，$(g, h) \in G \times H, g \in G, h \in H$, 定义 $G \times H$ 上的二元运算：$(g_1, h_1)(g_2, h_2) = (g_1 \cdot g_2, h_1 \circ h_2)$，是一个群。

群 $G \times H$ 叫做 $G$ 和 $H$ 的**外直积（external direct product）**。

**定理 9.17.** $(g, h) \in G \times H$，$g, h$ 都有有限的序数 $r, s$，则 $(g,h)$ 的序数是 $r$ 和 $s$ 的最小公倍数。

**定理 9.21.** $\mathbb{Z}_m \times \mathbb{Z}_n \cong \mathbb{Z}_mn \Leftrightarrow gcd(m,n) = 1$

### 内直积 Internal Direct Products

如果群 $G$ 的两个子群 $H$ 和 $K$ 满足以下条件：

- $ G= HK = \{ hk: h \in H, k \in K \}$
- $H \cap K = \{ e \}$
- $\forall k \in K, \forall h \in H, hk = kh$

则 $G$ 叫做 $H$ 和 $K$ 的**直积（internal direct product）**。

**定理 9.27.** $G$ 是 $H$ 和 $K$ 的内直积 $\Rightarrow G \cong H \times K$。
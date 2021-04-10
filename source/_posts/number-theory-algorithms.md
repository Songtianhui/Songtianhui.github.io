---
title: 问题求解笔记-数论算法
date: 2021-04-08 09:52:18
categories: problem-solving
mathjax: true
---

---

# 数论算法

**定理 31.2.** 如果任意整数 $a$ 和 $b$ 都不为 $0$，则 $gcd(a, b)$ 是 $a$ 与 $b$ 的线性组合集 $\{ ax + by : x, y \in \mathbb{Z} \}$ 中的最小正元素。

**推论 31.3.** 任意整数 $a$ 和 $b$，$d | a \wedge d|b \Rightarrow d | gcd(a,b)$。

**推论 31.4** 对所有整数 $a,b$ 及任意非负整数 $n$，有 $$gcd(an,bn) = n~gcd(a,b)$$。

**推论 31.5.** 对所有正整数 $a,b,n$，$n | ab \wedge gcd(a, n) = 1 \Rightarrow n | b$。

**定理 31.6.** 对所有正整数 $a,b,p$，$gcd(a, p ) = 1 \wedge gcd(b, p) = 1 \Rightarrow gcd(ab, p) = 1$。

**定理 31.7.** 对所有的素数 $p$ 和所有整数 $a,b$， $p | ab \Rightarrow p |a \vee p | b$。

**定理 31.8.**（唯一因子分解定理）合数 $a$ 的素因子分解是唯一的。

<!--more -->

**定理 31.9** $\forall a, b, gcd(a, b) = gcd(b, a ~mod ~b)$.

## 欧几里得算法

![ECULID](euclid.png "eculid")

### 欧几里得算法的运行时间

**引理 31.10.** 如果 $a > b \geq 1$ 并且 ECULID$(a,b)$ 执行了 $k \geq 1$ 次递归调用，则 $a \geq F_{k+2}, b \geq F_{k+1}$。

**引理 31.11.**（Lame引理）对任意整数 $k \geq 1$，如果 $a > b \geq 1$，且 $b < F_{k+1}$，则 EUCLID$(a,b)$ 的递归调用次数少于 $k$ 次。

### 扩展欧几里得算法

![EXT-ECULID](extgcd.png "ext-eculid")

- 递归调用次数为 $O(\lg{b})$。

## 模运算

- **欧拉函数**：$$\phi(n) = n \prod\limits_{p\text{是素数且}p|n} (1 - \dfrac{1}{p})$$

- $\phi(n) > \dfrac{n}{e^\gamma \ln{\ln{n}} + \dfrac{3}{\ln{\ln{n}}}}$

  

  

  **定理31.15.** （拉格朗日定理）：如果 $(S, \oplus)$ 是一个有限群，$(S', \oplus )$ 是 $(S,\oplus)$ 的一个子群，则 $|S'|$ 是 $|S|$ 的一个约数。（我觉得比TJ上讲的通俗易懂得多。。。）

  **推论 31.16.** 如果 $S'$ 是有限群 $S$ 的真子群，则 $|S' | \leq |S| / 2$。

**定理 31.17.** 对任意有限群 $(S, \oplus)$ 和任意 $a \in S$，一个元素的阶等于它所生成的子群的规模，即 $ord(a) = |\langle a \rangle|$。

**推论 31.18.** 序列 $a^{(1)}, a^{(2)}, ...$是周期序列，其周期为 $t = ord(a)$，即 $a^{(i)} = ^{(j)} \Leftrightarrow i \equiv j~ (\text{mod }t)$。

**推论 31.19.** 如果 $(S, \oplus)$ 是具有单位元的有限群，则对所有 $a \in S$，$a^{(|S|)} = e$。
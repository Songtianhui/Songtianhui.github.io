---
title: algorithms-of-number-theory
date: 2021-04-08 07:50:12
categories: problem-solving
mathjax: true
tags:
---

---

# 数论算法

**定理 31.2.** 如果任意整数 $a$ 和 $b$ 都不为 $0$，则 $gcd(a, b)$ 是 $a$ 与 $b$ 的线性组合集 $\{ ax + by : x, y \in \mathbb{Z} \}$ 中的最小正元素。

**推论 31.3.** 任意整数 $a$ 和 $b$，$d | a \wedge d|b \Rightarrow d | gcd(a,b)$。

**推论 31.4** 对所有整数 $a,b$ 及任意非负整数 $n$，有 $$gcd(an,bn) = n~gcd(a,b)$$。

**推论 31.5.** 对所有正整数 $a,b,n$，$n | ab \wedge gcd(a, n) = 1 \Rightarrow n | b$。
---
title: leetcode 刷题笔记
date: 2021-07-05 23:38:08
tags:
---

问求上完了，依然不能放松对数据结构和算法的训练，要坚持不懈的刷题。着重对一些经典题型和方法进行总结。

<!--more -->

# 剑指offer系列

## 04. 二维数组中查找

> 在一个 n * m 的二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。请完成一个高效的函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。

原来是想的二分查找但是思路很明显是错的。只要从一个角落开始，每个元素比较，如果不一样就超朝另外两个方向移动。

其实也是一个压缩解空间的思想，比如我从右上角开始，当前元素比target大，说明在该元素下面所有的元素都不符合，只能向左移动一位。

注意边界条件`matrix = []`。复杂度 $O(m + n)$。

``` c++
class Solution {
public:
    bool findNumberIn2DArray(vector<vector<int>>& matrix, int target) {
        int len1 = matrix.size();
        if (len1 == 0) return false;
        int len2 = matrix[0].size();
        int h = 0, v = len2 - 1;
        while (h < len1 && v >= 0) {
            int p = matrix[h][v];
            if (p == target) return true;
            if (p > target) {
                v--;
                continue;
            }
            if (p < target) {
                h++;
                continue;
            }
        }
        return false;
    }
};
```


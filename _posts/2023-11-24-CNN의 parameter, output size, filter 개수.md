---
title: CNN의 parameter, output size, filter 개수
# author:
#   name: jouhy
#   link: https://github.com/univdev
date: 2023-11-24 19:00:00 +0900
categories: [DL, DL Basic]
tags: [CNN]     # TAG names should always be lowercase
math: true
# comments: true
# mermaid: true
---

### **Parameter 개수**
$$
((input channels) * (filter size)^2 + 1) * (output channels)
$$

### **output size**
$$
\frac{(input size) - (filter size) + 2(padding size)}{stride} + 1
$$

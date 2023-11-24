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
i = input channels   
k = filter size   
o = output channels   
$$
(i * k^2 + 1) * o
$$   

### **output size**
i = input size   
k = filter size   
p = padding size   
s = stride   
$$
\frac{i - k + 2p}{s} + 1
$$   

### **filter 개수**
output channels

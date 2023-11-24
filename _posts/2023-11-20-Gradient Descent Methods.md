---
title: Gradient Descent Methods
# author:
#   name: jouhy
#   link: https://github.com/univdev
date: 2023-11-20 21:00:00 +0900
categories: [DL, DL Basic]
tags: [Gradient Descent Methods, SGD,Momentum, RMSprop, Adam]     # TAG names should always be lowercase
math: true
# comments: true
# mermaid: true
---

### **(stochastic) gradient descent (SGD)**
- learning rate를 적절히 잡는 것이 어려움   
$$
W_{t+q} \gets W_t - \eta g_t
$$

### **Momentum**
- 이전에 업데이트 됐던 방향에 영향을 받아 다음 업데이트를 진행
- 한번 흘러간 gradient는 어느정도 유지시켜주기 때문에 gradient가 많이 변화해도 어느정도 학습효과를 보장함   
$$
a_{t+1} \gets \beta a_t +g_t
$$   
$$
W_{t+q} \gets W_t - \eta a_{t+1}
$$

### **RMSprop**
- 많이 사용됨
- 논문을 통해 제안된 것은 아니고, 실험에 의해 잘 돼서 제안됨.
$$
G_{t} = \gamma G_{t-1} + (1-\gamma) g_t^2
$$   
$$
W_{t+q} = W_t - \frac\eta {G_t+\epsilon}g_t
$$

### **Adam**
- Adaptive Moment Estimation
- momentum정보와 gradient 크기에 따라서 adative하게 바꾸는 방법을 합친 것   
_B1: momentum을 얼마나 유지시킬지   
B2: gradient squares에 대한 ema정보   
에타: learning rate   
입실론: division by 0 를 막기 위해, 10^-7이 기본인데 이 값을 잘 바꿔주는 것이 practical하게 중요함_   
$$
m_{t} = \beta m_{t-1} + (1-\beta _1) g_t
$$   
$$
v_{t} = \beta v_{t-1} + (1-\beta _2) g_t^2
$$   
$$
W_{t+q} = W_t - \frac{\eta}{\sqrt{v_t+\epsilon}}\frac{\sqrt{1-\beta _2^t}}{1-\beta _1^t}m_t
$$

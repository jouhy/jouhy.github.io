---
title: Two-stage detector vs One-stage detector
# author:
#   name: jouhy
#   link: https://github.com/univdev
date: 2023-12-01 18:30:00 +0900
categories: [DL, CV]
tags: [CNN, two-stage detector, one-stage detector]
math: true
# comments: true
# mermaid: true
toc: false
---

- single stage는 roi pooling이 없다
    - 모든 영역에서 loss 발생
- positive는 굉장히 적은데 easy negative가 많아서 class imbalance를 발생시켜 학습에 방해가 된다   
    - background에 있는 negative anchor boxes의 개수가 positive anchor boxes들보다 훨씬 많다.   
$\rightarrow$ Focal loss를 통해 해결

## Focal loss
![image](https://github.com/jouhy/jouhy.github.io/assets/86566696/dc0408fa-1c6a-4d4e-8a20-26f2c666ec49)
_focal loss_
- cross entropy와 유사하지만, $\gamma$ 를 조정
    - $\gamma$ 를 키워 정답에 가까운 것의 loss를 더 낮게 만들고, 오답일 떄 더 작은 loss를 갖게 한다
    - 오답의 gradient가 더 sharp해지고 정답에 가까울 때 0에 가까워진다
- 잘못 판별된 것들에 더 강한 Weight을 준다    
$\rightarrow$ easy negative의 경우, 정답에 가까울 확률이 더 높기 때문에 많은 easy negative의 영향을 줄여줄 수 있다
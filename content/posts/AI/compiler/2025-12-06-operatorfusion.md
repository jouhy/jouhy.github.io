---
title: "[AI 컴파일러] Operator Fusion 기법 with TVM"
# author:
#   name: jouhy
#   link: https://github.com/univdev
date: "2025-12-06 12:00:00 +0900"
layout: "post"
categories: ["AI", "Compiler"]
tags: ["AI", "컴파일러", "TVM", "딥러닝컴파일러", "최적화", "OperatorFusion"]     # TAG names should always be lowercase
# toc: false # 목차
math: true # LaTeX 문법으로 작성한 수식을  MathJax나 KaTeX와 같은 수학 렌더러로 렌더링
# comments: false # 댓글 기능 비활성화
# mermaid: true # Mermaid 문법을 사용한 다이어그램(플로우차트, 시퀀스 다이어그램 등)을 렌더링할
---

# Operator Fusion
여러 개의 작은 연사자들을 하나의 큰 커널(kernel) 함수로 합치는 최적화 기법

## 왜 operator Fusion을 하는 가?
1. 메모리 접근 횟수 감소
2. 커널 호출 오버헤드 감소
3. 병렬 최적화 : SIMD, Tensor Core, NPU MAC 배열 등으로 더 최적화해 실행 가능
4. Low-precision 최적화 용이 : 연산자를 합친 상태가 더 quantization-friendly함

- Fusion 전
    `A + B -> Temp -> ReLU(Temp) -> C`  
    1. GPU가 메모리에서 A, B를 읽음
    2. 더하기 연산 수행
    3. 결과값을 VRAM에 씀
    4. VRAM에서 다시 읽음
    5. ReLU 수행 후 결과값 C를 VRAM에 씀
- Fusion 후
    `Fused_Func(A, B) -> C`  
    1. GPU가 A,B를 읽음
    2. 더하기 연산을 수행하고, 결과를 레지스터(캐시)에 잠시 저장
    3. 저장한 값을 바로 ReLU 수행
    4. 결과값 C를 VRAM에 씀

=> Memory I/O 감소 & Kernel Launch Overhead 감소

## TVM에서 Fusion 전략

<img width="456" height="319" alt="Image" src="https://github.com/user-attachments/assets/3846d1dc-4081-4581-8720-f9ebac453c8f" />  

1. Injective(일대일 매핑) : element-wise 연산 (addition, subtraction, scale, ReLU)  
    -> injective operation끼리 서로 쉽게 fuse 가능
2. Reduction(축소) : 여러 element 들간의 연산 (e.g., sum)  
    -> injective operators 마지막에 fuse 가능
3. Complex-out-fusable(복잡한 연산) : 복잡한 연산 (e.g., Conv2D)
    -> Complex-out-fusable operator 뒤에 injective operator가 fuse 가능
4. Opaque(fuse할 수 없는 연산) : (e.g., sort)


## 주로 Fuse되는 연산들
- Conv + BatchNorm
- Conv + ReLU
- Conv + BN + ReLU
- Conv + Add + ReLU (Residual block 패턴)
- MatMul + Add
- GEMM + Activation  
Transformer에서 자주 일어나는 fusion
- QKV Linear fusion
- Add + LayerNorm
- Attention Softmax + Mask
- GELU + Bias Add

## 예시1 Conv + BN
BN 공식:  

```
y = gamma * (x - mean) / sqrt(var + eps) + beta
```

=> Conv + BN  
새 weight:
```
W' = W * gamma / sqrt(var + eps)
```

새 bias:
```
b' = beta + (b - mean) * gamma / sqrt(var + eps)
```



출처
- https://operatingsystems.tistory.com/entry/TVM-An-Automated-End-to-End-Optimizing-Compiler-for-Deep-Learning
- https://computing-jhson.tistory.com/45#google_vignette
- https://github.com/andersy005/tvm-in-action?tab=readme-ov-file

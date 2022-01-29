#lang sicp

; Observe that our model of evaluation allows for combinations whose operators
; are compound expressions.

; Description: we decide to use `-` or `+` based on the value of `b`
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

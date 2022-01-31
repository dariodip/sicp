#lang sicp

; Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using
; applicative-order evaluation or normal-order evaluation. He defines the following two procedures:
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

; Then he evaluates the expression
(test 0 (p))

; Solution:
;
; Normal order evaluation (a.k.a "fully expand and then reduce")
; the operand `(p)` will not be evaluated until it is needed by some primitive operations
; and the expression will return `0`
;
; Applicative order evaluation:
; the operand `y` will not be evaluated and `(p)` will bring to an infinite recursion

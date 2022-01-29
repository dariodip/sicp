#lang sicp

; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the
; two larger numbers.

(define (square x) (* x x))

(define (sum-of-greatest x y z)
  (+
   (if (> x y) (square x) (square y))
   (if (> y z) (square y) (square z))))

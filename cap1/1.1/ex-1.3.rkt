#lang sicp

; Define a procedure that takes three numbers as arguments and returns the sum of the squares of the
; two larger numbers.

(define (square x) (* x x))

(define (sum-of-greatest x y z)
  (+
   (square (if (> x y) x y))
   (square (if (> y z) y z))))

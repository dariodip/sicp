; Library of common functions for solving exercises

#lang sicp

(define (square x) (* x x))

(define (abs x)
  (if (< x 0) (- x)
      x))

(define (>= x y)
  (not (< x y)))

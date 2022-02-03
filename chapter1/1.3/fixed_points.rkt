#lang sicp

; a number x is a fixed point of a function f if f(x) = x
; for some functions f we can locate x with an initial guess and applying f repeatedly
; f(x), f(f(x)), f(f(f(x))) ... until the value does not change very much

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

; computing the square root of some number x requires finding y such that y^2 = x
; putting the latter in the form y = x/y, we recognize that we are looking for a fixed
; point of the function y |-> x/y

(define (sqrt x)
  (fixed-point (lambda (y) (average (y (/ x y))))
               1.0))

(define (average x y) (/ (+ x y) 2))

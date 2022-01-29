#lang sicp

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else then-clause)))

(define (square x) (* x x))

(define (good-enough? guess x)
  	(< (abs (- (square guess) x)) 0.001))

(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  	(average guess (/ x guess)))

(define (sqrt-iter guess x)
  	(new-if (good-enough? guess x)
                guess
                (sqrt-iter (improve guess x) x)))

(define (sqrt x) (sqrt-iter 1.0 x))

; The program loops forever because the `new-if` procedure uses
; *Normal order evaluation*, so the procedure `sqrt-iter` will call itself
; before evaluating the goodness of `guess`
#lang sicp

(define (square x) (* x x))

(define (cube x) (* x x x))

(define (good-enough? guess x)
  	(< (abs (- (cube guess) x)) 0.001))

(define (improve x y)
  (/ (+ (/ x (square y)) (* 2 y)) 3))

(define (qbrt-iter guess x)
  	(if (good-enough? guess x)
            	    guess
                    (qbrt-iter (improve x guess) x)))

(define (qbrt x) (qbrt-iter 1.0 x))

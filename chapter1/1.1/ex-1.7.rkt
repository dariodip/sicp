#lang sicp

(define (square x) (* x x))

(define (good-enough? guess prev)
  	(< (abs (- guess prev)) 0.001))


(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  	(average guess (/ x guess)))

(define (sqrt-iter guess prev-guess x)
  	(if (good-enough? guess prev-guess)
            	    guess
                    (sqrt-iter (improve guess x) guess x)))

(define (sqrt x) (sqrt-iter 1.0 0 x))

; Exercise 18
#lang sicp

; Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative process
; for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number
; of steps.

(define (double n) (+ n n))
(define (halve n) (/ n 2))

; a * 2b = 2a * b

(define (prod a b)
  (fast-prod a b 0))

(define (fast-prod a b acc)
  (cond ((= b 0) acc)
        ((even? b) (fast-prod a (halve b) (+ (double a) (double a))))
        (else (fast-prod a (- b 1) (+ a a)))))

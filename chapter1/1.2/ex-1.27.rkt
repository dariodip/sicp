; Exercise 27
#lang sicp

; Demonstrate that the Carmichael numbers listed in footnote
; 47 (561, 1105, 1729, 2465, 2821, and 6601) really do fool the Fermat test.
; That is, write a procedure that takes an integer n and tests whether an is
; congruent to a modulo n for every a < n,and try your procedure on the given
; Carmichael numbers.

(define (pick-a-prime n)
  (cond
    ((= n 1) 561)
    ((= n 2) 1105)
    ((= n 3) 1729)
    ((= n 4) 2465)
    ((= n 5) 2821)
    ((= n 6) 6601)
    (else 1))
  )

(define (run-tests n)
  (cond ((= (pick-a-prime n) 1)
         (display "done")
         (newline))
        (else
         (test-carmichael-number (pick-a-prime n))
         (run-tests (- n 1)))))

(define (test-carmichael-number n)
  (carmichael-test-iteration 1 n true))

(define (carmichael-test-iteration a n is-it?)
  (cond ((= a n)
         (display n)
         (display ": ")
         (display is-it?)
         (newline))
        (else
         (carmichael-test-iteration (+ a 1) n (and is-it? (fermat-test a n))))))

(define (fermat-test a n)
  (= (expmod a n n) a))

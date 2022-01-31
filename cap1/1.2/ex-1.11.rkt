#lang sicp

; f(n) = n if n < 3
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3

(define (f n)
  (cond ((< n 3) n)
        (else (+
               (f (- n 1))
               (* 2 (f (- n 2)))
               (* 3 (f (- n 3)))))))
; ---

(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
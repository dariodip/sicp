#lang sicp

; f(n) = n if n < 3
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3

; recursive

(define (f n)
  (cond ((< n 3) n)
        (else (+
               (f (- n 1))
               (* 2 (f (- n 2)))
               (* 3 (f (- n 3)))))))

; iterative
; f(n) = n if n < 3
; f(n) = f(n-1) + 2f(n-2) + 3f(n-3) if n >= 3
; starting from a, b and c initially 0, 1 and 2
; in the next step we'll have
; a = b
; b = c
; c = c + 2b + 3a

(define (f2 n)
  (if (< n 3)
      n
      (f-iter 0 1 2 (- n 2))))

(define (f-iter a b c count)
  (if (= count 0)
      c
      (f-iter b c (+ c (* 2 b) (* 3 a)) (- count 1))))

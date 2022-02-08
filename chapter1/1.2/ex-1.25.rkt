; Exercise 25
#lang sicp

; Alyssa P. Hacker complains that we went to a lot of extra work in writing
; expmod. After all, she says, since we already know how to compute
; exponentials, we could have simply written
;
; (define (expmod base exp m)
;   (remainder (fast-expt base exp) m))
;
; Is she correct? Would this procedure serve as well for our fast prime tester?
; Explain.

; (define (expmod base exp m)
;   (cond ((= exp 0) 1)
;         ((even? exp)
;          (remainder (square (expmod base (/ exp 2) m))
;                     m))
;         (else
;          (remainder (* base (expmod base (- exp 1) m))
;                     m))))

; This algorithm works correctly as the other one, but it requires to full calculate `fast-exp` for
; a number. The resulting number is bigger than the one calculated by the other algorithm that always
; gets smaller numbers.

# Solution for exercise 1.1

```scheme
10
; 10
(+ 5 3 4)
; 12
(- 9 1)
; 8
(/ 6 2)
; 3
(+ (* 2 4) (- 4 6))
; (+ 8 -2) => 6
(define a 3)
; null but the value of a is 3
(define b (+ a 1))
; null but the value of b is 4
(+ a b (* a b))
; (+ a b (* 3 4)) => (+ a b 12) => (+ 3 4 12) => 19
(= a b)
; #f
(if (and (> b a) (< b (* a b)))
    b
    a)
; (if (and #t (< b (* a b)))
;     b
;     a)
; => (if #t b a)
; => (if #t 4 3)
; => 4
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
; (cond (#f 6)
;       ((= b 4) (+ 6 7 a))
;       (else 25))
; => (cond (#f 6)
;       (#t (+ 6 7 a))
;       (else 25))
; => (cond (#f 6)
;       (#t 16)
;       (else 25))
; => 16
(+ 2 (if (> b a) b a))
; (+ 2 (if #t b a))
; => (+ 2 b)
; => 6
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
; (* (cond (#f a)
;          (#t b)
;          (else -1))
;    (+ a 1))
; => (* (cond (#f a)
;          (#t 4)
;          (else -1))
;    (+ a 1))
; => (* (cond (#f a)
;          (#t 4)
;          (else -1))
;    4)
; => (* 4 4)
; => 16
```
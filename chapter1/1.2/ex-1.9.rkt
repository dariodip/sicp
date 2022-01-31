#lang sicp

(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

; solution
; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9
; this process is linear recursive

(define (sum a b)
  (if (= a 0)
      b
      (sum (dec a) (inc b))))

; solution
; (sum 4 5)
; (sum (dec 4) (inc 5))
; (sum 3 6)
; (sum 2 7)
; (sum 1 8)
; 9
; this process is linear iterative

; Exercise 12
#lang sicp

; Write a procedure that computes elements of Pascal's triangle by means of a recursive process.
;     1
;    1 1
;   1 2 1
;  1 3 3 1
; 1 4 6 4 1
; pascal-number(x, y) = 1 if y = 1 or x = y
;                     = pascal-number(x, y-1) + pascal-number(x-1, y-1)

(define (pascal row col)
  (cond (< row col) (error "row < col" row col)
        ((or (= 1 col) (= row col)) 1)
        (else (+ (pascal (- row 1) col)
                 (pascal (- row 1) (- col 1))))))

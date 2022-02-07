; Exercise 20
#lang sicp

; The process that a procedure generates is of course dependent on the rules used by the interpreter.
; As an example, consider the iterative gcd procedure given below.
; Suppose we were to interpret this procedure using normal-order evaluation,
; as discussed in section 1.1.5. (The normal-order-evaluation rule for if is described in exercise 1.5.).
; Using the substitution method (for normal order), illustrate the process generated in evaluating (gcd 206 40)
; and indicate the remainder operations that are actually performed.
; How many remainder operations are actually performed in the normal-order evaluation of (gcd 206 40)?
; In the applicative-order evaluation?
;
; Iterative procedure for calculating GCD of two numbers
;
; moved to common for reuse by other parts
;
; (define (gcd a b)
;  (if (= b 0)
;      a
;      (gcd b (remainder a b))))
;
; Normal order evaluation:
; (gcd 206 40) ; a = 206, b = 40

; (if (= 40 0) 0)
; (gcd 40 (remainder 206 40))

; a = 40, b = (remainder 206 40)
; (if (= (remainder 206 40) 0) a) -> (if (= 6 0) a) ; +1
; (gcd (remainder 206 40)
;      (remainder 40 (remainder (206 40))))

; a = (remainder 206 40), b = (remainder 40 (remainder (206 40)))
; (if (= (remainder 40 (reaminder 206 40)) 0) a) -> (if (= 4 0) a) ; +2 = 3
; (gcd (remainder 40 (remainder (206 40)))
;      (remainder (remainder 206 40) (remainder 40 (remainder (206 40)))))
;
; a = (remainder 40 (remainder (206 40))
; b = (remainder (remainder 206 40) (remainder 40 (remainder (206 40))))
; (if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0) a) ->
; (if (= 2 0) a) -> ; +4 = 7
; (gcd
;  (remainder (remainder 206 40) (remainder 40 (remainder (206 40))))
;  (remainder (remainder 40 (remainder (206 40)))
;             (remainder (remainder 206 40) (remainder 40 (remainder (206 40))))))

; a = (remainder (remainder 206 40) (remainder 40 (remainder (206 40))))
; b = (remainder (remainder 40 (remainder (206 40))) (remainder (remainder 206 40) (remainder 40 (remainder (206 40)))))

; (if (= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) -> evaluating to 0
;        (remainder
;             (remainder 206 40)
;             (remainder 40 (remainder 206 40)))) -> true +11 = 14


; Applicative order of evaluation:
; (gcd 206 40)
; (if (= 40 0) 206)
; (gcd 40 (remainder 206 40)) -> (gcd 40 6)
;
; (if (= 6 0) 40)
; (gcd 6 (remainder 40 6)) -> (gcd 6 4)
;
; (if (= 4 0) 6)
; (gcd 4 (remainder 6 4)) -> (gcd 4 2)
;
; (if (= 2 0) 4)
; (gcd 2 (remainder 6 2)) -> (gcd 2 0)
;
;(if (= 0 0) 2) -> 2
;
; Total = 4

#lang sicp

(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (average-damping f)
  (lambda (x) (average x (f x))))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point (average-damping (lambda (y) (/ x y)))))

; newton's method

(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x)))))

(define dx 0.00001)

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (newton-sqrt x)
  (newtons-method (lambda (y) (- (square y) x))
                  1.0))
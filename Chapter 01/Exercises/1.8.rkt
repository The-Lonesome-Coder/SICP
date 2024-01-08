#lang sicp

(define (cube number)
    (* number number number))

(define (good-enough? previous-guess guess)
    (< (abs (/ (- guess previous-guess) guess)) 0.00000000001))

(define (improve guess number)
    (/ (+ (/ number (* guess guess)) (* 2 guess)) 3))

(define (cube-root-iter guess number)
    (if (good-enough? (improve guess number) guess)
        guess
        (cube-root-iter (improve guess number) number)))

(define (cube-root number)
    (cube-root-iter 1.0 number))

(cube-root 28)
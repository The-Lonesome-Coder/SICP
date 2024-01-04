#lang sicp

(define (square number)
    (* number number))

(define (sum-of-square num1 num2)
    (+ (square num1) (square num2)))

(define (sum-max-two num1 num2 num3)
    (cond ((and (<= num1 num2) (<= num1 num3)) (sum-of-square num2 num3))
          ((and (<= num2 num3) (<= num2 num3)) (sum-of-square num1 num3))
          (else (sum-of-square num1 num2))))

(sum-max-two 2 3 4)
(sum-max-two 1 1 1)
(sum-max-two 5 6 2)
(sum-max-two 2 3 8)
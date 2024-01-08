#lang sicp

#|
    - With large number, most of the time computation does not finish. When the guess is getting very
      close to the actual result, because of rounding errors, the function (improve guess number) can't
      improve the guess anymore as the smallest possible difference between guess ^ 2 and number is
      larger than 0.001. This is because with a number of this order of magnitude, the distance between
      two consecutive floating point numbers is larger than 0.01.

    - With small number, the result can be very inaccurate. we can’t have an accurate answer if x is
      smaller than the precision of 0.001.
|#


(define (abs number)
    (if (< number 0)
        (- number)
        number))

(define (average num1 num2)
    (/ (+ num1 num2) 2))

(define (improve guess number)
    (average guess (/ number guess)))

(define (good-enough? previous-guess guess)
    (< (abs (/ (- guess previous-guess) guess)) 0.00000000001))

(define (sqrt-iter guess number)
    (if (good-enough? guess (improve guess number))
        guess
        (sqrt-iter (improve guess number) number)))

(define (sqrt number)
    (sqrt-iter 1.0 number))


(sqrt 123456789012345)
(sqrt 0.00000000123456)
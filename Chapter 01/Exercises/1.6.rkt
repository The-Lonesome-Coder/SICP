#lang sicp

(define (new-if predicate then-clause else-clause)
    (cond (predicate then-clause)
          (else else-clause)))

(define (abs number)
    (if (< number 0)
        (- number)
        number))

(define (average num1 num2)
    (/ (+ num1 num2) 2))

(define (improve guess number)
    (average guess (/ number guess)))

(define (square number)
    (* number number))

(define (good-enough? guess number)
    (< (abs (- (square guess) number)) 0.001))

(define (sqrt-iter guess number)
    (new-if (good-enough? guess number)
            guess
            (sqrt-iter (improve guess number) number)))

(define (sqrt number)
    (sqrt-iter 1.0 number))

(sqrt 9)


#|
    new-if does not use normal order evaluation, it uses applicative order evaluation.
    That is, the interpreter first evaluates the operator and operands and then applies the resulting
    procedure to the resulting arguments. As with Exercise 1.5, this results in an infinite recursion
    because the else-clause is always evaluated, thus calling the procedure again ad infinitum.

    The if statement is a special form and behaves differently. if first evaluates the predicate, and
    then evaluates either the consequent (if the predicate evaluates to #t) or the alternative (if the
    predicate evaluates to #f). This is key difference from new-if -- only one of the two consequent
    expressions get evaluated when using if, while both of the consequent expressions get evaluated
    with new-if.
|#
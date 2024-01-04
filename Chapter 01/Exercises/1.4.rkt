#lang sicp

(define (a-plus-abs-b a b)
    ((if (> b 0) + -) a b))

#|
    The procedure:
    Check whether b > 0, if so, (+ a b), which means a + b; if not, (- a b), which means a - b, but
    due to b is negative (< 0), a - b -> a + b.
|#
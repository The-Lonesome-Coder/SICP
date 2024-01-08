#lang sicp

#|
    Every powerful language has three mechanisms:
    1. Primitive Expression - represents the simplest entities the language is concerned with.
    2. Means of Combination - compound elements are built from simpler ones.
    3. Means of Abstraction - compound elements can be named and manipulated as units.
|#

; -------------------------------------------------------------------------------------------------- ;

; 1.1.1 Expressions - (operator operand operand ...)

(+ 137 349)     ; 486
(- 1000 334)    ; 666
(* 5 99)        ; 495
(/ 10 5)        ; 2
(+ 2.7 10)      ; 12.7

(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))        ; 57

(+  (* 3
        (+ (* 2 4)
            (+ 3 5)))
    (+ (- 10 7)
        6)
)                                                   ; 57

; -------------------------------------------------------------------------------------------------- ;

; 1.1.2 Naming and the Environment

#|
    "define" is the language's simplest means of abstraction, for it allows us to use simple names
    to refer to the results of compound operations.
|#

(define size 2)         ; Define a variable named "size", associate with the value 2
size                    ; Call the variable

(* 5 size)              ; Use the variable, results in 10

(define pi 3.1415926)
(define radius 10)

(* pi (* radius radius))                ; 314.15926

(define circumference (* 2 pi radius))
circumference                           ; 62.831852

; -------------------------------------------------------------------------------------------------- ;

; 1.1.3 Evaluating Combinations

#|
    To evaluate combinations (Applicative-Order Evaluation):
    1. Evaluate the sub-expressions of the combination.
    2. Apply the procedure that is the value of the leftmost sub-expression (the operator) to the
       arguments that are the values of the other sub-expressions (the operands).


    There are so-called special forms that are exceptions to the general evaluation rules (above),
    "define" is one of them. For instance: (define x 3) is not a combination, it has its own evaluation
    rule. The various kinds of expressions (each with its associated evaluation rule) constitute the
    syntax of the programming language.
|#

; -------------------------------------------------------------------------------------------------- ;

; 1.1.4 Compound Procedures

#|
    Some elements must appear in any powerful programming language (so far):
    1. Numbers and arithmetic operations are primitive data and procedures.
    2. Nesting of combinations provides a means of combining operations.
    3. Definitions that associate names with values provide a limited means of abstraction.
|#

#|
    The general form of a procedure definition is:

    (define (<name> <parameters>) <body>)

    name - a symbol to associated with the procedure definition
    parameters - names used within the body of the procedure to refer to the corresponding arguments
                 of the procedure
    body - an expression that will yield the value of the procedure when the parameters are replaced
           by the actual arguments to which the procedure is applied
|#

; A procedure named square, return (number ^ 2)
(define (square number)
    (* number number))

(square 21)                     ; 441
(square (+ 2 5))                ; 49
(square (square 3))             ; 81


; A procedure named sum-of-square, return the sum of two squared number
(define (sum-of-square num1 num2)
    (+ (square num1) (square num2)))

(sum-of-square 3 4)             ; 25

; -------------------------------------------------------------------------------------------------- ;

; 1.1.5 The Substitution Model for Procedure Application

#|
    For compound procedures, the application process is as follow :
    To apply a compound procedure to arguments, evaluate the body of the procedure with each formal
    parameter replaced by the corresponding argument.
|#

; Consider the procedure
(define (f number)
    (sum-of-square (+ number 1) (* number 2)))


; Let's use the substitution model to evaluate the combination
(f 5)

; We replace the formal parameter "number" by the argument 5
(sum-of-square (+ 5 1) (* 5 2))

; The expression will reduce to
(+ (square 6) (square 10))

; Further reduce to
(+ (* 6 6) (* 10 10))

; Finally
(+ 36 100)                  ; 136


#|
    Normal Order Evaluation (fully expand and then reduce):
    1. Substitute operand expressions for parameters until it obtained an expression involving only
       primitive operators
    2. Perform the evaluation
|#

; Normal order evaluation - same result but different process
(f 5)

; Becomes
(sum-of-square (+ 5 1) (* 5 2))

; Then
(+ (square (+ 5 1)) (square (* 5 2)))

; Then
(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))

; Followed by the reductions
(+ (* 6 6) (* 10 10))

; Then
(+ 36 100)                  ; 136


#|
    List uses applicative-order evaluation, partly because of the additional efficiency obtained from
    avoiding multiple evaluations of expressions. Normal-order evaluation becomes much more complicated
    to deal with when leaving the realm of procedures, but it still can be a valuable tool.
|#

; -------------------------------------------------------------------------------------------------- ;

; 1.1.6 Conditional Expressions and Predicates

; Note: "predicate" means an expression whose value is interpreted as either true or false (boolean)

#|
    Case analysis construct:
    Taking different actions in different cases according to the rule.
|#

#|
    Special form 1 - "cond" (stands for conditional)

    (cond (<Predicate 1> <Expression 1>)        ; Evaluate first
          (<Predicate 2> <Expression 2>)        ; If the above is false, then evaluate this
          ...
          (<Predicate n> <Expression n>)        ; Same rule...
          (else <Default>))                     ; Optional "else" clause, returns default value
|#

(define (absolute number)
    (cond ((> number 0) number)                 ; If number > 0, return number
          ((= number 0) 0)                      ; If number == 0, return 0
          ((< number 0) (- number))))           ; If number < 0, return (- number)
                                                ; The minus operator (-), indicates negation
    #|
        Equivalent to C++:

        int absolute( const int number )
        {
            if (number > 0)
            {
                return number;
            }
            else if (number = 0)
            {
                return 0;
            }
            else if (number < 0)
            {
                return -number;
            }
        }
    |#


(define (another-absolute number)
    (cond ((< number 0) (- number))             ; If number < 0, return (- number)
          (else number)))                       ; Default return number

    #|
        Equivalent to C++:

        int another-absolute( const int number )
        {
            if (number < 0)
            {
                return -number;
            }
            else
            {
                return number;
            }
        }
    |#


#|
    Another special form - "if"

    (if <Predicate> <Consequent> <Alternative>)

    To evaluate an if expression, the interpreter starts by evaluating <Predicate> first, if it is
    true, the interpreter then evaluates the <Consequent> and returns its value; otherwise, it evaluates
    the <Alternative> and return its value.

    "if" cannot be used for a sequence of expression, <Consequent> and <Alternative> must be single
    expression.
|#

(define (yet-another-absolute number)
    (if (< number 0) (- number) (number)))      ; If number < 0, return (- number); else return number

    #|
        Equivalent to C++:

        int yet-another-absolute(const int number)
        {
            return (number < 0) ? -number : number
        }
    |#


#|
    Other frequently used logical composition operations are:

    1. (and <Expression 1> ... <Expression n>) (special form):
       The interpreter evaluates <Expression> one at a time, in left-to-right order. If any
       <Expression> evaluates false, the value of the "and" expression is false, and the rest of
       <Expression>'s are not evaluated; if all <Expression> evaluates true, "and" expression is true.

       Equivalent to C++ - <Expression 1> && <Expression 2> && ... && <Expression n>

    2. (or <Expression 1> ... <Expression n>) (special form):
       The interpreter evaluates <Expression> one at a time, in left-to-right order. If any
       <Expression> evaluates to true, the "or" expression is true, the rest are not evaluated. If all
       <Expression> evaluate false, the "or" expression is false.

       Equivalent to C++ - <Expression 1> || <Expression 2> || ... || <Expression n>

    3. (not <Expression>) (ordinary procedure):
       When <Expression> evaluates to false, the "not" expression is true; when <Expression> evaluates
       to true, the "not" expression is false.

       Equivalent to C++ - !<Expression>
|#

(define (>= num1 num2) (or (> num1 num2) (= num1 num2)))

(define (another>= num1 num2) (not (< num1 num2)))

; -------------------------------------------------------------------------------------------------- ;

; 1.1.7 Example: Square Roots by Newton's Method

#|
    To compute square root, the most common way is to use Newton's method of successive approximation.
    Whenever we have a guess "y" for the value of the square root of a number "x", we can perform a
    simple manipulation to get a better guess by averaging "y" with "x / y".
|#

(define (abs number)
    (if (< number 0)
        (- number)
        number))

    #|
        float abs(const float number)
        {
            return (number < 0) ? -number : number;
        }
    |#

(define (average num1 num2)
    (/ (+ num1 num2) 2))

    #|
        float average(const float num1, const float num2)
        {
            return (num1 + num2) / 2;
        }
    |#

(define (improve guess number)
    (average guess (/ number guess)))

    #|
        float improve(const float guess, const float number)
        {
            return average(guess, (number / 2));
        }
    |#

(define (good-enough? guess number)
    (< (abs (- (square guess) number)) 0.001))

    #|
        bool good_enough(const float guess, const float number)
        {
            return abs(square(guess) - number) < 0.001;
        }
    |#

(define (sqrt-iter guess number)
    (if (good-enough? guess number)
        guess
        (sqrt-iter (improve guess number) number)))

    #|
        float sqrt_iter(const float guess, const float number)
        {
            if (good_enough(guess, number))
            {
                return guess;
            }
            else
            {
                sqrt_iter(improve(guess, number), number);
            }
        }
    |#

(define (sqrt number)
    (sqrt-iter 1.0 number))

    #|
        float sqrt(const float number)
        {
            return sqrt_iter(1.0, number);
        }
    |#

(sqrt 2)

; -------------------------------------------------------------------------------------------------- ;

; 1.1.8 Procedures as Black-Box Abstractions

#|
    Decomposition strategy not only simply divide the program into part, it is crucial that each
    procedure accomplishes an identifiable task that can be used as a module in defining other
    procedures. For instance, when we define "good-enough?" in terms of "square", we are able to
    regard "square" as a black-box.

    As far as "good-enough?" is concerned, "square" is not quite a procedure but rather an abstraction
    of a procedure, a so-called procedural abstraction.
|#

#|
    Local names:
    One detail of a procedure's implementation that should not matter to the user of the procedure is
    the implementer's choice of names for the procedure's formal parameters.

    A formal parameter of a procedure has a very special role in the procedure definition, in that it
    does not matter what name the formal parameter has. Such a name is called bound variable, and we
    say that the procedure definition binds its formal parameters.

    The following procedures should not be distinguishable.
|#

(define (sqrt number)
    (* number number))

(define (sqrt x)
    (* x x))


#|
    The previous procedures "improve", "good-enough?", "sqrt-iter" only clutter up the users mind,
    they may not define any other procedure as part of another program to work together with the
    square-root program, because "sqrt" needs it.

    The problem is especially severe in the construction of large systems by many separate programmers.

    For example, in the construction of a large library of numerical procedures, many numerical functions
    are computed as successive approximations and thus might have procedures named good-enough? and
    improve as auxiliary procedures. We could localize the sub-procedures, hiding them inside "sqrt"
    so that "sqrt" could co-exist with other successive approximations, each having its own private
    "good-enough?".

    The below nesting of definitions are called block structure. The procedures that uses the local
    variable "number" is by using a discipline called lexical scoping. By this discipline, we can
    simplify the procedures defined in the block structure so it does not need to add an extra
    arguments for them to use.
|#

(define (sqrt number)
    (define (good-enough? guess)
        (< (abs (- (square guess) number)) 0.00000001))

    (define (improve guess)
        (average guess (/ number guess)))

    (define (sqrt-iter guess)
        (if (good-enough? guess number)
            guess
            (sqrt-iter (improve guess number) number)))

    (sqrt-iter 1.0))
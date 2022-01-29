# 1.1 The elements of Programming

> A powerful programming language is more than just a mean of instructing a computer to perform tasks.

Every poverful language has three mechanisms for accomplishing this:
- **primitive expressions**: they represent the simplest entities the language is concerned with;
- **means of combinations**: by which compound elements are build from simpler ones;
- **means of abstraction**: by which compound elements can be named and manipualted as units.

In programming we deal with: 
- *data*: "stuff" that we want to manipulate;
- *procedures*: description of the rules for manipulating the data.

## Scheme

Scheme is a minimalist dialect of the Lisp family. It consists of small standard core with several tools for language extension.

On a computer terminal we type an *expression* and the interpreter responds by displaying the *result* of its *evaluating* the expression.

Example of expression:
```lisp
486
; => 486
(+ 137 349)
; => 486
```

Expressions like `(+ 137 349)` are called *combinations* and are surrounded by parentheses to denote procedure application.

Lisp uses the *prefix notation* in which the *operator* is placed to the left, followed by the *operands*.

In Scheme we name things with `define`:

```lisp
(define size 2)
```

this causes the interpreter to associate the value `2` with the name `size`, in other words, the name `size` identifies a *variable* whose *value* is `2`.
`define` is a *means of abstraction*, because it allows us to use the simple names to refer to the results of compound operations.

The mapping between *variables* and *values* are stored in a memory called *global environment*.

## Evaluating Combinations
Evaluating a combination, the interpreter is following a recursive procedure:
1. Evaluate the subexpressions of the combination;
2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).

For example, for evaluating: 
```lisp
(* (+ 2 (* 4 6))
   (+ 3 5 7)) 
```
we ends up with four different combinations: `(+ 3 5 7)`, `(* 4 6)`, `(+ 2 (*4 6))` and `(* (+ 2 (* 4 6)) (+ 3 5 7))`. This process can be depict with a picture having the form of a tree where each combination is represented by a node with branches corresponding to the *operator* and the *operands* of the *combination* stemming for it. The terminal nodes (leaves) represent either operators or numbers. 
Viewing evaluation in terms of the tree, we can image that the values of the operands *percolate upwards*, starting from the leaves and then combining at higher or higher levels.

When we need to evaluate primitive expressions we can stipulate that:
- the values of numbers are the numbers that they name;
- the values of built-in operators are the machine instruction sequences that carry to the corresponding operations;
- the values of the names are the objects associated with those names in the environment.

### Special forms
Expressions like `(define x 3)` are called *special forms* because it does not apply `define` to two arguments, but associates the name `x` to the value `3`.
Each special form has its own evaluation rule.

## Compound procedures

*Procedure definition* is a powerful abstraction technique by which a compound operation can be given a name and the referred to as a unit. 
The general form of a procedure definition is:
```lisp
(define (<name> <formal parameters>) <body>)
```
- The `<name>` is a symbol to be associated with the procedure definition in the environment. 
- The `<formal parameters>` are the names used withing the body of the procedure to refer to the corresponding arguments of the procedure;
- The `<body>` is an expression that will yield the value of the procedure application when the formal parameters are replace by the actual arguments to which the procedure is applied.

After defining a procedure we can use it: `(<name> <param 1> <param 2> ... <param n>)` and inside other *procedure definitions*.

## The substitution model for procedure application

To evaluate a combination whose operator names a compound procedure, the interpreter evaluates the elements of the combination and applies the procedure to the arguments. This mechanism is built into the interpreter.

For compound procedures the application process is as follows:
- To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument. For example, given the following compound procedure:
```lisp
(define (square x) (* x x))

(define (sum-of-squares x y) (+ (square x) (square y)))

(define (f a)
    (sum-of-squares (+ a 1) (* a 2)))
```
the substitution model will operate that way:
```lisp
(f 5)
```
then we will retrieve the body of `f`:
```lisp
(sum of squares (+ 5 1) (* 5 2))
```
then do the same with `sum-of-square`:
```lisp
(+ (square 6) (square 10))
```
and finally we do the same with `square`:
```lisp
(+ (* 6 6) (* 10 10))
```
Then reduce to:
```lisp
(+ 36 100)
```
and eventually to:
```lisp
136
```

This process is called the *substitution model* for procedure application. 
It is worth noting that:
- The purpose of the substitution is to help us thing about procedure application, not to provide a description of how the interpreter really works. Interpreters do not evaluate procedure applications by manipulating the text of a procedure to substitute values for the format parameters;
- The substitution model is only one of the models that interpreters use.
  
### Applicative Order vs Normal Order

The substitution model of *"evaluate the arguments and then appy"* just described implies that the interpreter first evaluates the operator and the operands and then applies the resulting procedure and is called **Applicative Order**.

An alternative evaluation model (*"Fully expand and then reduce"*), called **Normal-Order evaluation**, would not evaluate the operands until their values were needed. Instead it would first substitute operand expressions for parameters until it obtained an expression involving only primitive operators, and would then perform the evaluation. 
In that case the evaluation of `(f 5)` would be:
```lisp
(sum-of-squares (+ 5 1) (* 5 2))
```
Then would resolve `sum-of-squares`:
```lisp
(+ (square (+ 5 1)) (square (* 5 2)))
```
Then would resolve `square`:
```lisp
(+ (* (+ 5 1) (+ 5 1)) (* (* 5 2) (* 5 2)))
```
Followed by the reductions:
```lisp
(+ (* 6 6) (* 10 10))
```
Then reducing multiplication:
```lisp
(+ 36 100)
```
and eventually resolving the sum:
```lisp
136
```

The answer is obviously the same but the process is different. Indeed the evaluations of `(+ 5 1)` and `(* 5 2)` are performed twice in this model.

We could use a test to determine whether the interpreted we are facing is using **Applicative-Order Evaluation** or **Normal Order Evaluation**. This test consists of two procedures:
```lisp
(define (p) (p))

(define (test x y)
    (if (= x 0)
        0
        y))

(test 0 (p))
```

- If we are using **Applicative-Order Evaluation** we come into an infinite recursion becuase the interpreter is trying to expand `(p)` which brings to infinite recursion.
- If we are using **Normal Order Evaluation** the test will ends correctly because `(p)` will not be evaluated until it is needed by some primitive operation and thus this will return `0` as result.

Lisp uses **Applicative-Order evaluation** because of the additional efficiency obtained from avoiding multiple evaluation of expressions.

## Conditional Expressions and Predicates

The `cond` construct of Lisp has this general form:
```lisp
(cond (<p1> <e1>)
      (<p2> <e2>)
       ...
      (<pn> <en>))
```
Each pair of expressions `(<p> <e>)` is called *clause*. The expression `<p>` is a *predicate* i.e. a value that is either true or false.
The predicate `<px>` is evaluated. If its value is false, then `<p(x+1)>` is evaluated. This process continues untile a predicate `<py>` is found whose value is true, in that case the interpreter returns the value of the corresponding *consequent expression* `<ey>`. If none of the `<p>`'s is found to be true, the value of `cond` is undefined.

### if

The `if` construct is a special form of `cond` that can be used when there are precisely two cases in the case analysis. Its general form is:
```lisp
(if <predicate> <consequence> <alternative>)
```

To evaluate an `if` expression, the interpreter starts by evaluating the `<predicate>` part of the expression. If the `predicate` evaluates to a true value, the interpreter evaluates the `consequent` and returns its value. Otherwise it evalautes the `alternative` and returns its value.

### Logical composition operations
- `(and <e1> <e2> ... <en>)`: the interpreter evaluates the expressions `<e>` one at the time in the left-to-right order. If any `<e>` evaluates to false, the value of the `and` expression is false and the rest of the `e`'s are not evaluated. If all `e`'s evaluate to true values, the value of the `and` expression is the value of the last one;
- `(or <e1> <e2> ... <en>)`: the interpreter evaluates the expressions `<e>` one at the time in the left-to-right order. If any `<e>` evaluates to true, the value of the `or` expression is true and the rest of the `e`'s are not evaluated. If all `e`'s evaluate to false values, the value of the `or` expression is the value of the last one;
- `(not <e>)`: the value of a `not` expression is true when the expression `<e>` evaluates to false, and false otherwise.

## Square Roots by Newton's Method

See [here](https://github.com/dariodip/sicp/blob/master/cap1/1.1/sqrt.rkt).

## Procedures as Black-Box Abstraction

The importance of a decomposing strategy is not simply that one is dividing the program into parts. Rather, it is crucial that each procedure accomplishes an identifiable task that can be used as a module in defining other procedures. When we use procedures inside our compound procedures, we could free us from concerning about *how* the procedure computes its result because the can be viewed as *procedural abstractions*. 

So a procedure definition should be able to suppress detail. The users of the procedure may not have written the procedure themselves, but may have obtained it from another programmer as a black box. A user should not need to know how the procedure is implemented in order to use it.

## Local names

The choice of the names for the formal parameters should not matter to the user of the procedure: the meaning of a procedure should be independent of the parameter names used by its author. The parameter names of a procedure must be local to the body of the procedure. 

The name of a formal parameter is called a *bounded variable* and we say that the procedure *binds* its formal parameters.

If a variable is not *bound*, we say that it is *free*.

The set of expressions for which a binding defines a name is called the *scope* of the name. In a procedure definition, the bound variables declared as the formal parameters of the procedure have the body of the procedure as their scope.

### Internal definitions and block structure

We could define inner functions inside the body of a compound procedure to avoid name overriding. For example this:
```lisp
(define (sqrt x)
  (sqrt-iter 1.0 x))
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
(define (improve guess x)
  (average guess (/ x guess)))
```
can be written as:
```lisp
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))
```

Such nesting of definitions, called *block structure*, is basically the right solution to the simplest name-packaging problem. 

In the latter example, we can also avoid to pass `x` to procedures which use `x` (the parameter of `sqrt`) in its scope:
```lisp
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
```

This discipline is called *lexical scoping*.

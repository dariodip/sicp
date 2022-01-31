# 1.3 Formulating Abstractions with Higher-Order Procedures

## Exercises

- [ ] 1.29
- [ ] 1.30
- [ ] 1.31
- [ ] 1.32
- [ ] 1.33
- [ ] 1.34
- [ ] 1.35
- [ ] 1.36
- [ ] 1.37
- [ ] 1.38
- [ ] 1.39
- [ ] 1.40
- [ ] 1.41
- [ ] 1.42
- [ ] 1.43
- [ ] 1.44
- [ ] 1.45
- [ ] 1.46

Procedures are **abstactions** that describe compound operations. They assign a name to a method for doing something.

A powerful programming language should have the ability to build abstractions by assigning names to common patterns and to work in terms of the abstractions directly. In Lisp, procedures provide this ability.

We can create procedures that accepts procedures as arguments or return procedures as values to avoid repetition of common patterns. 
> Procedures that manipulate procedures are called *higher-order procedures*.

## Procedures as Arguments

Check out [here](./hop.rkt).

## Constructing Procedures using `lambda`

The special form `lambda` creates procedures. Its form is the following: 
```lisp
(lamda (<formal-parameters>) <body>)
```

A procedure created by using `define` is equivalent to one created by using `lambda`:
```lisp
(define (fn x) (x))
; is equivalent to
(define fn (lambda (x) x))
```

Another use of `lambda` is in creating local variables to avoid repetition.

### Using `let` to create local variables

The special form `let` is used to bind a local variable. The general form of `let` is:
```lisp
(let ((<var1> <exp1>)
     (<var2> <exp2>)
     ; ...
     (<var_n> <exp_n>))
     
    <body>)
```
which can be thought as:
```
let <var1> have the value <exp1> and
    <var2> have the value <exp2>
    ...
    <varn> have the value <expn>
in <body>
```
The first part of the `let` is a list of name-expression pairs. When the `let` is evaluated, each name is associated with the value of the corresponding expression. The body of the `let` is evaluated with these names bound as local variables. The way this happens is that the `let` expession is interpreted as an alternative syntax for:
```
((lambda (<var1> <var2> ... <var_n>) <body>) 
    <exp1>
    <exp2>
    ...
    <exp_n>)
```

No new mechanism is required in the interpreter in order to provide local variables. A `let` expression is simply syntactic sugar for the underlying `lambda` application.

We can see from this equivalence that the scope of a variable specified by a `let` expression is the `body` of the `let`. 

- `let` allows one to bind variables as locally as possible to where they are to be used;
- The variables' values are computed outside the `let`.

We prefer using `let` to bind variables and `define` to define procedures.

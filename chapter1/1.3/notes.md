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

Check out [this](./hop.rkt).

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

## Procedures as General Methods

Using **Higher-Order Procedures** we can create procedures that can be used to express general methods of computation, independent of the particular functions involved.

#### Finding roots of equations by the half-interval method

Check out [this](./roots.rkt).

#### Finding fixed points of functions

Check out [this](./fixed_points.rkt).

> The approach of averaging successive approximation to a solution is called **average dumping**.

## Procesures as Returned Values

We can achieve more expressive power by creating procedures whose returned values are themselves procedures.

> As programmers, we should be alert to opportunities to identify the underlying abstractions in our programs and to build upon them and generalize them to creare more powerful abstractions. This is not to say that one should always write programs in the most abstract way possible.

The significance of *Higher-Order Procedure* is that they enable us to represent these abstractions explicitly as elements in our programming language, so that they can be handled just like other computational elements.

Programming languages impose restriction on the ways in which computational elements can be manipulated. 
Elements with the fewest restrictions are said to have **first-class** status and their priviledges are:
1. They may be named by variabvles;
2. They may be passed as arguments to procedures;
3. They may be returnes as the results of procedures;
4. They may be included in data structures.

Lisp awards procedures full fist-class status, even though the loss of performance derived by this decision. 

The major implementation cost of first-class procedures is that allowing procedures to be returnes as values requires reserving storage for a procedure's free variables even while the procedure is not executing.

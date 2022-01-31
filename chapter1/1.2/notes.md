# 1.2 Procedures and the Processes they generate

## Exercieses

- [x] 1.9
- [x] 1.10
- [ ] 1.11
- [ ] 1.12
- [ ] 1.13
- [ ] 1.14
- [ ] 1.15
- [ ] 1.16
- [ ] 1.17
- [ ] 1.18
- [ ] 1.19
- [ ] 1.20
- [ ] 1.21
- [ ] 1.22
- [ ] 1.23
- [ ] 1.24
- [ ] 1.25
- [ ] 1.26
- [ ] 1.27
- [ ] 1.28

A procedure is a pattern for the *local evolution* of the computational process that specifies how each stage of the process is built upon previous stage. We would like to be able to make statements about the *global* behavior of a process whose local evolution has been specified by a procedure.

## Linear Recursion and Iteration

The factorial function is defined by _n! = n * (n - 1) * (n - 2) * ... * 3 * 2 * 1_ and can be viewed as _n! = n * (n - 1)!_. So this can be expressed in Lisp as:
```lisp
(define (factorial n) 
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))
```
Using the substitution model, the procedure to compute *n!* can be described in this way: we first multiply *1* by *2*, then multiply the result by *3*, then by *4* and so on until we reach *n*. 
More formally, we maintain a running product, together with a counter that counts from *1* up to *n*. The counter and the product simultaneously change from one step to the next according to the rule:
```
product <- counter * product
counter <- counter + 1
```
and *n!* is the value of the product when the counter exceeds *n*.

The procedure can be recast as:
```lisp
(define (factorial n)
    (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
    (if (> counter max-count)
        product
        (fact-iter (* counter product)
                   (+ counter 1)
                   max-count)))
```

Analyzing the first process with the substitution model, we find a shape of *expansion* followed by *contraction*. 
- The expansion occurs as the process builds up a chain of *deferred operations*;
- The contraction occurs as the operations are actually performed.

This type of process, characterized by a chain of deferred operations, is called **recursive process**. To carry out this process the interpreter has to keep track of the operations to be performed later on. When the chain of deferred operations in a recursive process grows linearly with *n*, this is called **linear recursive process**.

The second process can be seen in another way: the program variables provide a complete description of the state of the process at that point. This is a *iterative process* since its state is captured completely by its three state variables.

> When we describe a procedure as recursive, we are referring to the syntactic fact that the procedure definition refers to the procedure itself.

> When we describe a process as recursive, we are speaking about how the process evolves, not about the syntax of how a procedure is written.

**tail-recursive**: a property of an interpreter can execute an iterative process in constant space, even if the iterative process is described by a recursive procedure.

## Tree Recursion

**Tree Recursion** is a pattern of computation.

Given the procedure to compute Fibonacci numbers:
```lisp
(define (fib n)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          (else (+ (fib (- n 1)) 
                    (fib (- n 2))))))
```
The evolved process to compute `(fib n)` looks like a tree, where each node (but the leaves) expands in two branches because the procedure call itself twice each time it is invoked. So the number of times the procedure will compute `(fib 0)` or `(fib 1)` is precisely `Fib(n + 1)`. Given that the value of `Fib(n)` grows exponentially with `n` (it is close to phi^2), this is not acceptable. 
- The number of steps is proportional to the nodes in the tree;
- The space required is proportional to the maximum depth of the tree.

### Iterative process
We use a pair of integers `a = Fib(1) = 1` and `b = Fib(0) = 0` and apply the following transformation iteratively:
```
a <- a + b
b <- a
```
So the resulting procedure will be
```lisp
(define (fib n)
    (fib-iter 1 0 n))

(define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
```
This method is a linear iteration.

> Tree-Recursive processes are useful when we operate on hierarchically structured data.

## Orders of Growth

The notion of **Order of Growth** can be used to describe the number of resources required by a process as the inputs become larger.
Let *n* be the parameter that measures the size of the problem, and let *R(n)* be the amount of resources the process requries for a problem of the size *n*. We say that *R(n)* has order of growth *\Theta(f(n))*, if there are positive constants *k1* and *k2* independent of *n* such that *k1 f(n) <= R(n) k2 f(n)* for any sufficiently large value of *n*.

### Exponentiation

Given a base *b* and an integer *n*, *b^n* is:
- _b^n = b * b^(n-1)_
- _b^0 = 1_

This can be transalted into the procedure:
```lisp
(define (expt b n)
    (if (= n 0) 
        1
        (* b (expt b (- n 1)))))
```
This process requires *O(n)* steps and *O(n)* space.

The iterative refactoring can be:
```lisp
(define (expt b n) 
    (expt-iter b n 1))

(define (expt-iter b counter product)
    (if (= counter 0)
        product
        (expt-iter b
            (- counter 1)
            (* b product))))
```
This requires *O(n)* steps and *O(1)* space.

We can compute exponentials using successive squares. So, as a general rule:
```
b^n = (b^(n/2))^2; if n is even
b^n = b * b(n-1); if n is odd
```

This can be expressed as a procedure:
```lisp
(define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))
```
This process grows logarithmically with *n* in both space and number of steps.

### Greatest Common Divisors

Given the formula: `GCD(a,b) = GCD(b,r)`, where  `r` is the remainder when `a` is divided by `b`. Using this concept we can apply this formula repetitely (Euclid's Algorithm). 
```lisp
(define (gcd a b) 
    (if (= b 0) 
        a
        (gcd b (remainder a b))))
```
This grows as the logarithm of the numbers involved.

### Test for Primality

One way to test if a number is prime is to find the number's divisors:
```lisp
(define (smallest-divisor n)
    (find-divisor n 2))

(define (find-divisor n test-divisor)
    (cond ((> (square test-divisor n) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
    (= (remainder b a) 0))

(define (prime? n) 
    (= n (smallest-divisor n)))
```

> If n is not prime it must have a divisor less than or equal to sqrt(n).

The Fermat test is based on Fermat's Little Theorem:
> Fermat's Little Theorem: If n is a prime number and a is any positive integer less than n, then a raised to the nth power is congruent to a modulo n.

This can be expresses as:
```lisp
(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
            (remainder (square (expmod base (/ exp 2) m))
            m ))
          (else
            (remainder (* base (expmod base (- exp 1) m))
                        m))))
(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false)))                        
```

### Probabilistic methods

> The existence of tests for which one can prove that the chance of error becomes arbitrarily small has sparked interest in algorithms of this type, which have come to be known as **probabilistic algorithms**. 
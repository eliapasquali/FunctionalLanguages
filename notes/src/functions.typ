
= Functions

== Function applications

The line in the C grammar that allow us to do function calls is $f(e_1, dots, e_n)$. In functional languages we use to call this _application_ of the function and usually it is called just by writing the name of the function followed by the arguments.

The "functional grammar" for the application is ```bnf expr ::= expr expr```.

Take for example the function ```Fsharp (fun x -> x) 7```. This is the identity function, so from something it returns the exactly same thing. In this case types #underline([are not]) explicit, so the compiler create some "generic" _anonymous types_.

#table(
  columns: (1fr, 2fr),
  // F# Row
  [```Fsharp (fun x -> x) 7```], [F\# function],
  // Anonymous types
  [$f : prime.rev a arrow.r prime.rev a$], [Anonymous type generated by the compiler],
  // Inferred types
  [$f : "int" arrow.r "int" $], [Types by inferred the compiler using the type of the argument],
)

#underline([*Note*]): in application the left part must be an arrow (a function). We can say that #underline([lambdas create]) and #underline([applications remove]) arrows.

After the application, the type is inferred by the compiler. It understands that we are passing a integer, so the function becomes "_monomorphic at time of application_" over the type `int`.

=== Binding of parameters

```Fsharp
let succ x = x + 1  // Syntactic sugar for this: let succ = fun x -> x + 1

let seven = f 6     // 6 is bounded to x then the function is computed 
```

That 6 in the function applications replaces every occurency of `x` in the scope of the parameter.

=== Errors accepted by the grammar

If we look at the grammar for function application application (but not only in that) we can see that it is possible to create something that is #underline([syntactically correct but that will produce an error]). For this we need to use the power of *types* and *type check* what we create with our grammar.

== Currying

Currying is the technique of translating the evaluation of a function that takes multiple arguments 
into evaluating a sequence of functions, each with a single argument.

Let's see an example with integer addition. The uncurried form of this operation is
```Fsharp
// uncurry_add : int * int -> int
// Syntactic sugar for uncurry_add = fun (x, y) -> x + y
let uncurry_add (x, y) = x + y

let result = uncurry_add (7, 8)
```
It accepts only pair of integers as arguments and after the application it returns the result.


In its curried form instead we have
```Fsharp
// curry_add : int -> (int -> int)
// Syntactic sugar for curry_add = fun (x, y) -> x + y
let curry_add (x, y) = x + y

// partial_application : int -> int
let partial_application = curry_add 7

// final_application : int
let final_application = z 1

// total_application : int -> int -> int
let total_application = curry_add 7 1
```
Currying is in fact using more arrows in a function definition. With this form we can pass single integers as arguments and make "partial" applications of the function. It is automatically applied associativity on the left.

=== Function transformer

We can define functions that transform from uncurried version to the curried one and viceversa.

```Fsharp
// curry : ('a * 'b -> 'c) -> 'a -> 'b -> 'c
let curry f x y = f (x, y)

// uncurry : ('a -> 'b -> 'c) -> 'a * 'b -> 'c
let uncurry f (x, y) = f x y
```

`curry` converts an uncurried function to a curried function. `uncurry` converts a curried function to a function on pairs. Let's see an example with the addition:

```Fsharp
>>> curry uncurry_add 40 2
>>> 42

>>> uncurry curry_add (2, 40)
>>> 42
```

== Shadowing and overloading

Overloading is a type of polymorphism, where different functions with the same name are invoked based on the data types of the parameters passed. This #underline([is not]) supported in F\#!

Instead shadowing occurs when something declared within a certain scope has the same name as a variable declared in an outer scope. Let's see an example:

```Fsharp
let a = 3
let b = a + 1
let a = "string"  // This shadows the int version
let c = a + 2     // This won't work because of types don't match
```

Every new _let bind_ create shadows. _To rebind_ is different from _to reassign_ but in some cases it can be useful, for example to block the usage of an old value of the bind.

Another example:

```Fsharp
let f x =               // First f
  let f x = x + 1       // This is a new f
  let f x = f (x + 1)   // It applies the last defined f
  x
```

=== Method dispatching

In OOP there is _dynamic dispatching_ on method calls (Runtime Choose Methods). Methods are deferenced pointers of the virtual table of the object, in fact the call `object.method` emits a pointer and then jumps to it.

Overloading is instead _static dispatching_, because it uses different prototypes created in a way that allows the compiler to choose the right method based on the arguments at compile time.

== Recursion

At the syntax level recursion is a function that calls itself, at the semantic level is having the symbol of the function itself inside the scope. In F\# to enable recursiveness of a function we have to add `¶ec` in the declaration.

```Fsharp
let rec fact n =
  if n > 1
  then n * fact (n-1)
  else 1
```

=== Pattern matching

We can redefine our recursive function using _pattern matching_

```Fsharp
let rec fact n =
  match n with
  | 0 | 1 -> 1
  | n     -> n * fact (n-1)
```

We use the syntax

```Fsharp
match expr with
| Pattern -> expr
| Pattern -> expr
| ...
```

Following the Chomksy hierarchy Patterns are at the level of regular expressions.

All the branches must return the same type.

== Higher order functions

We call _higher order functions_ a function that takes functions as arguments.

== Predicates

We call _predicates_ a function where codomain is boolean, so something that returns only true or false.

== #sym.eta conversion

An _#sym.eta conversion_ is adding or dropping abstraction over a function.

From the first to the second is an _#sym.eta reduction_, viceversa it is called _#sym.eta expansion_
```Fsharp
iter (fun x -> printf("%d") x) [1 .. 10]

iter (printf("%d") x) [1 .. 10]
```

=== Folding

In functional programming, *fold* (or _reduce_) is a family of higher order functions that process a data structure in some order and build a return value. For example summing all the elements of a list can be obtained from folding it.

An opposed family of function is the _unfold_ family which create a data structure starting from a value and applying a function to it.
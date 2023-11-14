= Lists

We could define list in the classic recursive method `(node, next)`.

The classic `Struct` approach in C style is based on record. We define a list using a union type.

```Fsharp
// Union type list of integers
type myList = Empty | NonEmpty of int*myList
```

In this way we define a list that is either an empty list or a non empty list. We use that `Empty` to mimic the classic `nullptr` terminator. Let's see the standard library polymorphic definition:

```Fsharp
type `a list = [] | (::) of `a*`a list
```

With this definition `[]` and `::` are just names for the empty and non empty list. Just note that using parenthesis makes the `::` an infix operator, to define things in a more convenient way:

```Fsharp
myList = NonEmpty(1, NonEmpty(2, Empty))

list = 1 :: 2 :: [] // Inferred type: int
```

== Functions over lists

=== Length

We recursively calculate the lenght by add one until the last element.
```Fsharp
let rec length list = 
  match list with
  | []            -> 0
  | head :: tail  -> 1 + length tail 
```
In this version we define `head` but we never use it. To "define" a placeholder for something we won't use there is `_`, so the second pattern becomes ```FSharp _ :: tail -> 1 + length tail```

=== Insertion

To insert in the head we can just use the list constructor
```Fsharp
insert_head = 0 :: int_list // OK
// int  :: int list
// `a   :: `a list
```

To insert at the end we need to define a function
```Fsharp
let rec insert_tail list elem =
  match list with                               // Returns
  | []            -> [elem]                     // `a list
  | head :: tail  -> head :: insert tail elem   // `a list
```

==== Syntactic sugar

```Fsharp
[e1; e2] // e1 :: e2 :: []

int_list = [1; 2; 3] // 1 :: 2 :: 3 :: []

insert_head = [0; int_list] // ERROR
// 0    :: [1; 2; 3]  ::  []
// int  :: int list   ::  ??

insert_head = [[0], int_list] // OK
// [0]      :: [1; 2; 3]  :: []
// int list :: int list   :: int list
```

That `insert_head` won't work becaue it is appending 0 to a list of integer and then to the empty list. That two elements have different types, because 0 is an `int` and the list is an `int list`, making the result an eterogeneous list.

=== Map

`Map` is a function that applies a function `f` to all elements of a list and returns the list result of the application.

```Fsharp
// map : `a -> `b -> `a list -> `b list
let rec map f l =
  match l with
  | []      -> []
  | h :: t  -> f h :: map f t
```

=== Filter

`Filter` is a function that filter all elements of a list over a condition `p` and returns a new list with only the valid elements.

```Fsharp
// filter : (`a -> bool) -> `a list -> `a list
let rec filter p l =
  match l with
  | []      -> []
  | h :: t  -> if p h then p :: filter p t else filter p t
```

We have that `filter p t` duplicated, so we can define a variable to reuse that value.

```Fsharp
  | h :: t  ->  let filter_tail = filter p t
                if p h then p :: filter_tail else filter_tail
```

This is not only a syntactic difference: because of F\# is a _strict language_ everything is evaluated and executed one time.

=== Iter

`Iter` is a function that applies a function `f` to a list all elements without returning the result of the applications.

```Fsharp
// iter : (`a -> unit) -> `a list -> unit
let rec iter f l =
  match l with
  | []     -> ()              // () unit represent nothing
  | h :: t -> f h; iter f t   // ;  binary operator : (unit * `a) -> `a
```

Take the application of `iter`

```Fsharp
// Full
iter ( fun x -> printf("%d") x ) [ 1 .. 10 ]

// eta-reduced
iter (printf("%d")) [1 .. 10]
```

=== Sum elements in a list

Let's define a first monomorphic version over integers

```Fsharp
// sum_mono : int list -> int
let rec sum_mono list =
  match list with
  | []     -> 0
  | h :: t -> h + sum_mono t
```

Now the polymorphic version, using the infix operator + in order to make it more easy and readable. We have to pass a function that manage the addition between our parametric type and the representation of the zero in that operation.

```Fsharp
// sum : (`a -> `b -> `b) -> `b -> `a list -> `b
let rec sum (+) zero list =
  match list with
  | []     -> zero
  | h :: t -> h + sum (+) zero t
```

=== Fold

The function `fold_back` recur until the last element and them accumulate starting from the end.

```Fsharp
// fold_back : (`a -> `b -> `b) -> `b -> `a list -> `b
let rec fold_back f acc list =
  match list with
  | []     -> acc
  | h :: t -> f h (fold_back f acc t)
```

The function that works in the other direction is `fold`

```Fsharp
// fold : (`a -> `b -> `b) -> `b -> `a list -> `b
let rec fold f acc list =
  match list with
  | []     -> acc
  | h :: t -> fold f (f h acc) t
```

==== Using folding with other functions

*NOTE*: `@` is not a constructor, it is just a function in infix form that take two lists and combine them together.

```Fsharp
let filter_by_fold p l =
  fold (fun x acc -> if p x then acc @ [] else acc) [] l
```

```Fsharp
let filter_by_fold_back p l =
  fold (fun x acc -> if p x then x :: acc else acc) [] l
```

```Fsharp
let map_by_fold f l =
  fold (fun x acc -> acc @ [ f x ]) [] l
```

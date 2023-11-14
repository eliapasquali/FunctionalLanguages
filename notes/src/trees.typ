= Trees

We start by defining a binary tree made of `Node` tuple of (data, left tree, right tree) and `Leaf`.

```Fsharp
type `a bintree = Leaf | Node of `a * `a bintree * `a bintree
```

With this implementation create a simple tree is long:

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  [
    ```Fsharp
    let tree = bintree
    (
      1,
      bintree(
        2,
        bintree(3, Leaf, Leaf),
        bintree(4, Leaf, Leaf)
      ),
      bintree(
        5,
        Leaf,
        bintree(6, Leaf, Leaf)
      )
    )
    ```
  ],
  [
    #image(
      "../assets/images/tree.svg"
    )
  ]
)

== Printing a tree

Just an example of a printing function that prints the tree going depth first on the left.

*NOTE*: in F\# there is a special parameter specifier that is polymorphic, which is `"%0"`

```Fsharp
let rec print_bintree tree =
  match tree with
  | Leaf ->
  | Node(data, left, right) ->
      printf "%0" data;
      print_bintree left;
      print_bintree right
```
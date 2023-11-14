= Types

In computer science we define *record* an abstract data type with only field. In languages we have implementation of records, for example structs in C or classes in OOP. Records are also referred as *product types*.

*Unions* instead are a type in which values may have different rappresentation or formats withing the same position in memory. They are also called *sum types*. They represent a choice. The most famous union type is _boolean_, that is either true or false.

In C we have `typedef` for creating an alias to an already existing type and `enum` to give constant names to integers. Then there are `struct` and `union`.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  [
    ```c
    struct S{
      int a;
      double b;
      char* c;
    }
    ```

    In memory this struct is 
    
    #box([#rect(width: 2em)[#align(center, "4B")]])
    #box([#rect(width: 4em)[#align(center, "8B")]])
    #box([#rect(width: 4em)[#align(center, "8B")]])

    For every element of the struct a memory space is reserved.
  ],
  [
    ```c
    union S{
      int a;
      double b;
      char* c;
    }
    ```

    In memory this union is 
    
    #box([#rect(width: 4em)[#align(center, "8B")]])

    It treats the same memory location in multiple ways.
  ]
)

In F\# we have records and unions. Records are defined with the `type` keyword and unions with the `type` keyword and the `|` symbol.

#grid(
  columns: (1fr, 1fr),
  column-gutter: 2em,
  [
    ```Fsharp
    // Record type
    type Person = {
      name    : string
      surname : string
      age     : int
    }
    ```
  ],
  [
    ```Fsharp
    // Union type
    type Color = Black | White | Yellow | Blue
    ```

    ```Fsharp
    // Typedef (an alias)
    type alias = int
    ```
  ]
)
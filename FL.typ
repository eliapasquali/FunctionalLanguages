= Functional languages


== Intro
What makes a language functional? The fact that "_functions are first class citizen of the language_". This means that functions can be passed as arguments to other functions, returned as values from other functions, and assigned to variables or data structures.

== Some basics

Analyzing the `C` grammar we can identify *expressions* and *statemets*.

- *Statements* are single line of code of type `statement`
- *Expressions* are entities that can be evaluated and have a type

Let's describe the `C` grammar in BNF notation:

#grid(
  columns: (1fr, 2fr),
  [
    ```bnf
    expr ::= constant
      |  (expr)
      |  x
      |  expr++
      |  ++expr
      |  expr--
      |  --expr
      |  expr = expr
      |  expr += expr
      |  expr -= expr
      |  ...
      |  expr + expr
      |  expr - expr
      |  expr * expr 
      |  expr / expr
      |  expr % expr
      |  expr << expr
      |  expr >> expr 
      |  expr & expr
      |  expr | expr
      |  expr ^ expr
      |  ~ expr 
      |  - expr
      |  f(expr1, ..., exprN)
      |  & expr
      |  expr ? expr : expr
      |  * expr
      |  expr[expr]
      |  ! expr
      |  expr && expr
      |  expr || expr
      |  expr == expr
      |  expr < expr
      |  expr <= expr
      |  expr > expr
      |  expr >= expr
      |  expr.x
    ```
  ],
  [
    ```bnf
    constant ::= 0 | 1 | 2 | 3 | ...
              |  'a' | 'b' | ...
              |  1.0 | 2.45 | ...
              |  "string..."

    block ::= statement ;
            |  statement ; block

    cases :: = case constant: block
          |   case constant: block cases

    statement ::= return expr
              |  if (expr) { block }
              |  if (expr) { block } else { block }
              |  for (statement ; expr ; expr ) { block }
              |  while (expr) { block }
              |  do { block } while (expr)
              |  switch (expr) { cases }
              |  break
              |  continue
              |  goto x
    ```
  ]
)

=== Reduction

*Reduction* is the evaluation of an expression. With this process every part of the expression is "reduced" to a smaller form until we get to a _ground value_. Let's take $1+2*4$ as example:

$
  overbrace(
    overbrace(
      underbracket(
        underbracket(1+2, 3) * 4,
      12), "int"),
  "int")
$

On the lower brackets we can see the result of the evaluation of the arithmetical operations. From the upper brackets instead we can see that the reduction preserves the types of the expression.
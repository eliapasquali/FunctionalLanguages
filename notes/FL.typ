#import "./config/notes.typ" : notes

#show: notes.with(
  author: "Elia Pasquali",
  title: "Functional Languages"
)

// Various stuff from the first lessons
#include "src/intro.typ"
#pagebreak()

// Functions, applications, currying, shadowing and overload, pattern matching
#include "src/functions.typ"
#pagebreak()

// Types: records and union
#include "src/types.typ"
#pagebreak()

// Lists
#include "src/lists.typ"
#pagebreak()

// Trees
#include "src/trees.typ"
#pagebreak()
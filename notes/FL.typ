#import "./config/notes.typ" : notes

#show: notes.with(
  author: "Elia Pasquali",
  title: "Functional Languages"
)

#include "src/intro.typ"
// Various stuff from the first lessons

#include "src/functions.typ"
// Functions, applications, currying, shadowing and overload

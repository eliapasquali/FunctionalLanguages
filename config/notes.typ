#let notes(
  author: "Nome cognome",
  title: "Titolo",
  lang: "en",
  body
) = {

  set document(author: author, title: title)
  
  // Set F# syntax highlighting
  set raw(syntaxes: "F#.sublime-syntax")

  align(center, 
    [
      #text(font: "Impact", weight: "bold", size: 24pt, [ #title ])
      #v(1fr)
      // Titlepage image
      #image("../assets/images/magician.png")
      #v(1fr)
      #line(length: 100%)
      #smallcaps([ Unipd 2023-2024 ])
    ]
  )

  pagebreak()

  outline(indent: auto, depth: 5)
  
  pagebreak()

  body
}
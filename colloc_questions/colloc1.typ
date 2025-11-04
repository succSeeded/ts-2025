#set page(
  paper: "a4",
  numbering: "1",
)

#set text(
  size: 14pt,
)

#set par(
  justify: true,
)

#set math.cases(
  gap: 1em,
)

#set heading(numbering: "1. ")

#show heading.where(level: 1): it => { pagebreak(weak: true); it }

#show heading: set block(above: 1.5em, below: 1.0em)

// Table of contents
#outline()
#pagebreak()

// Shitty code, but I could not be bothered to do something better
#for i in range(1, 12) {
  include "src\question"+str(i)+".typ"
}


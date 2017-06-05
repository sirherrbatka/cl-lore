(use-package :cl-lore.api)
(use-package :cl-lore.html)
(named-readtables:in-readtable :scribble)

(cl-lore.api:def-chunks *new-document* :cl-lore)

(chunk *new-document* <standard-names>
  @begin{section}
  @title{test-chunk}
  @par{@emphasis{This} chunk has been created as a test!}
  @begin{section}
  @title{This is subsection title}
  @par{This is subsection!}
  @end{section}
  @end{section})


(chunk *new-document* <standard-names>
  @begin{section}
  @title{Functions!}
  @par{Those are some functions...}
  @begin{doc}
  @pack{cl-lore}
  @fun{pack}
  @end{doc}
  @end{section})


(defun test-syntax ()
  (document <html-output-generator> <standard-names> out *new-document*
    @title{cl-lore documentation}
    @begin{section}
    @title{Overview}
    @par{Lorem ipsum. @emphasis{Test!} To jest i tak tylko test}
    @end{section}

    @incl{test-chunk}
    @incl{Functions!}))


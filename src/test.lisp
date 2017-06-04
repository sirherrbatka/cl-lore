(in-package #:cl-lore)
(named-readtables:in-readtable :scribble)

(def-chunks *new-document*)

(chunk *new-document* <standard-names>
  @begin{section}
  @title{test-chunk}
  @par{@emphasis{This} chunk has been created as a test!}
  @end{section})


(defun test-syntax ()
  (document <html-output-generator> <standard-names> out *new-document*
    @begin{section}
    @title{Overview}
    @par{Lorem ipsum. @emphasis{Test!} To jest i tak tylko test}
    @label{Overview}
    @end{section}

    @incl{test-chunk}))


(in-package #:cl-lore)
(named-readtables:in-readtable :scribble)

(defun test-syntax ()
  (document <html-output-generator> <standard-names> out
    @begin{section}
    @title{Overview}
    @par{Lorem ipsum. @emphasis{Test!} To jest i tak tylko test}
    @label{Overview}
    @end{section}))

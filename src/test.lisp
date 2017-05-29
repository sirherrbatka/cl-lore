(in-package #:cl-lore)
(scribble:enable-scribble-syntax)


(defun test-syntax ()
  (document <html-output-generator> <standard-names> out
    @begin{section}
    @title{Overview}
    @par{Lorem ipsum kurwa dupa i chuj. @emphasis{Test!} To jest i tak tylko test}
    @end{section}))

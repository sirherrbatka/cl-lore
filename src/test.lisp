(defpackage :cl-lore.test
  (:use #:cl #:cl-lore.api #:cl-lore.html
        #:cl-lore.mechanics #:cl-lore.protocol))
(in-package #:cl-lore.test)
(named-readtables:in-readtable :scribble)

(defparameter *docs* (docstample:make-accumulator))

(defun test ())

(docstample:set-documentation
 'test docstample:<mechanics> docstample:<function> *docs*
 :description "Test function that is not all that important"
 :side-effects "many, many side effects.")

(cl-lore.api:def-chunks *new-document* *docs*)

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
  @pack{CL-LORE.TEST}
  (fun 'test)
  @end{doc}
  @end{section})


(defun test-syntax ()
  (document (<mechanics-html-output-generator> <standard-names> out *new-document*
             :output-options (:css *mechanics-html-style*))
    @title{cl-lore documentation}
    @begin{section}
    @title{Overview}
    @par{Lorem ipsum. @emphasis{Test!} To jest i tak tylko test}
    @end{section}

    @incl{test-chunk}
    @incl{Functions!}))


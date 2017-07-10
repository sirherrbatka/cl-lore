(defpackage :cl-lore.test
  (:use #:cl #:cl-lore.api #:cl-lore.html
        #:cl-lore.mechanics #:cl-lore.protocol))
(in-package #:cl-lore.test)
(named-readtables:in-readtable :scribble)

(defparameter *docs* (docstample:make-accumulator))

(defun test ())

(defmacro test2 ())

(defgeneric test3 (self))

(defclass test4 ()
  ())

(defclass test6 (test4)
  ())

(defclass test7 (test6)
  ())

(defclass test9 ()
  ())

(defclass test8 (test7 test9)
  ())

(defstruct test5)

(docstample:set-documentation
 'test2 docstample:<mechanics> docstample:<macro> *docs*
 :description "This is a macro!")

(docstample:set-documentation
 'test docstample:<mechanics> docstample:<function> *docs*
 :description "Test function that is not all that important"
 :side-effects "many, many side effects.")

(docstample:set-documentation
 'test3 docstample:<mechanics> docstample:<generic> *docs*
 :description "Generic test function that is not all that important"
 :side-effects "many, many side effects.")

(docstample:set-documentation
 'test4 docstample:<mechanics> docstample:<class> *docs*
 :description "Just a class.")

(docstample:set-documentation
 'test5 docstample:<mechanics> docstample:<struct> *docs*
 :description "Just a struct.")

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
  (docfun 'test)
  (docmacro 'test2)
  (docgeneric 'test3)
  (docclass 'test4)
  (docstruct 'test5)
  (docclass 'test6)
  (docclass 'test8)
  (docclass 'cl-ds.dicts.hamt:transactional-hamt-dictionary)
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

(save-output #P"/home/shka/lore/" (test-syntax))

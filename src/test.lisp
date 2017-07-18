(defpackage :cl-lore.test
  (:use #:cl))

(cl-lore.api.syntax:syntax
 cl-lore.extensions.documentation.protocol
 cl-lore.extensions.documentation.api)


(defparameter *docs* (docstample:make-accumulator))
(setf *index* *docs*)


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

(def-chunks *new-document*)


(with-names (<documentation-names>)
  (chunk *new-document*
    @begin{section}
    @title{test chunk} @label{test-chunk}
    @text{@emph{This} chunk has been created as a test!}
    @begin{section}
    @title{This is subsection title}
    @text{This is subsection!}

    @begin{table}
    @row[[a,1] [b,1]]
    @row[[a,2] [b,2]]
    @end{table}

    @end{section}
    @end{section})

  (chunk *new-document*
    @begin{section}
    @title{Functions!} @label{functions}
    @text{Those are some functions...}
    @begin{documentation}
    @pack{CL-LORE.TEST}
    @docfun['test]
    @docmacro['test2]
    @docgeneric['test3]
    @docclass['test4]
    @docstruct['test5]
    @docclass['test6]
    @docclass['test8]
    @end{documentation}
    @end{section}))


(defun test-syntax ()
  (with-names (<documentation-names>)
    (document (cl-lore.mechanics:<mechanics-html-output-generator> out *new-document*
               :output-options (:css cl-lore.mechanics:*mechanics-html-style*))
      @title{cl-lore documentation}
      @begin{section}
      @title{Overview}
      @text{Lorem ipsum. @emph{Test!} To jest i tak tylko test}
      @end{section}

      @include{test-chunk}
      @include{functions})))

(cl-lore.protocol.output::save-output #P"/home/shka/lore/" (test-syntax))

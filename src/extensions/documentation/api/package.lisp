(in-package #:cl-user)


(defpackage :cl-lore.extensions.documentation.api
  (:use #:common-lisp #:cl-lore.aux-package)
  (:export
   #:<documentation-names>
   #:docclass
   #:docerror
   #:docfun
   #:docvar
   #:docgeneric
   #:docmacro
   #:docstruct
   #:pack))

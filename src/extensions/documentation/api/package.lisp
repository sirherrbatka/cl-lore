(in-package #:cl-user)


(defpackage :cl-lore.extensions.documentation.api
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:<documentation-names>
   #:docfun
   #:docgeneric
   #:pack
   #:docmacro
   #:docclass
   #:docstruct))

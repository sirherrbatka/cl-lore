(in-package #:cl-user)


(defpackage :cl-lore.api
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate #:cl-lore.protocol)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:document
           #:chunk
           #:def-chunks
           #:with-chunks
           #:scribble-syntax
           #:make-node

           #:begin
           #:begin-document
           #:end-document
           #:end
           #:title
           #:docfun
           #:docgeneric
           #:docclass
           #:docmacro
           #:docstruct
           #:emphasis
           #:incl
           #:par
           #:%par
           #:label
           #:pack

           #:<standard-names>))

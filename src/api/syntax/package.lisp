(in-package #:cl-user)


(defpackage #:cl-lore.api.syntax
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:*constructor-names*
   #:begin
   #:begin-document
   #:chunk
   #:column
   #:def-chunks
   #:document
   #:emph
   #:end
   #:end-document
   #:include
   #:label
   #:row
   #:syntax
   #:text
   #:title
   #:with-names))

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
   #:column
   #:def-chunks
   #:document
   #:emph
   #:end
   #:level
   #:end-document
   #:include
   #:item
   #:define-save-output-function
   #:label
   #:row
   #:row
   #:syntax
   #:table
   #:text
   #:title
   #:title-row
   #:with-names))

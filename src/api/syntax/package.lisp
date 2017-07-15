(in-package #:cl-user)


(defpackage #:cl-lore.api.syntax
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:syntax
   #:chunk
   #:text
   #:begin
   #:document
   #:*constructor-names*
   #:with-names
   #:begin-document
   #:end-document
   #:def-chunks
   #:emph
   #:end
   #:title
   #:label
   #:include))

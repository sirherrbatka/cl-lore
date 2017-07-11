(in-package #:cl-user)


(defpackage #:cl-lore.api.raw
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:make-chunk
   #:make-node
   #:make-root
   #:make-leaf
   #:make-tree

   #:fundamental-api-error
   #:node-construction-error

   #:<emphasis-trait>
   #:<title-trait>
   #:<paragraph-trait>

   #:*stack*
   #:*register*
   #:*chunks*
   #:*node-definitions*))

(in-package #:cl-user)


(defpackage #:cl-lore.api.raw
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:*chunks*
   #:*node-definitions*
   #:*register*
   #:*stack*
   #:<emphasis-trait>
   #:<paragraph-trait>
   #:<title-trait>
   #:controller-empty-p
   #:controller-front
   #:controller-pop-anything
   #:controller-pop-tree
   #:controller-push-tree
   #:controller-return
   #:controller-return
   #:def-syntax
   #:def-without-stack
   #:fundamental-api-error
   #:get-chunk
   #:make-chunk
   #:make-leaf
   #:make-node
   #:make-root
   #:make-sequence-node
   #:make-tree
   #:node-construction-error
   #:push-chunk))

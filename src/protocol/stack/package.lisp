(in-package #:cl-user)


(defpackage #:cl-lore.protocol.stack
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:controller-return
   #:controller-push-tree
   #:controller-pop-tree
   #:controller-front
   #:controller-empty-p

   #:fundamental-stack-condtition
   #:stack-operation-not-allowed
   #:invalid-stack-state

   #:read-operation

   #:fundamental-stack-controller
   #:abstract-stack-controller))

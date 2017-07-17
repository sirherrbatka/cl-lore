(in-package #:cl-user)


(defpackage #:cl-lore.protocol.stack
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:abstract-stack-controller
   #:controller-empty-p
   #:controller-front
   #:controller-pop-anything
   #:controller-pop-tree
   #:controller-push-tree
   #:fundamental-stack-condtition
   #:fundamental-stack-controller
   #:invalid-stack-state
   #:read-operation
   #:stack-operation-not-allowed
   #:top-stack-controller))

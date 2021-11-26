(in-package #:cl-user)


(defpackage #:cl-lore.protocol.stack
  (:use #:common-lisp #:cl-lore.aux-package)
  (:export
   #:abstract-stack-controller
   #:controller-empty-p
   #:controller-front
   #:controller-pop-anything
   #:controller-pop-tree
   #:controller-push-tree
   #:controller-return
   #:fundamental-stack-condtition
   #:fundamental-stack-controller
   #:invalid-stack-state
   #:read-operation
   #:stack-operation-not-allowed
   #:top-stack-controller))

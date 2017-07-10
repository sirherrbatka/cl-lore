(in-package #:cl-user)


(defpackage #:cl-lore.protocol.stack
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:controller-return
   #:controller-push-tree
   #:controller-pop-tree
   #:controller-front
   #:controller-empty-p))

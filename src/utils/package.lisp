(in-package #:cl-user)


(defpackage #:cl-lore.utils
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:find-in-tree
   #:insert-into-tree))


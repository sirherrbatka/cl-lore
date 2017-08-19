(in-package #:cl-user)


(defpackage :cl-lore.extensions.sequence-graphs.protocol
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:make-sequence-node
   #:sequence-node))

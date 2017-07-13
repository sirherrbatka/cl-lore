(in-package #:cl-user)


(defpackage #:cl-lore.graphics.graph
  (:use #:common-lisp #:serapeum #:alexandria #:iterate) 
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:vector-dot-graph))

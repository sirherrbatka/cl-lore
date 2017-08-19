(in-package #:cl-user)


(defpackage :cl-lore.extensions.sequence-graphs.graphics
  (:use #:common-lisp #:alexandria #:iterate #:cl-svg)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:shadowing-import-from #:alexandria #:rotate)
  (:export
   #:make-context
   #:seq
   #:make-axis
   #:draw-diagram))

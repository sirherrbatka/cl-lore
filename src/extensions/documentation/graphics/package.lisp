(in-package #:cl-user)


(defpackage :cl-lore.extensions.documentation.graphics
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:make-class-inheritance))

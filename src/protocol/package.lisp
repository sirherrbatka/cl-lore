(in-package #:cl-user)


(defpackage :cl-lore.package
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export))

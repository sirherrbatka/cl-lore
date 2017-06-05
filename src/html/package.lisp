(in-package #:cl-user)


(defpackage :cl-lore.html
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate #:cl-lore.protocol)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export))

(in-package #:cl-user)


(defpackage :cl-lore.mechanics
  (:use #:common-lisp #:serapeum #:alexandria #:cl-lore.html
        #:iterate #:cl-lore.protocol #:docstample #:docstample.mechanics)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:*mechanics-html-style*
           #:<mechanics-html-output-generator>))

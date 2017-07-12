(in-package #:cl-user)


(defpackage :cl-lore.mechanics
  (:use #:common-lisp #:serapeum #:alexandria #:cl-lore.html
        #:iterate #:cl-lore.api.syntax #:cl-lore.html
        #:cl-lore.protocol.output #:cl-lore.protocol.structure)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:*mechanics-html-style*
           #:mechanics-html-output-generator
           #:<mechanics-html-output-generator>))

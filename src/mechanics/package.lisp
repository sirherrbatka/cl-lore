(in-package #:cl-user)


(defpackage :cl-lore.mechanics
  (:use #:common-lisp #:cl-lore.aux-package #:cl-lore.html
        #:iterate #:cl-lore.api.syntax #:cl-lore.html
        #:cl-lore.protocol.output #:cl-lore.protocol.structure)
  (:export
   #:<mechanics-html-output-generator>
   #:mechanics-html-output-generator
   #:*mechanics-html-style*))

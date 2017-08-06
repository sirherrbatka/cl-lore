(in-package #:cl-user)


(defpackage #:cl-lore.protocol.output
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:add-image
   #:apply-trait
   #:contextual-process-element
   #:fundamental-output
   #:fundamental-output-generator
   #:make-output
   #:process-element
   #:save-output))

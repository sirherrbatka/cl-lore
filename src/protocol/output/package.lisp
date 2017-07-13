(in-package #:cl-user)


(defpackage #:cl-lore.protocol.output
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:process-element
   #:apply-trait
   #:fundamental-output-generator
   #:fundamental-output
   #:save-output
   #:add-image
   #:make-output))

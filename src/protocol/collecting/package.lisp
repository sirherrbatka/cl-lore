(in-package #:cl-user)


(defpackage #:cl-lore.protocol.collecting
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:fundamental-chunks-collection
   #:chunks-collection

   #:push-chunk
   #:get-chunk))

(in-package #:cl-user)


(defpackage #:cl-lore.protocol.collecting
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:chunks-collection
   #:fundamental-chunks-collection
   #:get-chunk
   #:push-chunk))

(in-package #:cl-user)


(defpackage #:cl-lore.protocol.collecting
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:chunks-collection
   #:fundamental-chunks-collection
   #:fundamental-collecting-condition
   #:get-chunk
   #:no-chunk-with-label-condition
   #:push-chunk))

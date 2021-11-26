(in-package #:cl-user)


(defpackage #:cl-lore.protocol.collecting
  (:use #:common-lisp #:cl-lore.aux-package)
  (:export
   #:chunks-collection
   #:fundamental-chunks-collection
   #:fundamental-collecting-condition
   #:get-chunk
   #:no-chunk-with-label-condition
   #:push-chunk))

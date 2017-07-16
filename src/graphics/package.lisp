(in-package #:cl-user)


(defpackage #:cl-lore.graphics
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:file-name
   #:fundamental-image
   #:raster-image
   #:read-name
   #:save-image
   #:vector-image))

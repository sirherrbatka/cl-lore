(in-package #:cl-user)


(defpackage #:cl-lore.graphics
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:access-name
   #:file-name
   #:fundamental-image
   #:has-name-p
   #:raster-image
   #:save-image
   #:vector-image))

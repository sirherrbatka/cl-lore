(in-package #:cl-user)


(defpackage #:cl-lore.graphics
  (:use #:common-lisp #:cl-lore.aux-package)
  (:export
   #:access-name
   #:file-name
   #:fundamental-image
   #:has-name-p
   #:raster-image
   #:save-image
   #:vector-image))

(in-package #:cl-user)


(defpackage #:cl-lore.graphics
  (:use #:common-lisp #:serapeum #:alexandria #:iterate) 
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:fundamental-image
   #:vector-image
   #:raster-image
   #:read-name
   #:save-image))

            

(in-package #:cl-user)


(defpackage :cl-lore.html
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate)
  (:shadowing-import-from #:iterate #:collecting
                          #:summing #:in)
  (:export
   #:*class-class
   #:*function-class*
   #:*generic-class*
   #:*macro-class*
   #:*struct-class*
   #:*variable-class*
   #:access-css
   #:escape-text
   #:html-output
   #:html-output-generator
   #:read-images
   #:read-out-stream))

(in-package #:cl-user)


(defpackage :cl-lore.html
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate)
  (:shadowing-import-from #:iterate #:collecting
                          #:summing #:in)
  (:export #:html-output-generator
           #:html-output

           #:read-out-stream
           #:access-css
           #:escape-text

           #:*function-class*
           #:*generic-class*
           #:*class-class
           #:*struct-class*
           #:*macro-class*))



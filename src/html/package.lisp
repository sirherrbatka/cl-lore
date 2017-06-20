(in-package #:cl-user)


(defpackage :cl-lore.html
  (:use #:common-lisp #:serapeum #:alexandria
        #:iterate #:cl-lore.protocol)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:html-output-generator
           #:html-output

           #:read-out-stream
           #:access-css
           #:*mechanics-style*

           #:<mechanics-html-output-generator>))


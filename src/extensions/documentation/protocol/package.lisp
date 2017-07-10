(in-package #:cl-user)


(defpackage :cl-lore.extensions.documentation.protocol
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:lisp-documentation-node
           #:function-node
           #:class-node
           #:struct-node
           #:generic-function-node
           #:macro-node
           #:documentation-node

           #:fundamental-lisp-information
           #:named-lisp-information
           #:standard-lisp-information
           #:record-lisp-information
           #:class-lisp-information
           #:struct-lisp-information
           #:operator-lisp-information
           #:function-lisp-information
           #:macro-lisp-information
           #:generic-function-lisp-information

           #:read-plist
           #:read-docstring
           #:read-name
           #:read-node-type
           #:read-lambda-list))


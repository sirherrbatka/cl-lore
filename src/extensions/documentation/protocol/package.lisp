(in-package #:cl-user)


(defpackage :cl-lore.extensions.documentation.protocol
  (:use #:common-lisp #:cl-lore.aux-package)
  (:export
   #:access-package-name
   #:class-lisp-information
   #:class-node
   #:documentation-node
   #:function-lisp-information
   #:function-node
   #:fundamental-lisp-information
   #:generic-function-lisp-information
   #:generic-function-node
   #:macro-lisp-information
   #:macro-node
   #:make-class-documentation
   #:make-error-documentation
   #:make-function-documentation
   #:make-generic-function-documentation
   #:make-macro-documentation
   #:make-struct-documentation
   #:named-lisp-information
   #:operator-lisp-information
   #:query
   #:read-docstring
   #:read-lambda-list
   #:read-name
   #:read-node-type
   #:read-plist
   #:record-lisp-information
   #:standard-lisp-information
   #:struct-lisp-information
   #:variable-lisp-information
   #:make-variable-node
   #:struct-node
   #:lisp-documentation-node))

(in-package #:cl-user)


(defpackage #:cl-lore.protocol.structure
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:fundamental-node
           #:lisp-documentation-node
           #:leaf-node
           #:tree-node
           #:function-node
           #:class-node
           #:struct-node
           #:generic-function-node
           #:macro-node
           #:titled-tree-node
           #:chunk-node
           #:documentation-node
           #:root-node
           #:has-title
           #:access-label
           #:has-label
           #:has-children
           #:read-traits
           #:push-child

           #:lore-node-class))

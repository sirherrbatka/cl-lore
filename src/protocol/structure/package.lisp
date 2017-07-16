(in-package #:cl-user)


(defpackage #:cl-lore.protocol.structure
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export
   #:access-content
   #:access-label
   #:access-title
   #:chunk-node
   #:class-node
   #:documentation-node
   #:emphasis-trait
   #:function-node
   #:fundamental-node
   #:fundamental-structure-condition
   #:fundamental-trait
   #:generic-function-node
   #:has-children
   #:has-label
   #:has-title
   #:leaf-node
   #:lisp-documentation-node
   #:lore-node-class
   #:map-children
   #:modification-not-allowed
   #:paragraph-trait
   #:push-child
   #:read-children
   #:read-traits
   #:root-node
   #:sequence-node
   #:struct-node
   #:title-trait
   #:titled-tree-node
   #:tree-node))

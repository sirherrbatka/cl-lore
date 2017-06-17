(in-package #:cl-user)


(defpackage :cl-lore.protocol
  (:use #:common-lisp #:serapeum #:alexandria #:iterate)
  (:shadowing-import-from #:iterate #:collecting #:summing #:in)
  (:export #:fundamental-node
           #:leaf-node
           #:tree-node
           #:operator-node
           #:function-node
           #:titled-tree-node
           #:chunk-node
           #:documentation-node
           #:root-node

           #:read-name
           #:read-lambda-list
           #:read-docstring
           #:access-title
           #:access-package-name
           #:access-content

           #:abstract-stack-controller
           #:top-stack-controller
           #:proxy-stack-controller
           #:chunks-collection
           #:fundamenta-stack-controller

           #:fundamental-output-generator
           #:fundamental-output
           #:function-lisp-information
           #:fundamental-lisp-information

           #:fundamental-trait
           #:emphasis-trait
           #:title-trait
           #:paragraph-trait

           #:scan-element
           #:push-decorator
           #:process-element
           #:push-stack
           #:save-output
           #:make-output
           #:add-to-index
           #:before-trait
           #:after-trait
           #:has-childrens
           #:controller-return
           #:controller-push-tree
           #:controller-pop-tree
           #:controller-pop-anything
           #:controller-front
           #:controller-empty-p
           #:has-title
           #:push-chunk
           #:push-child
           #:get-chunk
           #:query

           #:*stack*
           #:*tmp-stack*
           #:*node-definitions*
           #:*register*
           #:*chunks*))

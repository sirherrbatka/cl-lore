(in-package #:cl-lore.extensions.documentation.protocol)


(defclass lisp-documentation-node
    (cl-lore.protocol.structure:fundamental-node)
  ((%information :initarg :information
                 :reader read-information))
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass function-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass macro-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass generic-function-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass class-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass struct-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass documentation-node (cl-lore.protocol.structure:sequence-node)
  ((%package-name :initarg package-name
                  :type string
                  :accessor access-package-name))
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defalias make-function-documentation
  (curry #'make 'function-node
         :information))


(defalias make-macro-documentation
  (curry #'make 'macro-node
         :information))


(defalias make-generic-function-documentation
  (curry #'make 'generic-function-node
         :information))


(defalias make-class-documentation
  (curry #'make 'class-node
         :information))


(defalias make-struct-documentation
  (curry #'make 'struct-node
         :information))

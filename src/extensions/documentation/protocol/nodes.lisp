(in-package #:cl-lore.extensions.documentation.protocol)


(defclass lisp-documentation-node
    (cl-lore.protocol.structure:fundamental-node)
  ((%information :initarg :information
                 :reader read-information))
  (:metaclass cl-lore.protocol:lore-node-class))


(defclass function-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol:lore-node-class))


(defclass macro-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol:lore-node-class))


(defclass generic-function-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol:lore-node-class))


(defclass class-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol:lore-node-class))


(defclass struct-node (lisp-documentation-node)
  ()
  (:metaclass cl-lore.protocol:lore-node-class))


(defclass documentation-node (cl-lore.protocol.structure:tree-node)
  ((%package-name :initarg package-name
                  :type string
                  :accessor access-package-name))
  (:metaclass cl-lore.protocol:lore-node-class))


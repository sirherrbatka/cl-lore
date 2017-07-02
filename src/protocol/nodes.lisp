(in-package #:cl-lore.protocol)


(defclass fundamental-node ()
  ((%decorators :initform (vect)
                :type vector
                :reader read-decorators)
   (%traits :type vector
            :initform (vect)
            :initarg :traits
            :accessor read-traits))
  (:metaclass lore-node-class))


(defclass leaf-node (fundamental-node)
  ((%content :initarg :content
             :accessor access-content))
  (:metaclass lore-node-class))


(defclass lisp-documentation-node (fundamental-node)
  ((%information :initarg :information
                 :reader read-information))
  (:metaclass lore-node-class))


(defclass function-node (lisp-documentation-node)
  ()
  (:metaclass lore-node-class))


(defclass macro-node (lisp-documentation-node)
  ()
  (:metaclass lore-node-class))


(defclass generic-function-node (lisp-documentation-node)
  ()
  (:metaclass lore-node-class))


(defclass class-node (lisp-documentation-node)
  ()
  (:metaclass lore-node-class))


(defclass class-node (lisp-documentation-node)
  ()
  (:metaclass lore-node-class))


(defclass tree-node (fundamental-node)
  ((%children :initform (vect)
              :initarg :children
              :accessor read-children))
  (:metaclass lore-node-class))


(defclass titled-tree-node (tree-node)
  ((%title :initarg :title
           :accessor access-title
           :type leaf-node))
  (:metaclass lore-node-class))


(defclass chunk-node (titled-tree-node)
  ()
  (:metaclass lore-node-class))


(defclass documentation-node (tree-node)
  ((%package-name :initarg package-name
                  :type string
                  :accessor access-package-name))
  (:metaclass lore-node-class))


(defclass root-node (titled-tree-node)
  ()
  (:metaclass lore-node-class))


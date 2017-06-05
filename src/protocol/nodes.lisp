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


(defclass operator-node (fundamental-node)
  ((%name :type symbol
          :initarg :name
          :reader read-name)
   (%lambda-list :type list
                 :initarg :lambda-list
                 :reader read-lambda-list)
   (%docstring :type string
               :initarg :docstring
               :reader read-docstring))
  (:metaclass lore-node-class))


(defclass function-node (operator-node)
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


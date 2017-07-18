(in-package #:cl-lore.protocol.structure)


(defclass fundamental-node ()
  ((%decorators :initform (vect)
                :type vector
                :reader read-decorators)
   (%traits :type vector
            :initform (vect)
            :initarg :traits
            :reader read-traits))
  (:metaclass lore-node-class))


(defclass leaf-node (fundamental-node)
  ((%content :initarg :content
             :accessor access-content))
  (:metaclass lore-node-class))


(defclass tree-node (fundamental-node)
  ()
  (:metaclass lore-node-class))


(defclass sequence-node (tree-node)
  ((%children :initform (vect)
              :initarg :children
              :accessor read-children))
  (:metaclass lore-node-class))


(defclass titled-tree-node (tree-node)
  ((%title :initarg :title
           :accessor access-title
           :type leaf-node))
  (:metaclass lore-node-class))


(defclass chunk-node (titled-tree-node sequence-node)
  ((%label :type string
           :initarg :label
           :accessor access-label))
  (:metaclass lore-node-class))


(defclass root-node (titled-tree-node sequence-node)
  ()
  (:metaclass lore-node-class))


(defclass table-node (sequence-node)
  ()
  (:metaclass lore-node-class))


(defclass table-content ()
  ()
  (:metaclass lore-node-class))


(defclass column-node (sequence-node table-content)
  ()
  (:metaclass lore-node-class))


(defclass row-node (sequence-node table-content)
  ()
  (:metaclass lore-node-class))

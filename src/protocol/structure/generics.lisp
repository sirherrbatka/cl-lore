(in-package #:cl-lore.protocol.structure)


(defgeneric has-title (node)
  (:method ((node leaf-node))
    nil)
  (:method ((node tree-node))
    nil))


(defgeneric has-children (node)
  (:method ((node fundamental-node))
    nil))


(defgeneric has-label (node)
  (:method ((node fundamental-node))
    nil)
  (:method ((node chunk-node))
    (slot-boundp node '%label)))


(defgeneric push-child (node children))


(defgeneric map-children (fn node))


(defgeneric validate (node)
  (:method ((node string))
    t)
  (:method ((node fundamental-node))
    t)
  (:method ((node t))
    (error 'invalid-node-condition
           "Node needs to be either subclass of fundamental-node or a string")))

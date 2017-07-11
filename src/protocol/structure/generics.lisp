(in-package #:cl-lore.protocol.structure)


(defgeneric has-title (node)
  (:method ((node leaf-node))
    nil)
  (:method ((node tree-node))
    nil))


(defgeneric has-children (node)
  (:method ((node leaf-node))
    nil))


(defgeneric has-label (node)
  (:method ((node fundamental-node))
    (slot-boundp node '%label)))


(defgeneric push-child (node children))
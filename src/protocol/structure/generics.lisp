(in-package #:cl-lore.protocol.structure)


(defgeneric has-title (node)
  (:method ((node leaf-node))
    nil)
  (:method ((node tree-node))
    nil))


(defgeneric has-childrens (node)
  (:method ((node leaf-node))
    nil))

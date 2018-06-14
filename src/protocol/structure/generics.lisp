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
  (:method ((node string)) nil)
  (:method ((node fundamental-node)) nil)
  (:method ((node symbol)) nil)
  (:method ((node list)) nil)
  (:method (node)
    (error 'invalid-node-condition
           :text (format nil "Can't use type ~a because it is not fundamental-node, symbol or string"
                         (type-of node))))
  (:method ((node tree-node))
    (map-children #'validate node)))

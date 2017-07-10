(in-package #:cl-lore.protocol.structure)


(defmethod has-title ((node chunk-node))
  (slot-boundp node '%title))


(defmethod push-child  ((node tree-node) (children fundamental-node))
  (vector-push-extend children (read-children node)))


(defmethod push-child  ((node tree-node) (children string))
  (vector-push-extend children (read-children node)))


(defmethod has-children ((tree tree-node))
  (emptyp (read-children tree)))

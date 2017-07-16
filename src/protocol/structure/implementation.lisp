(in-package #:cl-lore.protocol.structure)


(defmethod has-title ((node chunk-node))
  (slot-boundp node '%title))


(defmethod push-child  ((node sequence-node) (children fundamental-node))
  (vector-push-extend children (read-children node)))


(defmethod push-child  ((node sequence-node) (children string))
  (vector-push-extend children (read-children node)))


(defmethod has-children ((tree sequence-node))
  (emptyp (read-children tree)))


(defmethod map-children (fn (node sequence-node))
  (map nil
       fn
       (read-children node)))

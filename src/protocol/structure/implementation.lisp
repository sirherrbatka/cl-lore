(in-package #:cl-lore.protocol.structure)


(defmethod has-title ((node chunk-node))
  (slot-boundp node '%title))


(defmethod push-child ((node sequence-node) (child fundamental-node))
  (vector-push-extend child (read-children node)))


(defmethod push-child ((node sequence-node) (child string))
  (vector-push-extend child  (read-children node)))


(defmethod push-child :before ((node fundamental-node) child)
  (validate child)
  (validate node))


(defmethod has-children ((tree sequence-node))
  (emptyp (read-children tree)))


(defmethod map-children (fn (node sequence-node))
  (map nil
       fn
       (read-children node)))


(defmethod validate ((node table-node))
  (unless (every #'table-content-p
                 (read-children node))
    (error 'invalid-node-condition
           "Trying to construct table with invalid content")))

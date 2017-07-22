(in-package #:cl-lore.protocol.structure)


(defmethod has-title ((node chunk-node))
  (slot-boundp node '%title))


(defmethod push-child ((node sequence-node) (child fundamental-node))
  (vector-push-extend child (read-children node)))


(defmethod push-child ((node sequence-node) (child string))
  (vector-push-extend child  (read-children node)))


(defmethod push-child :before ((node sequence-node) child)
  (validate child))


(defmethod push-child :after ((node sequence-node) child)
  (validate node))


(defmethod has-children ((tree sequence-node))
  (emptyp (read-children tree)))


(defmethod map-children (fn (node sequence-node))
  (map nil
       fn
       (read-children node)))


(defmethod validate ((node table-node))
  (unless (every (rcurry #'typep 'table-content)
                 (read-children node))
    (error 'invalid-node-condition
           :text "Trying to construct table with invalid content"))
  (unless (~> (iterate
                (for c in-vector (read-children node))
                (for type = (typecase c
                              (row-node 'row-node)
                              (column-node 'column-node)))
                (for p-type previous type)
                (always (or (null p-type)
                            (eq p-type type)))))
    (error 'invalid-node-condition
           :text "Trying to construct table with invalid content")))

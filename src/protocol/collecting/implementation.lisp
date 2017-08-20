(in-package #:cl-lore.protocol.collecting)


(defmethod push-chunk ((chunks chunks-collection)
                       (chunk cl-lore.protocol.structure:chunk-node))
  (with-accessors ((label cl-lore.protocol.structure:access-label)) chunk
    (unless (null (gethash label (read-content chunks)))
      (warn (concat "Chunk with label " label " already present!")))
    (setf (gethash label
                   (read-content chunks))
          chunk)))


(defmethod get-chunk ((chunks chunks-collection)
                      (label string))
  (multiple-value-bind (result found) (gethash label (read-content chunks))
    (unless found
      (error 'no-chunk-with-label-condition
             (concat "no chunk with label: "
                     label)))
    result))


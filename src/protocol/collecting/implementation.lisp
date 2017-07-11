(in-package #:cl-lore.protocol.collecting)


(defmethod push-chunk ((chunks chunks-collection)
                       (chunk cl-lore.protocol.structure:chunk-node))
  (setf (gethash (cl-lore.protocol.structure:access-label chunk)
                 (read-content chunks))
        chunk))


(defmethod get-chunk ((chunks chunks-collection)
                      (label string))
  (gethash label (read-content chunks)))


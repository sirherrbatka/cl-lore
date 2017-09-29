(in-package #:cl-lore.extensions.sequence-graphs.api)


(defun make-sequence-node (axis input)
  (make 'cl-lore.extensions.sequence-graphs.protocol:sequence-node
        :content (cl-lore.extensions.sequence-graphs.graphics:make-context
                  (mapcar #'cl-lore.extensions.sequence-graphs.graphics:make-axis
                          axis)
                  input)))

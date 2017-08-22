(in-package #:cl-lore.extensions.sequence-graphs.protocol)


(defun make-sequence-node (axis input)
  (make 'sequence-node
        :content (cl-lore.extensions.sequence-graphs.graphics:make-context
                  (mapcar #'cl-lore.extensions.sequence-graphs.graphics:make-axis
                          axis)
                  input)))

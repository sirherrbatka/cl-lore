(in-package #:cl-lore)


(defun make-section (&rest initargs)
  (apply #'make 'tree-node initargs))

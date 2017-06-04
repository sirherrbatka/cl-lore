(in-package #:cl-lore)


(defun make-section (&rest initargs)
  (apply #'make 'chunk-node initargs))

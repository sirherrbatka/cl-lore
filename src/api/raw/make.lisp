(in-package #:cl-lore.api.raw)


(defun make-chunk (&rest initargs)
  (apply #'make 'chunk-node initargs))


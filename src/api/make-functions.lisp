(in-package #:cl-lore.api)


(defun make-section (&rest initargs)
  (apply #'make 'chunk-node initargs))


(defun make-documentation-section ()
  (make 'documentation-node))


(defun make-function-documentation (data)
  (make 'function-node
        :information data))

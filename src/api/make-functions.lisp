(in-package #:cl-lore.api)


(defun make-section (&rest initargs)
  (apply #'make 'chunk-node initargs))


(defun make-documentation-section ()
  (make 'documentation-node))


;;TODO implement!
(defun make-function-documentation-node (data)
  (make 'function-node))


(defun make-function-documentation (data)
  (let ((result (make 'tree-node)))
    (iterate
      (for node in-vector data)
      (push-child result
                  (make-function-documentation-node node)))
    result))

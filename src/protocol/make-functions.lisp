(in-package #:cl-lore)


(defun make-section (&rest initargs)
  (apply #'make 'chunk-node initargs))


(defun make-documentation-section ()
  (make 'documentation-node))


(defun make-function-documentation-node (data)
  (make 'function-node
        :lambda-list (docparser:operator-lambda-list data)
        :docstring (docparser:node-docstring data)
        :name (docparser:node-name data)))


(defun make-function-documentation (data)
  (let ((result (make 'tree-node)))
    (iterate
      (for node in-vector data)
      (push-child result
                  (make-function-documentation-node node)))
    result))

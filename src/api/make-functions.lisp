(in-package #:cl-lore.api)


(defun make-section (&rest initargs)
  (apply #'make 'chunk-node initargs))


(defun make-documentation-section ()
  (make 'documentation-node))


(defun make-function-documentation (data)
  (make 'function-node
        :information data))


(defun make-generic-function-documentation (data)
  (make 'generic-function-node
        :information data))


(defun make-macro-documentation (data)
  (make 'macro-node
        :information data))


(defun make-class-documentation (data)
  (make 'class-node
        :information data))


(defun make-struct-documentation (data)
  (make 'struct-node
        :information data))

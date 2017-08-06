(in-package #:cl-lore.api.raw)


(defun make-chunk (&rest initargs)
  (apply #'make 'cl-lore.protocol.structure:chunk-node initargs))


(defun make-node (descriptor &rest initargs)
  (let ((function (gethash (string-downcase descriptor)
                           *node-definitions*)))
    (when (null function)
      (error 'node-construction-error
             "Descriptor ~a does not reference any node in the *node-definitions*"
             descriptor))
    (apply function initargs)))


(defun make-root (&rest initargs)
  (apply #'make 'cl-lore.protocol.structure:root-node
         initargs))


(defun make-leaf (content &rest traits)
  (make 'cl-lore.protocol.structure:leaf-node
        :content content
        :traits (coerce traits 'vector)))


(defun make-tree (&rest traits)
  (make 'cl-lore.protocol.structure:tree-node
        :traits (coerce traits 'vector)))


(defun make-sequence-node (&rest traits)
  (make 'cl-lore.protocol.structure:sequence-node
        :traits (coerce traits 'vector)))


(defun make-table (&rest traits)
  (make 'cl-lore.protocol.structure:table-node
        :traits (coerce traits 'vector)))


(defun make-row (&rest traits)
  (make 'cl-lore.protocol.structure:row-node
        :traits (coerce traits 'vector)))


(defun make-column (&rest traits)
  (make 'cl-lore.protocol.structure:column-node
        :traits (coerce traits 'vector)))


(defun make-title-row (&rest traits)
  (make 'cl-lore.protocol.structure:title-row-node
        :traits (coerce traits 'vector)))


(defun make-lore-list (&rest traits)
  (make 'cl-lore.protocol.structure:list-node
        :traits (coerce traits 'vector)))


(defun make-item (content &rest traits)
  (make 'cl-lore.protocol.structure:item-node
        :content content
        :traits (coerce traits 'vector)))

(in-package #:cl-lore.extensions.documentation.protocol)


(defun get-arg-list (fun)
  (arg:arglist fun))


(defgeneric assigned-information-type (docstample)
  (:method ((n (eql :function)))
    'function-lisp-information)
  (:method ((n (eql :generic)))
    'generic-function-lisp-information)
  (:method ((n (eql :macro)))
    'macro-lisp-information)
  (:method ((n (eql :class)))
    'class-lisp-information)
  (:method ((n (eql :struct)))
    'struct-lisp-information)
  (:method ((n (eql :error)))
    'error-lisp-information))


(defgeneric lore-type-to-lisp-type (type)
  (:method ((type (eql :class))) 'type)
  (:method ((type (eql :struct))) 'structure)
  (:method ((type (eql :macro))) 'function)
  (:method ((type (eql :generic))) 'function)
  (:method ((type (eql :condition))) 'type)
  (:method ((type (eql :error))) 'type)
  (:method ((type (eql :function))) 'function))


(defun query (type name)
  (let ((lisp-documentation-type (lore-type-to-lisp-type type)))
    (multiple-value-bind (docs found)
        (docs.ext:find-documentation lisp-documentation-type
                                     name)
      (make-instance (assigned-information-type type)
                     :name name
                     :content (if found
                                  docs
                                  (documentation name
                                                 lisp-documentation-type))))))

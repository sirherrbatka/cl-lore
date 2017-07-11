(in-package #:cl-lore.api)



(def-syntax docfun (id)
  (declare (type (or symbol list) id))
  (let ((data (query *chunks*
                     docstample:<function>
                     id)))
    (ret (make-function-documentation data))))


(def-syntax docgeneric (id)
  (declare (type (or symbol list) id))
  (let ((data (query *chunks*
                     docstample:<generic>
                     id)))
    (ret (make-generic-function-documentation data))))


(def-syntax docmacro (id)
  (declare (type (or symbol list) id))
  (let ((data (query *chunks*
                     docstample:<macro>
                     id)))
    (ret (make-macro-documentation data))))


(def-syntax docclass (id)
  (declare (type symbol id))
  (let ((data (query *chunks*
                     docstample:<class>
                     id)))
    (ret (make-class-documentation data))))


(def-syntax docstruct (id)
  (declare (type symbol id))
  (let ((data (query *chunks*
                     docstample:<struct>
                     id)))
    (ret (make-struct-documentation data))))



(defun symb (symbol-name))


(defgeneric refer (from text))


(defun label (name)
  (declare (type string name))
  (push-decorator *register*
                  (make 'label
                        :name name)))


(defun pack (name)
  (declare (type string name))
  "Set PACKAGE for documentation section."
  (setf (access-package-name *register*)
        name))

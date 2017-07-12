(in-package #:cl-lore.extensions.documentation.protocol)


(defun get-arg-list (fun)
  (swank-backend:arglist fun))


(defmacro with-docstring-plist ((index type id) &body body)
  (once-only (index type id)
    `(let* ((docstring (documentation
                        ,id
                        (docstample:read-symbol ,type)))
            (plist
              (if (null ,index)
                  nil
                  (when-let ((plist (docstample:query-node
                                     ,index
                                     ,type
                                     ,id)))
                    (docstample:access-forms plist)))))
       ,@body)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:function-node)
     id)
  (with-docstring-plist (index type id)
    (make 'function-lisp-information
          :node-type type
          :lambda-list (get-arg-list id)
          :plist plist
          :name id
          :docstring docstring)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:generic-node)
     id)
  (with-docstring-plist (index type id)
    (make 'generic-function-lisp-information
          :node-type type
          :lambda-list (get-arg-list id)
          :plist plist
          :name id
          :docstring docstring)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:macro-node)
     id)
  (with-docstring-plist (index type id)
    (make 'macro-lisp-information
          :node-type type
          :lambda-list (get-arg-list id)
          :plist plist
          :name id
          :docstring docstring)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:class-node)
     (id symbol))
  (with-docstring-plist (index type id)
    (make 'class-lisp-information
          :node-type type
          :name id
          :plist plist
          :docstring docstring)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:struct-node)
     (id symbol))
  (with-docstring-plist (chunks type id)
    (make 'struct-lisp-information
          :node-type type
          :name id
          :plist plist
          :docstring docstring)))

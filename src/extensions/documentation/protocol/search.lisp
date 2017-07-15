(in-package #:cl-lore.extensions.documentation.protocol)


(defun get-arg-list (fun)
  (arg:arglist fun))


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


(defgeneric assigned-information-type (docstample)
  (:method ((n docstample:function-node))
    'function-lisp-information)
  (:method ((n docstample:generic-node))
    'generic-function-lisp-information)
  (:method ((n docstample:macro-node))
    'macro-lisp-information)
  (:method ((n docstample:class-node))
    'class-lisp-information)
  (:method ((n docstample:struct-node))
    'struct-lisp-information))


(defgeneric query (index type id))


(defmethod query
    ((index (eql nil))
     (type docstample:operator-node)
     id)
  (with-docstring-plist (index type id)
    (make (assigned-information-type type)
          :node-type type
          :lambda-list (get-arg-list id)
          :plist plist
          :name id
          :docstring docstring)))


(defmethod query
    ((index (eql nil))
     (type docstample:record-node)
     (id symbol))
  (with-docstring-plist (index type id)
    (make (assigned-information-type type)
          :node-type type
          :name id
          :plist plist
          :docstring docstring)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:operator-node)
     id)
  (with-docstring-plist (index type id)
    (make (assigned-information-type type)
          :node-type type
          :lambda-list (get-arg-list id)
          :plist plist
          :name id
          :docstring docstring)))


(defmethod query
    ((index docstample:fundamental-accumulator)
     (type docstample:record-node)
     (id symbol))
  (with-docstring-plist (index type id)
    (make (assigned-information-type type)
          :node-type type
          :name id
          :plist plist
          :docstring docstring)))


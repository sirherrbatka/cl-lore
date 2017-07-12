(in-package #:cl-lore.extensions.documentation.protocol)


;; (defmacro with-docstring-plist ((chunks type id) &body body)
;;   (with-gensyms (!index)
;;     (once-only (chunks type id)
;;       `(let* ((,!index (read-docstample-index ,chunks))
;;               (docstring (documentation
;;                           ,id
;;                           (docstample:read-symbol ,type)))
;;               (plist
;;                 (if (null ,!index)
;;                     nil
;;                     (when-let ((plist (docstample:query-node
;;                                        ,!index
;;                                        ,type
;;                                        ,id)))
;;                       (docstample:access-forms plist)))))
;;          ,@body))))


;; (defmethod cl-lore.protocol.collecting:query
;;     ((chunks chunks-collection)
;;      (type docstample:function-node)
;;      id)
;;   (with-docstring-plist (chunks type id)
;;     (make 'function-lisp-information
;;           :node-type type
;;           :lambda-list (get-arg-list id)
;;           :plist plist
;;           :name id
;;           :docstring docstring)))


;; (defmethod cl-lore.protocol.collecting:query
;;     ((chunks chunks-collection)
;;      (type docstample:generic-node)
;;      id)
;;   (with-docstring-plist (chunks type id)
;;     (make 'generic-function-lisp-information
;;           :node-type type
;;           :lambda-list (get-arg-list id)
;;           :plist plist
;;           :name id
;;           :docstring docstring)))


;; (defmethod cl-lore.protocol.collecting:query
;;     ((chunks chunks-collection)
;;      (type docstample:macro-node)
;;      id)
;;   (with-docstring-plist (chunks type id)
;;     (make 'macro-lisp-information
;;           :node-type type
;;           :lambda-list (get-arg-list id)
;;           :plist plist
;;           :name id
;;           :docstring docstring)))


;; (defmethod cl-lore.protocol.collecting:query
;;     ((chunks chunks-collection)
;;      (type docstample:class-node)
;;      (id symbol))
;;   (with-docstring-plist (chunks type id)
;;     (make 'class-lisp-information
;;           :node-type type
;;           :name id
;;           :plist plist
;;           :docstring docstring)))


;; (defmethod cl-lore.protocol.collecting:query
;;     ((chunks chunks-collection)
;;      (type docstample:struct-node)
;;      (id symbol))
;;   (with-docstring-plist (chunks type id)
;;     (make 'struct-lisp-information
;;           :node-type type
;;           :name id
;;           :plist plist
;;           :docstring docstring)))

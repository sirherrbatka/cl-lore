(in-package #:cl-lore)


(defmethod scan-element ((output fundamental-output) (element section-node) parents)
  (add-to-index output element parents)
  (call-next-method))


(defmethod scan-element ((output fundamental-output) (element tree-node) parents)
  (let ((parents (cons element section-node)))
    (iterate:iter
      (for elt in-vector (read-children))
      (scan-element output elt parents)))
  output)


(defmethod process-element ((generator fundamental-generator) (output fundamental-output) (element section-node) parents)
  (process-element generator output (access-title element) (cons element parents))
  (call-next-method))


(defmethod process-element ((generator fundamental-generator) (output fundamental-output) (element tree-node) parents)
  (let ((parents (cons element section-node)))
    (iterate:iter
      (for elt in-vector (read-children))
      (scan-element output elt parents)))
  output)


(defmethod scan-element ((output fundamental-output) (element fundamental-decorator) parents)
  (scan-element output (access-content element) parents))


(defmethod process-element ((generator fundamental-generator) (output fundamental-output) (element fundamental-decorator) parents)
  (process-element generator output (access-content element) parents))


(defmethod push-children ((node tree-node) (children fundamental-element))
  (vector-push-extend children (read-children node)))


(defmethod push-stack ((desc string) (obj tree-node) (stack stack-box))
  (push (list* desc obj) (access-content stack))
  stack)


(defmethod pop-stack ((stack stack-box))
  (with-accessors ((content access-content)) stack
    (when (null content)
      (error "Can't pop empty stack!"))
    (let ((result (pop content)))
      (values (cdr result)
              (car result)))))


(defmethod front-stack ((Stack stack-box))
  (with-accessors ((content access-content)) stack
    (when (null content)
      (error "Can't access front in empty stack!"))
    (let ((result (first content)))
      (values (cdr result)
              (car result)))))


(defmethod process-element ((generator fundamental-generator) (output fundamental-output) (element leaf-node) parents)
  (let (())))


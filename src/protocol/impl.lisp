(in-package #:cl-lore)


(defun find-in-tree (tree parent &key test)
  (labels ((impl (rest path)
             (if (atom rest)
                 (when (funcall test rest parent)
                   (rest path))
                 (or (impl (car rest) (cons (car rest) path))
                     (dolist (r (cadr rest))
                       (let ((result (impl r (cons r path))))
                         (unless (null result)
                           (return result))))))))
    (dolist (elt tree)
      (let ((result (impl elt (list elt tree))))
        (unless (null result)
          (return result))))))


(defun insert-into-tree (tree parent element &key test)
  (let ((path (find-in-tree tree parent :test test)))
    (if (null path)
        (list (list parent (list element)))
        (reduce (lambda (prev next)
                  (serapeum:nlet before ((list (if (atom (car next))
                                                   (cadr next)
                                                   next))
                                         (ac nil))
                    (if (and (listp (car list))
                             (funcall test (caar list) (car prev)))
                        (let ((result (append (nreverse ac) (cons prev (cdr list)))))
                          (if (atom (car next))
                              (list (car next) result)
                              result))
                        (before (cdr list) (cons (car list) ac)))))
                (cdr path)
                :initial-value (list parent (reverse (cons element (cadar path))))))))


(defmethod scan-element ((output fundamental-output) (element section-node) parents)
  (add-to-index output element parents)
  (call-next-method))


(defmethod scan-element ((output fundamental-output) (element tree-node) parents)
  (let ((parents (cons element section-node)))
    (iterate:iter
      (for elt in-vector (read-children))
      (scan-element output elt parents)))
  output)


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element section-node)
                            parents)
  (process-element generator output (access-title element) (cons element parents))
  (call-next-method))


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element tree-node)
                            parents)
  (let ((parents (cons element section-node)))
    (iterate:iter
      (for elt in-vector (read-children))
      (scan-element output elt parents)))
  output)


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element fundamental-decorator)
                            parents)
  (process-element generator output (access-content element) parents))


(defmethod push-child  ((node tree-node) (children fundamental-element))
  (vector-push-extend children (read-children node)))


(defmethod push-child  ((node tree-node) (children string))
  (vector-push-extend children (read-children node)))


(defmethod merge-into-parent-stack ((stack temporary-stack-box))
  (with-accessors ((content access-content)
                   (parent read-parent-stack)
                   (callback read-decorator-callback)
                   (children read-children)) stack
    (iterate
      (for child in-vector children)
      (push-child parent child))
    (let ((stack-content (reverse content)))
      (dolist (elt stack-content)
        (push-stack (car elt)
                    (funcall callback (cdr elt))
                    parent)))
    stack))


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element leaf-node)
                            parents)
  (let ((data (access-content element)))
    (process-element generator output element parents)))


(defmethod process-element :before ((generator fundamental-output-generator)
                                    (output fundamental-output)
                                    (element leaf-node)
                                    parents)
  (dolist (trait (access-traits element))
    (before-trait generator output trait parents)))


(defmethod process-element :after ((generator fundamental-output-generator)
                                   (output fundamental-output)
                                   (element leaf-node)
                                   parents)
  (dolist (trait (access-traits element))
    (after-trait generator output trait parents)))


(defmethod has-children ((tree tree-node))
  (emptyp (read-children tree)))


(defmethod controller-return ((controller abstract-stack-controller) value)
  (let ((tree (controller-front controller)))
    (push-child tree value))
  (setf *register* value)
  value)


(defmethod controller-push-tree ((controller abstract-stack-controller) (description string) (value tree-node))
  (with-accessors ((content access-stack)) controller
    (push (list* description value) content))
  controller)


(defmethod controller-return ((controller proxy-stack-controller) value)
  (with-accessors ((content access-stack)
                   (parent read-parent)
                   (callback read-callback)) controller
    (let ((value (funcall callback value)))
      (if (slot-boundp controller '%parent)
          (controller-return parent value)
          (setf *register* value)))))


(defmethod controller-push-tree ((controller proxy-stack-controller) (description string) (value tree-node))
  (with-accessors ((content access-stack)
                   (parent read-parent)
                   (callback read-callback)) controller
    (unless (slot-boundp controller '%parent)
      (error "Stack controller does not grant access to stack"))
    (let ((value (funcall callback value)))
      (controller-push-tree parent description value))
    controller))


(defmethod controller-pop-tree ((controller abstract-stack-controller))
  (with-accessors ((content access-stack)) controller
    (when (null content)
      (error "Can't pop empty stack!"))
    (let ((result (pop content)))
      (values (cdr result)
              (car result)))))


(defmethod controller-pop-tree ((controller proxy-stack-controller))
  (with-accessors ((parent read-parent)) controller)
  (unless (slot-boundp controller '%parent)
    (error "Stack controller does not grant access to stack"))
  (controller-pop-tree parent))


(defmethod controller-empty-p ((controller abstact-stack-controller))
  (if (slot-boundp controller '%parent)
      (controller-empty-p (read-parent controller))
      t))


(defmethod controller-front ((controller abstract-stack-controller))
  (with-accessors ((content access-stack)) controller
    (when (null content)
      (error "Can't access front in empty stack!"))
    (let ((result (first content)))
      (values (cdr result)
              (car result)))))


(defmethod controller-front ((controller proxy-stack-controller))
  (unless (slot-boundp controller '%parent)
    (error "Stack controller does not grant access to stack"))
  (controller-front (read-parent controller)))


(defmethod push-decorator ((element fundamental-element) (decorator fundamental-decorator))
  (vector-push-extend decorator (read-decorators element))
  element)


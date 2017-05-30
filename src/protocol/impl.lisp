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


(defmethod scan-element ((output fundamental-output)
                         (element fundamental-decorator)
                         parents)
  (scan-element output (access-content element) parents))


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element fundamental-decorator)
                            parents)
  (process-element generator output (access-content element) parents))


(defmethod push-children ((node tree-node) (children fundamental-element))
  (vector-push-extend children (read-children node)))


(defmethod push-children ((node tree-node) (children string))
  (vector-push-extend children (read-children node)))


(defmethod push-children ((stack stack-box) children)
  (let ((elt (front-stack stack)))
    (push-children elt children)))


(defmethod push-stack ((desc string)
                       (obj tree-node)
                       (stack stack-box))
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


(defmethod process-element :after  ((generator fundamental-output-generator)
                                    (output fundamental-output)
                                    (element leaf-node)
                                    parents)
  (dolist (trait (access-traits element))
    (after-trait generator output trait parents)))


(defmethod empty-stack-p ((stack stack-box))
  (null (access-content stack)))


(defmethod has-children ((tree tree-node))
  (emptyp (read-children tree)))

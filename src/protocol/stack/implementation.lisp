(in-package #:cl-lore.protocol.stack)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Implementation for basic controller.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmethod controller-push-tree ((controller abstract-stack-controller)
                                 (description string)
                                 (value cl-lore.protocol.structure:tree-node))
  (with-accessors ((content access-stack)) controller
    (push (list* description value) content))
  controller)


(defmethod controller-pop-tree ((controller abstract-stack-controller)
                                (description string))
  (with-accessors ((content access-stack)) controller
    (when (null content)
      (error 'invalid-stack-state "Can't pop empty stack!"))
    (let ((result (pop content)))
      (unless (string= description (car result))
        (error 'invalid-stack-state
               "Wanted to pop ~a but last element on stack is ~a"
               description
               (car result)))
      (values (cdr result)
              (car result)))))


(defmethod controller-pop-anything ((controller abstract-stack-controller))
  (with-accessors ((content access-stack)) controller
    (when (null content)
      (error 'invalid-stack-state "Can't pop empty stack!"))
    (let ((result (pop content)))
      (values (cdr result)
              (car result)))))


(defmethod controller-empty-p ((controller abstract-stack-controller))
  (endp (access-stack controller)))


(defmethod controller-front ((controller abstract-stack-controller))
  (with-accessors ((content access-stack)) controller
    (when (null content)
      (error 'invalid-stack-state "Can't access front in empty stack!"))
    (let ((result (first content)))
      (values (cdr result)
              (car result)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Implementation for nil controller. Usually simply signals condition.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defmethod controller-push-tree ((controller (eql nil))
                                 (description string)
                                 (value cl-lore.protocol.structure:tree-node))
  (error 'stack-operation-not-allowed "Stack operation is not allowed"
         :operation 'controller-push-tree))


(defmethod controller-pop-tree ((controller (eql nil))
                                (description string))
  (error 'stack-operation-not-allowed "Stack operation is not allowed"
         :operation 'controller-pop-tree))


(defmethod controller-pop-anything ((controller (eql nil)))
  (error 'stack-operation-not-allowed "Stack operation is not allowed"
         :operation 'controller-pop-anything))


(defmethod controller-empty-p ((controller (eql nil)))
  t)


(defmethod controller-front ((controller (eql nil)))
  (error 'stack-operation-not-allowed "Stack operation is not allowed"
         :operation 'controller-front))


(defmethod controller-return ((controller abstract-stack-controller) value)
  (let ((tree (controller-front controller)))
    (cl-lore.protocol.structure:push-child tree value))
  value)


(defmethod controller-return ((controller top-stack-controller) value)
  (if (cl-lore.protocol.stack:controller-empty-p controller)
      value
      (call-next-method)))


(defmethod controller-return ((controller (eql nil)) value)
  value)


(in-package #:cl-lore.api.raw)


(defmethod cl-lore.protocol.stack:controller-return
    :after ((controller cl-lore.protocol.stack:fundamental-stack-controller)
            value)
  (setf *register* value))


(defmethod cl-lore.protocol.stack:controller-push-tree
    :after ((controller cl-lore.protocol.stack:fundamental-stack-controller)
            description
            value)
  (setf *register* value))


(defmethod cl-lore.protocol.stack:controller-return ((controller (eql nil)) value)
  (setf *register* value)
  (call-next-method))


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


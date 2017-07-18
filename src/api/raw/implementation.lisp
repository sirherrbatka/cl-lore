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


(defmethod :after cl-lore.protocol.stack:controller-return
    ((controller (eql nil)) value)
  (setf *register* value))


(in-package #:cl-lore.api.raw)


(defmethod cl-lore.protocol.stack:controller-push-tree
    :after ((controller cl-lore.protocol.stack:fundamental-stack-controller)
            description
            value)
  (setf *register* value))


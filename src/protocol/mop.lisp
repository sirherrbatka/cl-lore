(in-package :cl-lore.protocol)


(defclass lore-node-class (closer-mop:standard-class)
  ())


(defmethod (setf closer-mop:slot-value-using-class) (new-value (class lore-node-class) object slotd)
  (when (slot-boundp object (closer-mop:slot-definition-name slotd))
    (error "Can't set slot value of node multiple times!"))
  (call-next-method))


(defmethod closer-mop:validate-superclass ((class lore-node-class) superclass)
  t)

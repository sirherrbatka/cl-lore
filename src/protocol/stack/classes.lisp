(in-package #:cl-lore.protocol.stack)


(defclass fundamental-stack-controller ()
  ())


(defclass abstract-stack-controller (fundamental-stack-controller)
  ((%stack :initform nil
           :accessor access-stack
           :type list)))


(defclass top-stack-controller (abstract-stack-controller)
  ())

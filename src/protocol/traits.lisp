(in-package #:cl-lore.protocol)


(defclass fundamental-trait ()
  ())


(defclass emphasis-trait (fundamental-trait)
  ())


(defclass title-trait (fundamental-trait)
  ())


(defclass paragraph-trait (fundamental-trait)
  ((%title :initarg :title
           :accessor access-title
           :type leaf-node))
  (:metaclass lore-node-class))


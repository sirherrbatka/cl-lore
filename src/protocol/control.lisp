(in-package #:cl-lore.protocol)


(defclass abstract-stack-controller (fundamental-stack-controller)
  ((%stack :initform nil
           :accessor access-stack
           :type list)))


(defclass top-stack-controller (abstract-stack-controller)
  ((%count :initform 0
           :accessor access-count
           :type positive-fixnum)))


(defclass proxy-stack-controller (fundamental-stack-controller)
  ((%parent :initarg :parent
            :type fundamental-stack-controller
            :reader read-parent)
   (%callback :initarg :callback
              :type (-> (t) t)
              :reader read-callback)))


(defclass chunks-collection ()
  ((%content :initform (make-hash-table :test 'equal)
             :reader read-content
             :type hash-table)
   (%doctample-index :initarg :docstample-index
                     :initform nil
                     :reader read-docstample-index)))


(defclass fundamental-stack-controller ()
  ())

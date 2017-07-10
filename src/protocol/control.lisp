(in-package #:cl-lore.protocol)



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


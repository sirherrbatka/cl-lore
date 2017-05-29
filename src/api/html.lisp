(in-package #:cl-lore)


(defclass html-output (fundamental-output)
  ((%files :initform nil
           :type list
           :initarg :files
           :accessor access-file)))


(defclass html-output-generator (fundamental-output-generator)
  ())


(defmethod make-output ((generator fundamental-output-generator) &rest initargs)
  (apply #'make-instance 'html-output initargs))

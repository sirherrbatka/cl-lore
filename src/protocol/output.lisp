(in-package #:cl-lore.protocol)


(defclass fundamental-output-generator (docstample:fundamental-generator)
  ())


(defclass fundamental-output (docstample:fundamental-output)
  ((%index :type list
           :initarg :index
           :initform nil
           :accessor access-index)
   (%labels :initform (make-hash-table :test 'equal)
            :reader read-labels)))


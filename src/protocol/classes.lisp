(in-package #:cl-lore)


(defclass fundamental-decorator ()
  ())


(defclass label (fundamental-decorator)
  ((%name :initarg :name
          :accessor access-name
          :type string)))


(defclass internal-reference (fundamental-decorator)
  ((%label-name :initarg :label-name
                :type string
                :accessor access-label-name)))


(defclass file ()
  ((%content :initarg :content
             :accessor access-content)
   (%path :initarg :path
          :accessor access-path)))

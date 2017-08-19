(in-package #:cl-lore.graphics)


(defclass fundamental-image ()
  ((%name :type string
          :initarg :name
          :documentation "Unique name for saved file."
          :accessor access-name)))


(defclass vector-image (fundamental-image)
  ())


(defclass raster-image (fundamental-image)
  ())


(defgeneric save-image (image path))


(defgeneric file-name (image))


(defgeneric has-name-p (image)
  (:method ((image fundamental-image))
    (slot-boundp image '%name)))

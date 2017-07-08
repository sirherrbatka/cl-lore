(in-package #:cl-lore.graphics)


(defclass fundamental-image ()
  ((%name :type string
          :initarg :name
          :documentation "Unique name for saved file."
          :reader read-name)))


(defclass vector-image (fundamental-image)
  ())


(defclass raster-image (fundamental-image)
  ())


(defgeneric save-image (image path))

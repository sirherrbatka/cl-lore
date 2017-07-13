(in-package #:cl-lore.html)


(defclass html-output-generator (cl-lore.protocol.output:fundamental-output-generator)
  ())


(defclass html-output (cl-lore.protocol.output:fundamental-output)
  ((%out-stream :initform (make-string-output-stream)
                :reader read-out-stream)
   (%css :type list
         :accessor access-css
         :initarg :css
         :initform nil)
   (%images :type vector
            :initform (vect)
            :reader read-images)))


(defmethod cl-lore.protocol.output:add-image
    ((output html-output)
     (image cl-lore.graphics:fundamental-image))
  (vector-push-extend image (read-images output))
  output)

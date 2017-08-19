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
   (%image-name :type positive-integer
                :initarg :image-name
                :initform 1
                :accessor access-image-name)
   (%images :type vector
            :initform (vect)
            :reader read-images)))


(defmethod cl-lore.protocol.output:add-image
    ((output html-output)
     (image cl-lore.graphics:fundamental-image))
  (vector-push-extend image (read-images output))
  output)


(-> new-unique-name (html-output) string)
(defun new-unique-name (output)
  (with-accessors ((name access-image-name)) output
    (prog1
        (format nil "~a" name)
      (incf name))))


(defmethod cl-lore.protocol.output:add-image
    :after ((output html-output)
            (image cl-lore.graphics:fundamental-image))
  (unless (cl-lore.graphics:has-name-p image)
    (setf (cl-lore.graphics:access-name image)
          (new-unique-name output))))

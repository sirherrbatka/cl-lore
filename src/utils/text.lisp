(in-package #:cl-lore.utils)


(defun escape-text (obj)
  (cl-who:escape-string (format nil "~:a" obj)))



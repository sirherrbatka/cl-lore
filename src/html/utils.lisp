(in-package #:cl-lore.html)


(defun escape-text (obj)
  (cl-who:escape-string (format nil "~:a" obj)))



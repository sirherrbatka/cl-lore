(in-package #:cl-lore.mechanics)


(defclass mechanics-html-output-generator
    (cl-lore.html:html-output-generator)
  ())


(defclass mechanics-html-output (cl-lore.html:html-output)
  ((%files-stack :initform nil
                 :initarg :files-stack
                 :accessor access-files-stack
                 :type list)
   (%files :initform nil
           :accessor access-files
           :type list)
   (%file-number :initform 0
                 :accessor access-file-number
                 :type non-negative-integer)))


(defmethod read-out-stream ((output mechanics-html-output))
  (let ((files-stack (access-files-stack output)))
    (if (endp files-stack)
        (call-next-method)
        (cdr (first files-stack)))))


(defgeneric add-another-file (output)
  (:method ((output mechanics-html-output))
    (push (list* (next-file-name output) (make-string-output-stream))
          (access-files-stack output))))


(defgeneric peak-next-file-name (output)
  (:method ((output mechanics-html-output))
    (format nil "~a.html" (1+ (access-file-number output)))))


(defgeneric file-complete (output)
  (:method ((output mechanics-html-output))
    (push (pop (access-files-stack output))
          (access-files output))))


(defgeneric next-file-name (output)
  (:method ((output mechanics-html-output))
    (format nil "~a.html" (incf (access-file-number output)))))


(defmethod cl-lore.protocol.output:make-output ((generator mechanics-html-output-generator) &rest initargs)
  (apply #'make 'mechanics-html-output initargs))


(defmethod cl-lore.protocol.output:save-output ((path pathname)
                                                (output mechanics-html-output))
  (call-next-method)
  (iterate
    (for (name . content) in (access-files output))
    (with-open-file (file-out (cl-fad:merge-pathnames-as-file
                               path name)
                              :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create)
      (format file-out "<!DOCTYPE html>~%<html>~%")
      (format file-out "<head><meta charset=\"utf-8\"><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"> <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Source+Sans+Pro\"></head>")
      (format file-out "<body>~%")
      (format file-out "~a" (get-output-stream-string content))
      (format file-out "~%</body>~%</html>"))))

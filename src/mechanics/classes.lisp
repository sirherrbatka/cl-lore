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
           :type list)))


(defmethod read-out-stream ((output mechanics-html-output))
  (let ((files-stack (access-files-stack output)))
    (if (endp files-stack)
        (call-next-method)
        (cdr (first files-stack)))))


(defgeneric add-another-file (output name)
  (:method ((output mechanics-html-output) (name string))
    (push (list* name (make-string-output-stream))
          (access-files-stack output))))


(defgeneric file-complete (output)
  (:method ((output mechanics-html-output))
    (push (pop (access-files-stack output))
          (access-files output))))


(defmethod cl-lore.protocol.output:make-output ((generator mechanics-html-output-generator) &rest initargs)
  (apply #'make 'mechanics-html-output initargs))


(defmethod cl-lore.protocol.output:save-output (path (output mechanics-html-output))
  ;; save css
  (with-open-file (css-out (cl-fad:merge-pathnames-as-file
                            path
                            #P"static"
                            "style.css")
                           :direction :output
                           :if-exists :supersede
                           :if-does-not-exist :create)
    (format css-out "~a" (apply #'lass:compile-and-write (access-css output))))
  ;; save contents of files
  (iterate
    (for (name . content) in (access-files output))
    (with-open-file (file-out (cl-fad:merge-pathnames-as-file
                               path
                               (concatenate 'string name ".html"))
                              :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create)
      (format file-out "<!DOCTYPE html>~%<html>~%")
      (format file-out
              "<head><meta charset=\"utf-8\"><title>~a</title><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"> <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Source+Sans+Pro\"></head>~%")
      (format file-out "<body>~%")
      (format file-out "~a" content)
      (format file-out "~%</body>~%</html>"))
    ;; save images
    (iterate
      (for image in-vector (read-images output))
      (cl-lore.graphics.graph:save-image image path))
    output))

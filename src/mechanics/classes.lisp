(in-package #:cl-lore.mechanics)


(defclass mechanics-html-output-generator
    (cl-lore.html:html-output-generator)
  ())


(defclass mechanics-html-output (cl-lore.html:html-output)
  ((%files-stack :initform nil
                 :initarg :files-stack
                 :accessor access-files-stack
                 :type list)))


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
    (for (name . content) in (access-files-stack output))
    (with-open-file (file-out (cl-fad:merge-pathnames-as-file
                               path
                               (concatenate 'string name ".html"))
                              :direction :output
                              :if-exists :supersede
                              :if-does-not-exist :create)
      (format file-out "~a" content))
    ;; save images
    (iterate
      (for image in-vector (read-images output))
      (cl-lore.graphics.graph:save-image image path))
    output))

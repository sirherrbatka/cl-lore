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
   (%labeled-files :initform (make-hash-table :test 'equal)
                   :reader read-labeled-files
                   :type hash-table)
   (%labeled-file-number :initform 0
                         :accessor access-labeled-file-number
                         :type non-negative-integer)
   (%file-number :initform 0
                 :accessor access-file-number
                 :type non-negative-integer)
   (%menu :initform nil
          :type list
          :accessor access-menu)))


(defmethod read-out-stream ((output mechanics-html-output))
  (let ((files-stack (access-files-stack output)))
    (if (endp files-stack)
        (call-next-method)
        (cdr (first files-stack)))))


(defgeneric add-another-file (output labeled)
  (:method ((output mechanics-html-output) labeled)
    (push (list* (next-file-name output labeled)
                 (make-string-output-stream))
          (access-files-stack output))))


(defgeneric peak-next-file-name (output label)
  (:method ((output mechanics-html-output) label)
    (if (not label)
        (values
         (format nil "_~a.html" (~> output access-file-number 1+))
         nil)
        (let* ((table (read-labeled-files output))
               (exists (nth-value 1 (gethash label table)))
               (value (access-labeled-file-number output)))
          (when (not exists)
            (setf value (~> output access-labeled-file-number 1+)
                  (gethash label table) value))
          (values
           (format nil "l_~a.html" value)
           exists)))))


(defgeneric file-complete (output)
  (:method ((output mechanics-html-output))
    (push (pop (access-files-stack output))
          (access-files output))))


(defgeneric next-file-name (output labeled)
  (:method ((output mechanics-html-output) labeled)
    (if labeled
        (format nil "l_~a.html" (incf (access-labeled-file-number output)))
        (format nil "_~a.html" (incf (access-file-number output))))))


(defstruct menu-entry element link nested)


(defgeneric current-file-name (output)
  (:method ((output mechanics-html-output))
    (if-let ((stack (access-files-stack output)))
      (car (first stack))
      "main.html")))


(defgeneric add-to-menu (output link element parents)
  (:method ((output mechanics-html-output)
            (file-name string)
            (element titled-tree-node)
            parents)
    (labels ((impl (input path)
               (let ((next (find (first path) input
                                 :test #'eq :key #'menu-entry-element)))
                 (if (null next)
                     (if (endp (rest path))
                         nil
                         (impl input (rest path)))
                     (if (endp (rest path))
                         next
                         (impl (menu-entry-nested next)
                               (rest path)))))))
      (let* ((position (impl (access-menu output) (reverse parents))))
        (if (null position)
            (setf (access-menu output)
                  (list (make-menu-entry :element element
                                         :link file-name
                                         :nested nil)))
            (push (make-menu-entry :element element
                                   :link file-name
                                   :nested nil)
                  (menu-entry-nested position)))
        output))))


(defgeneric get-menu (output)
  (:method ((output mechanics-html-output))
    (with-output-to-string (stream)
      (fbind ((out (curry #'format stream)))
        (out "<div class=\"vertical-menu\">")
        (labels ((impl (x)
                   (out "<li><a href=\"~a\">~a</a>"
                        (menu-entry-link x)
                        (~> x menu-entry-element access-title access-content escape-text))
                   (unless (endp (menu-entry-nested x))
                     (out "<ul>")
                     (map nil #'impl (reverse (menu-entry-nested x)))
                     (out "</ul>"))
                   (out "</li>")))
          (out "<ul>")
          (map nil #'impl (reverse (access-menu output)))
          (out "</ul>"))
        (out "</div>")))))


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
      (format file-out "<div class=\"wrap\">")
      (format file-out (get-menu output))
      (format file-out "<div class=\"content\">")
      (format file-out "~a" (get-output-stream-string content))
      (format file-out "</div>")
      (format file-out "</div>")
      (format file-out "~%</body>~%</html>"))))

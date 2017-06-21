(in-package #:cl-lore.html)


(defun escape-text (obj)
  (cl-who:escape-string (format nil "~a" obj)))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element string)
                            parents)
  (with-accessors ((stream read-out-stream)) output
    (format stream "~a" (cl-who:escape-string element)))
  element)


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element documentation-node)
                            parents)
  (let ((out (read-out-stream output)))
    (format out "Symbols in package ~a:~%"
            (~> element
                access-package-name
                escape-text)))
  (call-next-method))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element chunk-node)
                            parents)
  (when (has-title element)
    (process-element generator output (access-title element) parents))
  (call-next-method))

(let ((html-headers #(("<h1>" . "</h1>")
                      ("<h2>" . "</h2>")
                      ("<h3>" . "</h3>")
                      ("<h4>" . "</h4>")
                      ("<h5>" . "</h5>")
                      ("<h6>" . "</h6>"))))
  (flet ((section-depth (parents)
           (min 5 (iterate
                   (for parent in parents)
                   (count (has-title parent))))))
    (defmethod after-trait ((generator html-output-generator)
                            (output html-output)
                            (trait title-trait)
                            owner
                            parents)
      (format (read-out-stream output) "~a"
              (cdr (aref html-headers
                         (section-depth parents)))))


    (defmethod before-trait ((generator html-output-generator)
                             (output html-output)
                             (trait title-trait)
                             owner
                             parents)
      (format (read-out-stream output) "~a"
              (car (aref html-headers
                         (section-depth parents)))))))


(defmethod after-trait ((generator html-output-generator)
                        (output html-output)
                        (trait emphasis-trait)
                        owner
                        parents)
  (format (read-out-stream output) "</b>"))


(defmethod before-trait ((generator html-output-generator)
                         (output html-output)
                         (trait emphasis-trait)
                         owner
                         parents)
  (format (read-out-stream output) "<b>"))


(defmethod before-trait ((generator html-output-generator)
                         (output html-output)
                         (trait paragraph-trait)
                         owner
                         parents)
  (format (read-out-stream output) "<p>"))


(defmethod after-trait ((generator html-output-generator)
                        (output html-output)
                        (trait paragraph-trait)
                        owner
                        parents)
  (format (read-out-stream output) "</p>"))


(defmethod process-element :after ((generator html-output-generator)
                                   (output html-output)
                                   (element leaf-node)
                                   parents)
  (with-accessors ((out read-out-stream)) output
    (format out "~%")))


(defmethod make-output ((generator html-output-generator) &rest initargs)
  (apply #'make 'html-output initargs))


(defmethod save-output ((output html-output) (path pathname))
  (nest
   (with-accessors ((out read-out-stream) (css access-css)) output)
   (with-open-file (main-out (cl-fad:merge-pathnames-as-file path "main.html")
                             :direction :output
                             :if-exists :overwrite
                             :if-does-not-exist :create))
   (with-open-file (css-out (cl-fad:merge-pathnames-as-file path #P"static" "style.css")
                            :direction :output
                            :if-exists :overwrite
                            :if-does-not-exist :create)
     (format main-out "~a" (get-output-stream-string out))
     (format css-out "~a" (apply #'lass:compile-and-write css))
     output)))

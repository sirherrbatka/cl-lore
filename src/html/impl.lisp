(in-package #:cl-lore.html)


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
                cl-who:escape-string)))
  (call-next-method))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element chunk-node)
                            parents)
  (when (has-title element)
    (process-element generator output (access-title element) parents))
  (call-next-method))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element root-node)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (format out "<!DOCTYPE html>~%<html>~%")
    (format out "<head><meta charset=\"utf-8\"><title>~a</title></head>~%"
            (~> element access-title access-content cl-who:escape-string))
    (format out "<body>~%")
    (call-next-method)
    (format out "~%</body>~%</html>")))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element function-node)
                            parents)
  (let ((out (read-out-stream output)))
    (format out "~a ~a~%~a"
            (~> element read-name symbol-name cl-who:escape-string)
            (read-lambda-list element)
            (cl-who:escape-string (read-docstring element)))
    element))


(let ((html-headers #(("<h1>" . "</h1>")
                      ("<h2>" . "</h2>")
                      ("<h3>" . "</h3>")
                      ("<h4>" . "</h4>")
                      ("<h5>" . "</h5>")
                      ("<h6>" . "</h6>"))))
  (flet ((section-depth (parents)
           (min 5 (iterate
                   (for (parent in parents))
                   (count (has-title parent)))))))
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
                       (section-depth parents))))))


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


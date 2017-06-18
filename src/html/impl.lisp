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
    (format out
            "<head><meta charset=\"utf-8\"><title>~a</title><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"></head>~%"
            (~> element access-title access-content cl-who:escape-string))
    (format out "<body>~%")
    (call-next-method)
    (format out "~%</body>~%</html>")))


(defmethod proccess-operator-plist ((generator html-output-generator)
                                    (output html-output)
                                    &key
                                    examples
                                    description
                                    exceptional-situations
                                    notes
                                    side-effects
                                    returns
                                    &allow-other-keys)
  (with-accessors ((out read-out-stream)) output
    (format out "<div class=\"doc-description\">~%~a~%</div>"
            (cl-who:escape-string description))
    (unless (null returns)
      (if (listp returns)
          (format out "<div class=\"doc-returns\">Returns following values: <ol>~{<li>~a</li>~}~%</ol></div>"
                  returns)
          (format out "<div class=\"doc-returns\">Returns: ~%~a~%</div>"
                  (cl-who:escape-string returns))))
    (format out "<div class=\"doc")))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element cl-lore.protocol:operator-lisp-information)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (with-accessors ((plist read-plist)
                     (docstring read-docstring)
                     (lambda-list read-lambda-list)
                     (name read-name)) element
      (format out "<div class=\"doc-name\">~%~a~%</div>"
              (cl-who:escape-string (symbol-name name)))
      (format out "<div class=\"doc-lambda-list\">Arguments: ~%~:a~%</div>"
              lambda-list)
      (if (endp plist)
          (format out "<div class=\"doc-description\">~%~a~%</div>"
                  docstring)
          (apply #'proccess-operator-plist generator output plist)))))


(defmethod process-element ((generator html-output-generator)
                            (output html-output)
                            (element function-lisp-information)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (format out "<div class=\"function-info\">~%")
    (call-next-method)
    (format out "~%</div>")))


(defmethod process-element ((generator fundamental-output-generator)
                            (output fundamental-output)
                            (element function-node)
                            parents)
  (process-element generator output
                   (read-information element)
                   parents))


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
                             :direction :output))
   (with-open-file (css-out (cl-fad:merge-pathnames-as-file path #P"static" "style.css")
                            :direction :output)
     (format main-out "~a" (get-output-stream-string out))
     (format css-out "~a" (lass:compile-and-write css))
     output)))

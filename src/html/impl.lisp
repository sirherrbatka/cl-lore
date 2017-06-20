(in-package #:cl-lore.html)


(defun escape-text (obj)
  (cl-who:escape-string (format nil "~a" obj)))


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element string)
                            parents)
  (with-accessors ((stream read-out-stream)) output
    (format stream "~a" (cl-who:escape-string element)))
  element)


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element documentation-node)
                            parents)
  (let ((out (read-out-stream output)))
    (format out "Symbols in package ~a:~%"
            (~> element
                access-package-name
                escape-text)))
  (call-next-method))


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element chunk-node)
                            parents)
  (when (has-title element)
    (process-element generator output (access-title element) parents))
  (call-next-method))


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element root-node)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (let ((big-title
            (~> element access-title access-content cl-who:escape-string)))
      (format out "<!DOCTYPE html>~%<html>~%")
      (format out
              "<head><meta charset=\"utf-8\"><title>~a</title><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"> <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Source+Sans+Pro\"></head>~%"
              big-title)
      (format out "<body>~%")
      (format out "<div class=\"big-title\">~%~a~%</div>" (escape-text big-title))
      (call-next-method)
      (format out "~%</body>~%</html>"))))


(defmethod proccess-operator-plist ((generator mechanics-html-output-generator)
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
                  (mapcar #'escape-text returns))
          (format out "<div class=\"doc-returns\">Returns: ~%~a~%</div>"
                  (escape-text returns))))))


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element cl-lore.protocol:operator-lisp-information)
                            parents)
  (nest
   (with-accessors ((out read-out-stream)) output)
   (with-accessors ((plist read-plist)
                    (docstring read-docstring)
                    (lambda-list read-lambda-list)
                    (name read-name)) element
     (format out "<div class=\"doc-name\">~%~a~%</div>"
             (escape-text (symbol-name name)))
     (format out "<div class=\"doc-lambda-list\">Arguments: ~%~:a~%</div>"
             (escape-text lambda-list))
     (if (endp plist)
         (format out "<div class=\"doc-description\">~%~a~%</div>"
                 (escape-text docstring))
         (apply #'proccess-operator-plist generator output plist)))))


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element function-lisp-information)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (format out "<div class=\"function-info\">~%")
    (call-next-method)
    (format out "~%</div>")))


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
    (defmethod after-trait ((generator mechanics-html-output-generator)
                            (output html-output)
                            (trait title-trait)
                            owner
                            parents)
      (format (read-out-stream output) "~a"
              (escape-text (cdr (aref html-headers
                                 (section-depth parents))))))


    (defmethod before-trait ((generator mechanics-html-output-generator)
                             (output html-output)
                             (trait title-trait)
                             owner
                             parents)
      (format (read-out-stream output) "~a"
              (escape-text (car (aref html-headers
                                 (section-depth parents))))))))


(defmethod after-trait ((generator mechanics-html-output-generator)
                        (output html-output)
                        (trait emphasis-trait)
                        owner
                        parents)
  (format (read-out-stream output) "</b>"))


(defmethod before-trait ((generator mechanics-html-output-generator)
                         (output html-output)
                         (trait emphasis-trait)
                         owner
                         parents)
  (format (read-out-stream output) "<b>"))


(defmethod before-trait ((generator mechanics-html-output-generator)
                         (output html-output)
                         (trait paragraph-trait)
                         owner
                         parents)
  (format (read-out-stream output) "<p>"))


(defmethod after-trait ((generator mechanics-html-output-generator)
                        (output html-output)
                        (trait paragraph-trait)
                        owner
                        parents)
  (format (read-out-stream output) "</p>"))


(defmethod process-element :after ((generator mechanics-html-output-generator)
                                   (output html-output)
                                   (element leaf-node)
                                   parents)
  (with-accessors ((out read-out-stream)) output
    (format out "~%")))


(defmethod make-output ((generator mechanics-html-output-generator) &rest initargs)
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

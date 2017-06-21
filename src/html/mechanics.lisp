(in-package #:cl-lore.html)


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
             (escape-text name))
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


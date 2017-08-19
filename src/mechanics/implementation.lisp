(in-package #:cl-lore.mechanics)


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output html-output)
                            (element root-node)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (let ((big-title
            (~> element
                access-title
                access-content
                cl-who:escape-string)))
      (format out "<!DOCTYPE html>~%<html>~%")
      (format out
              "<head><meta charset=\"utf-8\"><title>~a</title><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"> <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Source+Sans+Pro\"></head>~%"
              big-title)
      (format out "<body>~%")
      (format out "<div class=\"big-title\">~%~a~%</div>" (escape-text big-title))
      (call-next-method)
      (format out "~%</body>~%</html>")
      output)))


(defmethod cl-lore.protocol.output:process-element
    ((generator mechanics-html-output-generator)
     (output cl-lore.html:html-output)
     (element cl-lore.protocol.structure:image-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<img src=\"")
    (~> element
        cl-lore.protocol.structure:access-content
        cl-lore.graphics:file-name
        form)
    (form "\" class=\"centered\">")))

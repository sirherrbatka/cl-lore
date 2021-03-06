(in-package #:cl-lore.mechanics)


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output mechanics-html-output)
                            (element root-node)
                            parents)
  (with-accessors ((out read-out-stream)) output
    (let ((big-title
            (~> element
                access-title
                access-content
                cl-who:escape-string)))
      (format out "<div class=\"big-title\">~%~a~%</div>" (escape-text big-title))
      (call-next-method)
      output)))


(let ((html-headers #(("<h1>" . "</h1>")
                      ("<h2>" . "</h2>")
                      ("<h3>" . "</h3>")
                      ("<h4>" . "</h4>")
                      ("<h5>" . "</h5>")
                      ("<h6>" . "</h6>"))))
  (defmethod process-element ((generator mechanics-html-output-generator)
                              (output mechanics-html-output)
                              (element titled-tree-node)
                              parents)
    (let* ((depth (min 5 (count-if #'has-title parents)))
           (next-file (and (not (endp parents))
                           (has-title element)
                           (eql depth 1)))
           (exists nil)
           (added-to-menu nil)
           (file-name (current-file-name output))
           (hash (sxhash element)))
      (with-accessors ((stream read-out-stream)) output
        (when next-file
          (multiple-value-bind (name e)
              (peak-next-file-name output
                                   (and (has-label element)
                                        (access-label element)))
            (setf exists e)
            (unless exists
              (setf file-name name)
              (add-to-menu output (format nil "~a#~a" name hash) element parents)
              (setf added-to-menu t)
              (let ((header (aref html-headers depth)))
                (format stream "~a<a href=\"~a#~a\">~a</a>~%~a"
                        (car header)
                        name
                        hash
                        (access-content (access-title element))
                        (cdr header))))
            (add-another-file output (has-label element))))
        (when (and (not added-to-menu)
                   (< depth 4))
          (add-to-menu output
                       (format nil "~a#~a" file-name hash)
                       element
                       parents))
        (format stream "<div id=\"~a\">" hash)
        (call-next-method)
        (format stream "</div>")
        (when (and next-file (not exists))
          (file-complete output))))))


(defmethod cl-lore.protocol.output:process-element
    ((generator mechanics-html-output-generator)
     (output mechanics-html-output)
     (element cl-lore.protocol.structure:image-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<img src=\"")
    (~> element
        cl-lore.protocol.structure:access-content
        cl-lore.graphics:file-name
        form)
    (form "\" class=\"centered\">")))


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output mechanics-html-output)
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
              "<head><meta charset=\"utf-8\"><title>~a</title><link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"> <link href=\"https://fonts.googleapis.com/css?family=Inconsolata|Lato\" rel=\"stylesheet\"></head>~%"
              big-title)
      (format out "<body>~%")
      (format out "<div class=\"big-title\">~%~a~%</div>" (escape-text big-title))
      (call-next-method)
      (format out "~%</body>~%</html>")
      output)))

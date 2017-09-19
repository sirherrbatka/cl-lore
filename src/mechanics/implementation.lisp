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


(defmethod process-element ((generator mechanics-html-output-generator)
                            (output mechanics-html-output)
                            (element chunk-node)
                            parents)
  (let* ((level (count-if #'has-title parents))
         (next-file (zerop (mod level 3))))
    (when next-file
      (add-another-file output
                        (access-label element)))
    (call-next-method)
    (when next-file
      (file-complete output))))


(defmethod cl-lore.protocol.output:process-element
    ((generator mechanics-html-output-generator)
     (output cl-lore.html:mechanics-html-output)
     (element cl-lore.protocol.structure:image-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<img src=\"")
    (~> element
        cl-lore.protocol.structure:access-content
        cl-lore.graphics:file-name
        form)
    (form "\" class=\"centered\">")))

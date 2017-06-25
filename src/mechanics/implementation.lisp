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


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :arguments-and-values))
                             data
                             (output html-output)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :examples))
                             data
                             (output html-output)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :description))
                             data
                             (output html-output))
  (mechanics-format-description (read-stream output) data))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :exceptional-situations))
                             data
                             (output html-output)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :notes))
                             data
                             (output html-output)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :side-effects))
                             data
                             (output html-output)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :returns))
                             data
                             (output html-output))
  (mechanics-format-returns (read-stream output) data))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :syntax))
                             data
                             (output html-output)))


(defmethod docstample:get-visitor ((generator mechanics-html-output-generator))
  <lore-mechanics-visitor>)


(defmethod process-element
    ((generator mechanics-html-output-generator)
     (output html-output)
     (element cl-lore.protocol:named-lisp-information)
     parents)
  (nest
   (with-accessors ((name read-name)) element)
   (with-accessors ((out read-out-stream)) output
     (format out "<div class=\"doc-name\">~%~a~%</div>"
             (escape-text name)))))


(defmethod process-element
    ((generator mechanics-html-output-generator)
     (output html-output)
     (element cl-lore.protocol:operator-lisp-information)
     parents)
  (nest
   (with-accessors ((lambda-list read-lambda-list)
                    (node-type cl-lore.protocol:read-node-type)) element)
   (with-accessors ((out read-out-stream)
                    (plist cl-lore.protocol:read-plist)) output
       (call-next-method)
     (format out "<div class=\"doc-lambda-list\">Arguments: ~%~:a~%</div>"
             (escape-text lambda-list))
     (if (null plist)
         nil ;;TODO: implement
         (docstample:generate-documentation-string
          generator
          node-type
          output
          plist))))
  output)

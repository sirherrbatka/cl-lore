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
                             (data string)
                             (output html-output))
  (with-accessors ((out read-out-stream)) output
    (format out "~a" data)))


(defmethod docstample:visit :around ((visitor lore-mechanics-visitor)
                                     (type docstample:operator-node)
                                     (symbol (eql :arguments-and-values))
                                     data
                                     (output html-output))
  (with-accessors ((out read-out-stream)) output
    (format out "Arguments and values:~%")
    (call-next-method)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :arguments-and-values))
                             (data list)
                             (output html-output))
  (with-accessors ((out read-out-stream)) output
    (format out "<ul>")
    (iterate
      (for (symb desc) in data)
      (format out "<li>~a &ndash; ~a</li>" (escape-text symb) (escape desc)))
    (format out "</ul>")))


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
  (with-accessors ((out read-out-stream)) output
    (format out "Description:~%~a" (escape-text data))))


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
                             (output html-output)))


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
   (with-accessors ((name cl-lore.protocol:read-name)) element)
   (with-accessors ((out read-out-stream)) output
     (format out "<div class=\"doc-name\">~%~a~%</div>"
             (escape-text name)))))


(defmethod process-element
    ((generator mechanics-html-output-generator)
     (output html-output)
     (element cl-lore.protocol:operator-lisp-information)
     parents)
  (declare (optimize (debug 3)))
  (nest
   (with-accessors ((lambda-list cl-lore.protocol:read-lambda-list)
                    (node-type cl-lore.protocol:read-node-type)
                    (plist cl-lore.protocol:read-plist))
       element)
   (with-accessors ((out read-out-stream)) output
     (call-next-method)
     (format out "<div class=\"doc-lambda-list\">Arguments: ~%~:a~%</div>"
             (escape-text lambda-list))
     (if (null plist)
         (progn (break) nil) ;;TODO: implement
         (docstample:generate-documentation-string
          generator
          node-type
          output
          plist))))
  output)

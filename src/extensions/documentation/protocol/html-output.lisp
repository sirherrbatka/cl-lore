(in-package #:cl-lore.extensions.documentation.protocol)


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :arguments-and-values))
                             (data string)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "~a" data)))


(defmethod docstample:visit :around ((visitor lore-visitor)
                                     (type docstample:operator-node)
                                     symbol
                                     data
                                     (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<div class=\"doc-paragraph\">~%")
    (call-next-method)
    (format out "</div>~%")))



(defmethod docstample:visit :around ((visitor lore-visitor)
                                     (type docstample:operator-node)
                                     (symbol (eql :arguments-and-values))
                                     data
                                     (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Arguments and values:</b>~%")
    (call-next-method)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :arguments-and-values))
                             (data list)
                             (output html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<ul>")
    (iterate
      (for (symb desc) in data)
      (format out "<li>~a &ndash; ~a</li>" (cl-lore.html:escape-text symb) (cl-lore.html:escape-text desc)))
    (format out "</ul>")))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :examples))
                             data
                             (output cl-lore.protocol.html:html-output)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:record-node)
                             (symbol (eql :description))
                             data
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Description:</b>~%~a" (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :exceptional-situations))
                             (data string)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Execeptional Situations:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :notes))
                             (data string)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Notes:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :side-effects))
                             (data string)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Side Effects:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :description))
                             (data string)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Description:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit :around ((visitor lore-mechanics-visitor)
                                     (type docstample:operator-node)
                                     (symbol (eql :returns))
                                     data
                                     (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<b>Returns:</b>~%")
    (call-next-method)))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :returns))
                             (data string)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "~a" (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-mechanics-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :returns))
                             (data list)
                             (output cl-lore.protocol.html:html-output))
  (with-accessors ((out cl-lore.html.read-out-stream)) output
    (format out "<ol>")
    (iterate (for elt in data)
      (format out "<li>~a</li>~%" (cl-lore.html:escape-text elt)))
    (format out "</ol>")))


(defmethod docstample:get-visitor ((generator mechanics-html-output-generator))
  <mechanics-visitor>)


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.protocol.html:html-output-generator)
     (output cl-lore.protocol.html:html-output)
     (element named-lisp-information)
     parents)
  (nest
   (with-accessors ((name cl-lore.protocol:read-name)) element)
   (with-accessors ((out cl-lore.html.read-out-stream)) output
     (format out "<div class=\"doc-name\">~%~a~%</div>"
             (cl-lore.html:escape-text name)))))


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.protocol.html:html-output-generator)
     (output cl-lore.protocol.html:html-output)
     (element operator-lisp-information)
     parents)
  (declare (optimize (debug 3)))
  (nest
   (with-accessors ((lambda-list cl-lore.protocol:read-lambda-list)
                    (node-type cl-lore.protocol:read-node-type)
                    (description cl-lore.protocol:read-docstring)
                    (plist cl-lore.protocol:read-plist))
       element)
   (with-accessors ((out cl-lore.html.read-out-stream)) output
     (call-next-method)
     (format out "<div class=\"doc-lambda-list\"><b>Arguments:</b>~%~:a~%</div>"
             (cl-lore.html:escape-text lambda-list))
     (if (null plist)
         (format out "<div class=\"doc-paragraph\">~a</div>" (cl-lore.html:escape-text description))
         (docstample:generate-documentation-string
          generator
          node-type
          output
          plist))))
  output)


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.protocol.html:html-output-generator)
     (output cl-lore.protocol.html:html-output)
     (element record-lisp-information)
     parents)
  (declare (optimize (debug 3)))
  (nest
   (with-accessors ((lambda-list cl-lore.protocol:read-lambda-list)
                    (node-type cl-lore.protocol:read-node-type)
                    (description cl-lore.protocol:read-docstring)
                    (plist cl-lore.protocol:read-plist))
       element)
   (with-accessors ((out cl-lore.html.read-out-stream)) output
     (call-next-method)
     (let ((inheritance
             (cl-lore.graphics.graph:make-class-inheritance
              (cl-lore.protocol:read-name element)
              '(:bgcolor :none
                :rankdir "BT"))))
       (add-image output inheritance)
       (format out
               "~%<img src=\"~a\" alt=\"Inheritance\" class=\"centered\">~%<br>~%"
               (cl-lore.graphics:file-name inheritance)))
     (if (null plist)
         (unless (null description)
           (format out "<div class=\"doc-paragraph\">~a</div>"
                   (cl-lore.html:escape-text description)))
         (docstample:generate-documentation-string
          generator
          node-type
          output
          plist))))
  output)

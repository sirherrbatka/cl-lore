(in-package #:cl-lore.extensions.documentation.protocol)


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :arguments-and-values))
                             (data string)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "~a" data)))


(defmethod docstample:visit :around ((visitor lore-visitor)
                                     (type docstample:operator-node)
                                     symbol
                                     data
                                     (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<div class=\"doc-paragraph\">~%")
    (call-next-method)
    (format out "</div>~%")))



(defmethod docstample:visit :around ((visitor lore-visitor)
                                     (type docstample:operator-node)
                                     (symbol (eql :arguments-and-values))
                                     data
                                     (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Arguments and values:</b>~%")
    (call-next-method)))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :arguments-and-values))
                             (data list)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<ul>")
    (iterate
      (for (symb desc) in data)
      (format out "<li>~a &ndash; ~a</li>"
              (string-upcase (cl-lore.html:escape-text symb))
              (cl-lore.html:escape-text desc)))
    (format out "</ul>")))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :examples))
                             (data list)
                             (output cl-lore.html:html-output))
  (fbind ((out (curry #'format
                      (cl-lore.html::read-out-stream output)
                      "~a")))
    (flet ((print-code (code)
             (out "<pre><code>")
             (with-output-to-string (s)
               (pprint (read-from-string code) s)
               (~> s get-output-stream-string trim-whitespace cl-lore.html:escape-text out))
             (out "</pre></code>")))
      (out "<b>Examples:</b>")
      (map nil #'print-code data))))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:record-node)
                             (symbol (eql :description))
                             data
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Description:</b>~%~a" (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :exceptional-situations))
                             (data string)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Execeptional Situations:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit
    :around
    ((visitor lore-visitor)
     (type docstample:operator-node)
     (symbol (eql :notes))
     data
     (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Notes:</b>~%")
    (call-next-method)))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :notes))
                             (data string)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :notes))
                             (data list)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<ul>")
    (iterate
      (for ex in data)
      (format out "<li>~a</li>"
              ex))
    (format out "</ul>")))
            


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :side-effects))
                             (data string)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Side Effects:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :description))
                             (data string)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Description:</b>~%~a"
            (cl-lore.html:escape-text data))))


(defmethod docstample:visit :around ((visitor lore-visitor)
                                     (type docstample:operator-node)
                                     (symbol (eql :returns))
                                     data
                                     (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<b>Returns:</b>~%")
    (call-next-method)))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :returns))
                             (data string)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "~a" (cl-lore.html:escape-text data))))


(defmethod docstample:visit ((visitor lore-visitor)
                             (type docstample:operator-node)
                             (symbol (eql :returns))
                             (data list)
                             (output cl-lore.html:html-output))
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<ol>")
    (iterate (for elt in data)
      (format out "<li>~a</li>~%" (cl-lore.html:escape-text elt)))
    (format out "</ol>")))


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.html:html-output-generator)
     (output cl-lore.html:html-output)
     (element named-lisp-information)
     parents)
  (nest
   (with-accessors ((name read-name)) element)
   (with-accessors ((out cl-lore.html:read-out-stream)) output
     (format out "<div class=\"doc-name\">~%~a~%</div>"
             (cl-lore.html:escape-text name)))))


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.html:html-output-generator)
     (output cl-lore.html:html-output)
     (element operator-lisp-information)
     parents)
  (nest
   (with-accessors ((lambda-list read-lambda-list)
                    (node-type read-node-type)
                    (description read-docstring)
                    (plist read-plist))
       element)
   (with-accessors ((out cl-lore.html:read-out-stream)) output
     (call-next-method)
     (format out "<div class=\"doc-lambda-list\"><b>Arguments:</b>~%~:a~%</div>"
             (cl-lore.html:escape-text lambda-list))
     (if (null plist)
         (format out "<div class=\"doc-paragraph\">~a</div>" (cl-lore.html:escape-text description))
         (docstample:generate-documentation-string
          <lore-generator>
          node-type
          output
          plist))))
  output)


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.html:html-output-generator)
     (output cl-lore.html:html-output)
     (element record-lisp-information)
     parents)
  (nest
   (with-accessors ((lambda-list read-lambda-list)
                    (node-type read-node-type)
                    (description read-docstring)
                    (plist read-plist))
       element)
   (with-accessors ((out cl-lore.html:read-out-stream)) output
     (call-next-method)
     (let ((inheritance
             (cl-lore.extensions.documentation.graphics:make-class-inheritance
              (read-name element)
              '(:bgcolor :none
                :rankdir "BT"))))
       (cl-lore.protocol.output:add-image output inheritance)
       (format out
               "~%<img src=\"~a\" alt=\"Inheritance\" class=\"centered\">~%<br>~%"
               (cl-lore.graphics:file-name inheritance)))
     (if (null plist)
         (unless (null description)
           (format out "<div class=\"doc-paragraph\">~a</div>"
                   (cl-lore.html:escape-text description)))
         (docstample:generate-documentation-string
          <lore-generator>
          node-type
          output
          plist))))
  output)


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.html:html-output-generator)
     (output cl-lore.html:html-output)
     (element documentation-node)
     parents)
  (let ((out (cl-lore.html:read-out-stream output)))
    (format out "Symbols in package ~a:~%"
            (~> element
                access-package-name
                cl-lore.html:escape-text)))
  (call-next-method))


(defgeneric div-class (node)
  (:method ((node function-lisp-information))
    "function-info")
  (:method ((node generic-function-lisp-information))
    "generic-info")
  (:method ((node class-lisp-information))
    "class-info")
  (:method ((node struct-lisp-information))
    "struct-info")
  (:method ((node macro-lisp-information))
    "macro-info"))


(defmethod cl-lore.protocol.output:process-element :around
    ((generator cl-lore.html:html-output-generator)
     (output cl-lore.html:html-output)
     (element fundamental-lisp-information)
     parents)
  (with-accessors ((out cl-lore.html:read-out-stream)) output
    (format out "<div class=\"~a\">"
            (div-class element))
    (call-next-method generator output element parents)
    (format out "</div>")))


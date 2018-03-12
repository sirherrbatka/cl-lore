(in-package #:cl-lore.extensions.documentation.protocol)


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
                    (doc read-content))
       element)
   (with-accessors ((out cl-lore.html:read-out-stream)) output
     (call-next-method)
     (format out "<div class=\"doc-lambda-list\"><b>Arguments:</b>~%~:a~%</div>"
             (cl-lore.html:escape-text lambda-list))
     (econd
       ((strinp doc)
        (format out "<div class=\"doc-paragraph\">~a</div>"
                (cl-lore.html:escape-text doc)))
       ((null doc) nil)
       ((listp doc) (generate-documentation-string element output doc)))))
  output)


(defmethod cl-lore.protocol.output:process-element
    ((generator cl-lore.html:html-output-generator)
     (output cl-lore.html:html-output)
     (element record-lisp-information)
     parents)
  (nest
   (with-accessors ((lambda-list read-lambda-list)
                    (description read-docstring)
                    (doc read-content))
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
     (econd
       ((strinp doc)
        (format out "<div class=\"doc-paragraph\">~a</div>"
                (cl-lore.html:escape-text doc)))
       ((null doc) nil)
       ((listp doc) (generate-documentation-string element output doc)))))
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
  (:method ((node error-lisp-information))
    "error-info")
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


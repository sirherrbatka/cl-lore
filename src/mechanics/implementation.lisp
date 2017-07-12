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


;; (defmethod process-element
;;     ((generator mechanics-html-output-generator)
;;      (output html-output)
;;      (element cl-lore.protocol:named-lisp-information)
;;      parents)
;;   (nest
;;    (with-accessors ((name cl-lore.protocol:read-name)) element)
;;    (with-accessors ((out read-out-stream)) output
;;      (format out "<div class=\"doc-name\">~%~a~%</div>"
;;              (escape-text name)))))


;; (defmethod process-element
;;     ((generator mechanics-html-output-generator)
;;      (output html-output)
;;      (element cl-lore.protocol:operator-lisp-information)
;;      parents)
;;   (declare (optimize (debug 3)))
;;   (nest
;;    (with-accessors ((lambda-list cl-lore.protocol:read-lambda-list)
;;                     (node-type cl-lore.protocol:read-node-type)
;;                     (description cl-lore.protocol:read-docstring)
;;                     (plist cl-lore.protocol:read-plist))
;;        element)
;;    (with-accessors ((out read-out-stream)) output
;;      (call-next-method)
;;      (format out "<div class=\"doc-lambda-list\"><b>Arguments:</b>~%~:a~%</div>"
;;              (escape-text lambda-list))
;;      (if (null plist)
;;          (format out "<div class=\"doc-paragraph\">~a</div>" (escape-text description))
;;          (docstample:generate-documentation-string
;;           generator
;;           node-type
;;           output
;;           plist))))
;;   output)


;; (defmethod process-element
;;     ((generator mechanics-html-output-generator)
;;      (output html-output)
;;      (element cl-lore.protocol:record-lisp-information)
;;      parents)
;;   (declare (optimize (debug 3)))
;;   (nest
;;    (with-accessors ((lambda-list cl-lore.protocol:read-lambda-list)
;;                     (node-type cl-lore.protocol:read-node-type)
;;                     (description cl-lore.protocol:read-docstring)
;;                     (plist cl-lore.protocol:read-plist))
;;        element)
;;    (with-accessors ((out read-out-stream)) output
;;      (call-next-method)
;;      (let ((inheritance
;;              (cl-lore.graphics.graph:make-class-inheritance
;;               (cl-lore.protocol:read-name element)
;;               '(:bgcolor :none
;;                 :rankdir "BT"))))
;;        (add-image output inheritance)
;;        (format out
;;                "~%<img src=\"~a\" alt=\"Inheritance\" class=\"centered\">~%<br>~%"
;;                (cl-lore.graphics:file-name inheritance)))
;;      (if (null plist)
;;          (unless (null description)
;;            (format out "<div class=\"doc-paragraph\">~a</div>"
;;                    (escape-text description)))
;;          (docstample:generate-documentation-string
;;           generator
;;           node-type
;;           output
;;           plist))))
;;   output)

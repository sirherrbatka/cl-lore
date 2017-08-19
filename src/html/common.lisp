(in-package #:cl-lore.html)

(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element string)
     parents)
  (with-accessors ((stream read-out-stream)) output
    (format stream "~a" (cl-who:escape-string element)))
  element)


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:chunk-node)
     parents)
  (when (cl-lore.protocol.structure:has-title element)
    (cl-lore.protocol.output:process-element
     generator
     output
     (cl-lore.protocol.structure:access-title element)
     parents))
  (call-next-method))


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:table-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<table>")
    (call-next-method)
    (form "</table>")))


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:row-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<tr>")
    (cl-lore.protocol.structure:map-children
     (lambda (x)
       (form "<td>")
       (cl-lore.protocol.output:process-element generator
                                                output
                                                x
                                                (cons element parents))
       (form "</td>"))
     element)
    (form "</tr>")))


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:title-row-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (let ((parents (cons element parents)))
      (form "<tr>")
      (cl-lore.protocol.structure:map-children
       (lambda (x)
         (form "<th>")
         (cl-lore.protocol.output:process-element generator
                                                  output
                                                  x
                                                  parents)
         (form "</th>"))
       element)
      (form "</tr>"))))


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:chunk-node)
     parents)
  (when (cl-lore.protocol.structure:has-title element)
    (cl-lore.protocol.output:process-element
     generator
     output
     (cl-lore.protocol.structure:access-title element)
     parents))
  (call-next-method))


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:list-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<ul>")
    (call-next-method)
    (form "</ul>")))


(defmethod cl-lore.protocol.output:contextual-process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:item-node)
     (parent cl-lore.protocol.structure:list-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<li>")
    (cl-lore.protocol.output:process-element
     generator
     output
     (cl-lore.protocol.structure:access-content element)
     parents)
    (form "</li>")))


(defmethod cl-lore.protocol.output:process-element :after
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:leaf-node)
     parents)
  (with-accessors ((out read-out-stream)) output
    (format out "~%")))


(defmethod cl-lore.protocol.output:make-output
    ((generator html-output-generator) &rest initargs)
  (apply #'make 'html-output initargs))


(defmethod cl-lore.protocol.output:save-output ((path pathname)
                                                (output html-output))
  (nest
   (with-accessors ((out read-out-stream) (css access-css)) output)
   (with-open-file (main-out (cl-fad:merge-pathnames-as-file path "main.html")
                             :direction :output
                             :if-exists :overwrite
                             :if-does-not-exist :create))
   (with-open-file (css-out (cl-fad:merge-pathnames-as-file path
                                                            #P"static"
                                                            "style.css")
                            :direction :output
                            :if-exists :supersede
                            :if-does-not-exist :create)
     (format main-out "~a" (get-output-stream-string out))
     (format css-out "~a" (apply #'lass:compile-and-write css))
     (iterate
       (for image in-vector (read-images output))
       (cl-lore.graphics:save-image image path))
     output)))


(let ((html-headers #(("<h1>" . "</h1>")
                      ("<h2>" . "</h2>")
                      ("<h3>" . "</h3>")
                      ("<h4>" . "</h4>")
                      ("<h5>" . "</h5>")
                      ("<h6>" . "</h6>"))))
  (flet ((section-depth (parents)
           (min 5 (iterate
                   (for parent in parents)
                   (count (cl-lore.protocol.structure:has-title parent))))))
    (defmethod cl-lore.protocol.output:apply-trait
        ((generator html-output-generator)
         (output html-output)
         (trait cl-lore.protocol.structure:title-trait)
         parents
         continue)
      (let ((h (aref html-headers
                     (section-depth parents))))
        (format (read-out-stream output) "~a"
                (car h))
        (funcall continue)
        (format (read-out-stream output) "~a"
                (cdr h))))))


(defmacro define-trait-wrap (trait before after)
  (once-only (before after)
    `(defmethod cl-lore.protocol.output:apply-trait
         ((generator html-output-generator)
          (output html-output)
          (trait ,trait)
          parents
          continue)
       (format (read-out-stream output)
               ,before)
       (funcall continue)
       (format (read-out-stream output)
               ,after))))


(define-trait-wrap cl-lore.protocol.structure:emphasis-trait
  "<b>" "</b>")


(define-trait-wrap cl-lore.protocol.structure:paragraph-trait
  "<p>" "</p>")


(defmethod cl-lore.protocol.output:process-element
    :before ((generator html-output-generator)
             (output html-output)
             (element cl-lore.protocol.structure:image-node)
             parents)
  (cl-lore.protocol.output:add-image
   output
   (cl-lore.protocol.structure:access-content element)))


(defmethod cl-lore.protocol.output:process-element
    ((generator html-output-generator)
     (output html-output)
     (element cl-lore.protocol.structure:image-node)
     parents)
  (fbind ((form (curry #'format (read-out-stream output))))
    (form "<img src=\"")
    (~> element
        cl-lore.protocol.structure:access-content
        cl-lore.graphics:file-name
        form)
    (form "\">")))

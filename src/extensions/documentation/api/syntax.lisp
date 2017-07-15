(in-package #:cl-lore.extensions.documentation.api)


(defmacro syntax (name type make-function)
  `(cl-lore.api.raw:def-syntax ,name (id)
     (let ((data (cl-lore.extensions.documentation.protocol:query
                  cl-lore.extensions.documentation.protocol:*index*
                  ,type
                  id)))
       (ret (,make-function data)))))


(syntax
 docfun
 docstample:<function>
 cl-lore.extensions.documentation.protocol:make-function-documentation)


(syntax
 docgeneric
 docstample:<generic>
 cl-lore.extensions.documentation.protocol:make-generic-function-documentation)


(syntax
 docmacro
 docstample:<macro>
 cl-lore.extensions.documentation.protocol:make-macro-documentation)


(syntax
 docclass
 docstample:<class>
 cl-lore.extensions.documentation.protocol:make-class-documentation)


(syntax
 docstruct
 docstample:<struct>
 cl-lore.extensions.documentation.protocol:make-struct-documentation)


(defun pack (name)
  (declare (type string name))
  "Set PACKAGE for documentation section."
  (setf (cl-lore.extensions.documentation.protocol:access-package-name
         cl-lore.api.raw:*register*)
        name))

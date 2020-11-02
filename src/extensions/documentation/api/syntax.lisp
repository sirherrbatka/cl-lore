(in-package #:cl-lore.extensions.documentation.api)


(defmacro syntax (name type)
  `(cl-lore.api.raw:def-syntax ,name (id)
     (let ((data (cl-lore.extensions.documentation.protocol:query ',type id)))
       (ret data))))

(syntax docfun :function)
(syntax docgeneric :generic)
(syntax docmacro :macro)
(syntax docclass :class)
(syntax docstruct :struct)
(syntax docerror :error)
(syntax docvar :variable)

(defun pack (name)
  (declare (type string name))
  "Set PACKAGE for documentation section."
  (setf (cl-lore.extensions.documentation.protocol:access-package-name
         cl-lore.api.raw:*register*)
        name))

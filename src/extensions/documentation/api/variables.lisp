(in-package #:cl-lore.extensions.documentation.api)


(def <documentation-names>
  (let ((table (make-hash-table :test 'equal)))
    (setf (gethash "documentation" table)
          (curry #'make
                 'cl-lore.extensions.documentation.protocol:documentation-node))
    table))

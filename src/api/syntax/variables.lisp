(in-package #:cl-lore.api.syntax)


(def <standard-names>
  (let ((table (make-hash-table :test 'equal)))
    (setf (gethash "section" table)
          (curry #'make 'cl-lore.protocol.structure:chunk-node))
    table))


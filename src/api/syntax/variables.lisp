(in-package #:cl-lore.api.syntax)


(def <standard-names>
  (let ((table (make-hash-table :test 'equal)))
    (setf (gethash "section" table) #'cl-lore.api.raw:make-chunk

          (gethash "table" table) #'cl-lore.api.raw:make-table

          (gethash "list" table) #'cl-lore.api.raw:make-lore-list)
    table))


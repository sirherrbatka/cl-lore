(in-package #:cl-lore.api)


(defparameter <standard-names> (let ((table (make-hash-table :test 'equal)))
                                 (setf (gethash "section" table) #'make-section
                                       (gethash "doc" table) #'make-documentation-section)
                                 table))

(defvar <title-trait> (make 'title-trait))




(defvar <paragraph-trait> (make 'paragraph-trait))

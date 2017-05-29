(in-package #:cl-lore)


(defvar <html-output-generator> (make-instance 'html-output-generator))


(defvar <standard-names> (let ((table (make-hash-table :test 'equal)))
                           (setf (gethash "section" table) #'make-section)
                           table))


(defvar <title-trait> (make 'title-trait))
(defvar <emphasis-trait> (make 'emphasis-trait))

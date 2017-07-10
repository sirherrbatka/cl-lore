(in-package #:cl-lore.protocol.collecting)


(defclass fundamental-chunks-collection ()
  ())


(defclass chunks-collection (fundamental-chunks-collection)
  ((%content :initform (make-hash-table :test 'equal)
             :reader read-content
             :type hash-table)))

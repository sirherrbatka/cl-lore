(in-package #:cl-lore.protocol.collecting)


(defclass fundamental-chunks-collection ()
  ((%extensions :initform (make-hash-table :test 'equal)
                :reader read-extensions
                :type hash-table)))


(defclass chunks-collection (fundamental-chunks-collection)
  ((%content :initform (make-hash-table :test 'equal)
             :reader read-content
             :type hash-table)))

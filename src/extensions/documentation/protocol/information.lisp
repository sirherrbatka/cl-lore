(in-package #:cl-lore.extensions.documentation.protocol)


(defclass fundamental-lisp-information (cl-lore.protocol.structure:fundamental-node)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass named-lisp-information (fundamental-lisp-information)
  ((%name :type (or symbol list)
          :initarg :name
          :reader read-name))
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass standard-lisp-information (fundamental-lisp-information)
  ((%content :type (or string list)
             :initarg :content
             :reader read-content
             :initform nil))
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass record-lisp-information (named-lisp-information
                                   standard-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass class-lisp-information (record-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass struct-lisp-information (record-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass condition-lisp-information (record-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass error-lisp-information (condition-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass operator-lisp-information (named-lisp-information
                                     standard-lisp-information)
  ((%lambda-list :type list
                 :initarg :lambda-list
                 :reader read-lambda-list))
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defmethod initialize-instance :after ((obj operator-lisp-information) &rest all)
  (declare (ignore all))
  (setf (slot-value obj '%lambda-list) (arg:arglist (read-name obj))))


(defclass function-lisp-information (operator-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass macro-lisp-information (operator-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))


(defclass generic-function-lisp-information (operator-lisp-information)
  ()
  (:metaclass cl-lore.protocol.structure:lore-node-class))

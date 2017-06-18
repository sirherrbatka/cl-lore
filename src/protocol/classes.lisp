(in-package #:cl-lore.protocol)


(defclass fundamental-decorator ()
  ())


(defclass label (fundamental-decorator)
  ((%name :initarg :name
          :accessor access-name
          :type string)))


(defclass internal-reference (fundamental-decorator)
  ((%label-name :initarg :label-name
                :type string
                :accessor access-label-name)))


(defclass file ()
  ((%content :initarg :content
             :accessor access-content)
   (%path :initarg :path
          :accessor access-path)))


(defclass fundamental-lisp-information ()
  ())


(defclass named-lisp-information (fundamental-lisp-information)
  ((%name :type symbol
          :initarg :name
          :reader read-name)))


(defclass operator-lisp-information (named-lisp-information)
  ((%lambda-list :type list
                 :initarg :lambda-list
                 :reader read-lambda-list)
   (%plist :type list
           :initarg :plist
           :reader read-plist
           :documentation "plist, as set by docstample.")
   (%docstring :type (or string null)
               :initarg :docstring
               :reader read-docstring
               :initform nil)))


(defclass function-lisp-information (operator-lisp-information)
  ())

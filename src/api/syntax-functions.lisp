(in-package #:cl-lore)


(defun begin (what)
  (push-stack what (make-node what) *stack*))


(defun end (what)
  (multiple-value-bind (value desc) (front-stack *stack*)
    (unless (string= desc what)
      (error "Closing wrong tree. Was trying to close tree ~a, but last tree is ~a"
             what desc)))
  (pop-stack *stack*))


(defun title (text)
  (declare (type string text))
  (push-children (front-stack *stack*)
                 (make-instance 'leaf-node
                                :traits (list <title-trait>)
                                :content text)))


(defun emphasis (text)
  (declare (type string text))
  (push-children (front-stack *stack*)
                 (make-instance 'leaf-node
                                :traits (list <emphasis-trait>)
                                :content text)))


(defun label (name content)
  (declare (type fundamental-element content)
           (type string name))
  (push-children (front-stack *stack*)
                 (make-instance 'label
                                :name (string-trim " " name)
                                :content content)))


(defun symb (symbol-name))


(defgeneric refer (from text))




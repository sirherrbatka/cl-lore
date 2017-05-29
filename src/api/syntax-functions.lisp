(in-package #:cl-lore)


(defun begin (what)
  (push-stack what (make-node what) *stack*))


(defun begin-document ()
  (push-stack "root" (make 'root-node) *stack*))


(defun end-document ()
  (multiple-value-bind (value desc) (front-stack *stack*)
    (unless (string= desc "root")
      (error "Closing wrong tree. Was trying to close tree ~a, but last tree is ~a"
             "root" desc)))
  (pop-stack *stack*))


(defun end (what)
  (multiple-value-bind (value desc) (front-stack *stack*)
    (unless (string= desc what)
      (error "Closing wrong tree. Was trying to close tree ~a, but last tree is ~a"
             what desc))
    (pop-stack *stack*)
    (push-children (front-stack *stack*)
                   value)))


(defun title (text)
  (declare (type string text))
  (setf (access-title (front-stack *stack*))
        (make-instance 'leaf-node
                       :traits (list <title-trait>)
                       :content text)))


(defun emphasis (text)
  (declare (type string text))
  (make 'leaf-node
        :traits (list <emphasis-trait>)
        :content text))


(defun par (&rest content)
  (let ((result (make 'paragraph-node)))
    (dolist (c content)
      (push-children result c))
    (push-children (front-stack *stack*)
                   result)))


(defun symb (symbol-name))


(defgeneric refer (from text))




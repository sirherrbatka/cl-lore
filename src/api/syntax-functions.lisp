(in-package #:cl-lore)


(defun begin (what)
  (controller-push-tree what (make-node what) *stack*))


(defun begin-document ()
  (controller-push-tree "root" (make 'root-node) *stack*))


(defun end-document ()
  (multiple-value-bind (value desc) (controller-front *stack*)
    (unless (string= desc "root")
      (error "Closing wrong tree. Was trying to close tree ~a, but last tree is ~a"
             "root" desc)))
  (controller-pop-tree *stack*))


(defun end (what)
  (multiple-value-bind (value desc) (controller-front *stack*)
    (unless (string= desc what)
      (error "Closing wrong tree. Was trying to close tree ~a, but last tree is ~a"
             what desc))
    (pop-stack *stack*)
    (controller-push-tree *stack* value)))


(defun title (text)
  (declare (type string text))
  (setf (access-title (controller-front *stack*))
        (make-instance 'leaf-node
                       :traits (list <title-trait>)
                       :content text)))


(defun emphasis (text)
  (declare (type string text))
  (controller-return *stack*
                     (make 'leaf-node
                           :traits (list <emphasis-trait>)
                           :content text)))

(def-without-stack par nil (&rest content)
  (let ((result (make 'paragraph-node)))
     (dolist (c content)
       (push-child result c))
    (controller-return *stack* result)))


(defun symb (symbol-name))


(defgeneric refer (from text))

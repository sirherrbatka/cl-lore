(in-package #:cl-lore)


(defun begin (what)
  (controller-push-tree *stack* what (make-node what)))


(defun begin-document ()
  (controller-push-tree *stack* "root" (make 'root-node)))


(defun end-document ()
  (let ((result (controller-pop-tree *stack* "root")))
    (setf *register* nil)
    result))


(defun end (what)
  (let ((value (controller-pop-tree *stack* what)))
    (controller-return *stack* value)))


(defun title (text)
  (declare (type string text))
  (ret (make-instance 'leaf-node
                      :traits (list <title-trait>)
                      :content text)))


(def-syntax emphasis (text)
  (ret (make 'leaf-node
             :traits (list <emphasis-trait>)
             :content text)))


(def-without-stack par nil (&rest content)
  (let ((result (make 'paragraph-node)))
     (dolist (c content)
       (push-child result c))
    (ret result)))


(defun symb (symbol-name))


(defgeneric refer (from text))


(defun label (name)
  (declare (type string name))
  (push-decorator *register*
                  (make 'label
                        :name name)))

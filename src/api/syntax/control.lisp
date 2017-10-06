(in-package #:cl-lore.api.syntax)


(defmacro define-save-output-function (name document-form)
  (with-gensyms (!path)
    `(let ((,!path nil))
       (defun ,name (&optional path)
         (declare (type (or null string pathname) path))
         (check-type path (or null string pathname))
         (unless (null path)
           (setf ,!path (pathname path)))
         (restart-case
             (progn
               (when (null ,!path)
                 (error "Path was not set!"))
               (cl-lore.protocol.output:save-output
                ,!path
                (assure cl-lore.protocol.output:fundamental-output ,document-form)))
           (set-path (path)
             :report "Set path."
             :interactive (lambda ()
                            (format *query-io* "Enter new path.~%")
                            (force-output *query-io*)
                            (list (read)))
             (,name path)))
         ,!path))))

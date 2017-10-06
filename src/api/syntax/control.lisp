(in-package #:cl-lore.api.syntax)


(defmacro define-save-output-function (name)
  (with-gensyms (!path)
    `(let ((,!path nil))
       (defun ,name (document &optional path)
         (declare (type (or null string pathname) path)
                  (type cl-lore.protocol.output:fundamental-output
                        document))
         (tagbody
          :start
            (check-type path (or null string pathname))
            (unless (null path)
              (setf ,!path (pathname path)))
            (flet ((set-path (e)
                     (declare (ignorable e))
                     (setf path (read)
                           ,!path nil)
                     (go :start)))
              (handler-bind ((file-error #'set-path))
                (when (null ,!path)
                  (error 'file-error))
                (cl-lore.protocol.output:save-output ,!path
                                                     document))))))))

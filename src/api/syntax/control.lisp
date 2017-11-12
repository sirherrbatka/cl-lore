(in-package #:cl-lore.api.syntax)


(defmacro define-save-output-function (name
                                       (names
                                        generator
                                        chunks)
                                       (&key output-options dynamic-binding)
                                       (&rest files)
                                       &body document-form)
  (with-gensyms (!path !output !current-path)
    `(let ((,!path nil)
           (,!current-path (uiop/pathname:pathname-directory-pathname
                            (asdf-utils:current-lisp-file-pathname))))
       (defun ,name (&optional path)
         (declare (type (or null string pathname) path))
         (check-type path (or null list string pathname))
         (unless (null path)
           (setf ,!path (uiop:make-pathname* :directory path)))
         (,@(if dynamic-binding
                `(let ,dynamic-binding)
                `(progn))
          (map nil (lambda (file)
                     (let ((full-path (uiop/pathname:merge-pathnames*
                                       ,!current-path file)))
                       (load full-path)))
               (list ,@files))
          (restart-case
              (progn
                (when (null ,!path)
                  (error "Path was not set!"))
                (unless (uiop:directory-exists-p ,!path)
                  (error "Directory does not exists!"))
                (cl-lore.protocol.output:save-output
                 ,!path
                 (with-names ,names
                   (cl-lore.api.syntax:document
                       (,generator ,!output ,chunks :output-options ,output-options)
                     ,@document-form))))
            (set-path (path)
              :report "Set path."
              :interactive (lambda ()
                             (format *query-io* "Enter new path.~%")
                             (force-output *query-io*)
                             (list (read)))
              (,name path)))
          ,!path))
       (export (quote ,name)))))

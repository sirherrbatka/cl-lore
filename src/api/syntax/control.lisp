(in-package #:cl-lore.api.syntax)


(defmacro define-save-output-function (name
                                       (package names generator chunks)
                                       (&key output-options dynamic-binding)
                                       (&rest files)
                                       &body document-form)
  (let ((*package* (find-package package)))
    (with-gensyms (!path !output !current-path)
      `(let ((,!path nil)
             (,!current-path (uiop/pathname:pathname-directory-pathname
                              (uiop:current-lisp-file-pathname))))
         (defun ,name (&optional path)
           (declare (type (or null string pathname) path))
           (check-type path (or null list string pathname))
           (let ((*package* (find-package ,package)))
             (unless (null path)
               (setf ,!path (make-pathname :directory path)))
             (,@(if dynamic-binding
                    `(let ,dynamic-binding)
                    `(progn))
              (map nil
                   (lambda (file)
                     (let ((full-path (uiop/pathname:merge-pathnames*
                                       ,!current-path file))
                           (cl-lore.api.raw:*chunks* ,chunks)
                           (cl-lore.api.raw:*node-definitions*
                             (serapeum:merge-tables <standard-names> ,@names))
                           (cl-lore.api.raw:*stack* (make 'cl-lore.protocol.stack:top-stack-controller)))
                       (load full-path)))
                   (list ,@files))
              (restart-case
                  (progn
                    (when (null ,!path)
                      (error "Path was not set!"))
                    (unless (uiop:directory-exists-p ,!path)
                      (error "Directory ~a does not exists!" ,!path))
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
              ,!path)))))))

(in-package #:cl-user)


(asdf:defsystem cl-lore
  :name "cl-lore"
  :version "0.0.0"
  :license "MIT"
  :author "Lisp Mechanics"
  :maintainer "Lisp Mechanics"
  :depends-on (:iterate :alexandria :serapeum :scribble)
  :serial T
  :pathname "src"
  :components ((:file "package")
               (:module "protocol"
                :components ((:file "classes")
                             (:file "variables")
                             (:file "mapping")
                             (:file "generics")
                             (:file "make-functions")
                             (:file "impl")))
               (:module "api"
                :components ((:file "utility")
                             (:file "syntax-functions")
                             (:file "html")
                             (:file "interface-variables")
                             (:file "macros")))))

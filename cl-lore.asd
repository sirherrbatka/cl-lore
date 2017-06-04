(in-package #:cl-user)


(asdf:defsystem cl-lore
  :name "cl-lore"
  :version "0.0.0"
  :license "MIT"
  :author "Lisp Mechanics"
  :maintainer "Lisp Mechanics"
  :depends-on (:iterate :alexandria :serapeum
               :scribble :cl-who :docparser
               :closer-mop)
  :serial T
  :pathname "src"
  :components ((:file "package")
               (:module "protocol"
                :components ((:file "mop")
                             (:file "nodes")
                             (:file "control")
                             (:file "variables")
                             (:file "generics")
                             (:file "impl")))
               (:module "api"
                :components ((:file "utility")
                             (:file "syntax-functions")
                             (:file "interface-variables")
                             (:file "macros")))
               (:module "html"
                :components ((:file "package")
                             (:file "impl")))))


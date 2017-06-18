(in-package #:cl-user)


(asdf:defsystem cl-lore
  :name "cl-lore"
  :version "0.0.0"
  :license "MIT"
  :author "Lisp Mechanics"
  :maintainer "Lisp Mechanics"
  :depends-on (:iterate :alexandria :serapeum
               :scribble :cl-who :docstample
               :closer-mop)
  :serial T
  :pathname "src"
  :components ((:file "package")
               (:module "protocol"
                :components ((:file "package")
                             (:file "mop")
                             (:file "nodes")
                             (:file "traits")
                             (:file "classes")
                             (:file "output")
                             (:file "control")
                             (:file "generics")
                             (:file "variables")
                             (:file "impl")))
               (:module "api"
                :components ((:file "package")
                             (:file "utility")
                             (:file "macros")
                             (:file "mapping")
                             (:file "syntax-functions")
                             (:file "make-functions")
                             (:file "interface-variables")))
               (:module "html"
                :components ((:file "package")
                             (:file "classes")
                             (:file "interface-variables")
                             (:file "impl")))))


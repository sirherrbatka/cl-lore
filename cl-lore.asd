(in-package #:cl-user)


(asdf:defsystem cl-lore
  :name "cl-lore"
  :version "0.0.0"
  :license "MIT"
  :author "Lisp Mechanics"
  :maintainer "Lisp Mechanics"
  :depends-on (:iterate :alexandria :serapeum
               :scribble :cl-who :docstample
               :closer-mop :lass :cl-fad
               :cl-dot)
  :serial T
  :pathname "src"
  :components ((:file "package")
               (:module "utils"
                :components ((:file "package")
                             (:file "tree")
                             (:file "text")))
               (:module "protocol"
                :components ((:module "structure"
                              :components ((:file "package")
                                           (:file "mop")
                                           (:file "fundamental-traits")
                                           (:file "fundamental-nodes")
                                           (:file "generics")
                                           (:file "implementation")))
                             (:module "stack"
                              :compontents ((:file "package")
                                            (:file "generics")
                                            (:file "classes")
                                            (:file "condtitions")
                                            (:file "implementation")
                                            (:file "variables")))
                             (:module "collecting"
                              :components ((:file "package")
                                           (:file "generics")
                                           (:file "classes")
                                           (:file "conditions")
                                           (:file "implementation")))
                             (:module "output"
                              :components ((:file "package")
                                           (:file "generics")
                                           (:file "classes")
                                           (:file "implementation")))))
               (:module "api"
                :components ((:module "raw"
                              :components ((:file "package")
                                           (:file "make")
                                           (:file "traits")))
                             (:module "syntax"
                              :components ((:file "package")))
                             (:file "package")
                             (:file "utility")
                             (:file "macros")
                             (:file "mapping")
                             (:file "syntax-functions")
                             (:file "make-functions")
                             (:file "interface-variables")))
               (:module "graphics"
                :components ((:file "package")
                             (:file "image")
                             (:module "graph"
                              :components ((:file "package")
                                           (:file "common")
                                           (:file "class-graph")))))
               (:module "html"
                :components ((:file "package")
                             (:file "classes")
                             (:file "common")))
               (:module "extensions"
                :components ((:module "documentation"
                              :components ((:module "protocol"
                                            :components ((:file "package")
                                                         (:file "nodes")
                                                         (:file "information")
                                                         (:file "search")
                                                         (:file "html-output")))
                                           (:module "api"
                                            :components ((:file "package")))))))
               (:module "mechanics"
                :components ((:file "package")
                             (:file "style")
                             (:file "classes")
                             (:file "variables")
                             (:file "implementation")))))

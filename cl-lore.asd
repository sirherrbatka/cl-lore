(in-package #:cl-user)


(asdf:defsystem cl-lore
  :name "cl-lore"
  :version "0.0.0"
  :license "MIT"
  :author "Lisp Mechanics"
  :maintainer "Lisp Mechanics"
  :depends-on ( :iterate :alexandria :serapeum
                :scribble :cl-who :closer-mop
                :lass :cl-fad :cl-dot
                :documentation-utils-extensions
                :trivial-arguments :cl-svg)
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
                                           (:file "conditions")
                                           (:file "fundamental-traits")
                                           (:file "fundamental-nodes")
                                           (:file "generics")
                                           (:file "implementation")))
                             (:module "stack"
                              :components ((:file "package")
                                           (:file "generics")
                                           (:file "classes")
                                           (:file "conditions")
                                           (:file "implementation")))
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
                                           (:file "variables")
                                           (:file "conditions")
                                           (:file "implementation")
                                           (:file "internal-macros")
                                           (:file "traits")
                                           (:file "stack-functions")
                                           (:file "collecting-functions")))
                             (:module "syntax"
                              :components ((:file "package")
                                           (:file "syntax-functions")
                                           (:file "variables")
                                           (:file "syntax-macros")
                                           (:file "control")))))
               (:module "graphics"
                :components ((:file "package")
                             (:file "image")
                             (:module "graph"
                              :components ((:file "package")
                                           (:file "common")))))
               (:module "html"
                :components ((:file "package")
                             (:file "utils")
                             (:file "classes")
                             (:file "common")))
               (:module "extensions"
                :components ((:module "documentation"
                              :components ((:module "graphics"
                                            :components ((:file "package")
                                                         (:file "class-graph")))
                                           (:module "protocol"
                                            :components ((:file "package")
                                                         (:file "generics")
                                                         (:file "nodes")
                                                         (:file "classes")
                                                         (:file "variables")
                                                         (:file "information")
                                                         (:file "implementation")
                                                         (:file "search")
                                                         (:file "html-output")))
                                           (:module "api"
                                            :components ((:file "package")
                                                         (:file "variables")
                                                         (:file "syntax")))))
                             (:module "sequence-graphs"
                              :components ((:module "graphics"
                                            :components ((:file "package")
                                                         (:file "drawning")))
                                           (:module "protocol"
                                            :components ((:file "package")
                                                         (:file "nodes")))
                                           (:module "api"
                                            :components ((:file "package")
                                                         (:file "make")
                                                         (:file "syntax")
                                                         (:file "variables")))))))
               (:module "mechanics"
                :components ((:file "package")
                             (:file "style")
                             (:file "classes")
                             (:file "variables")
                             (:file "implementation")))))

(in-package "COMMON-LISP-USER")

(defun load-art ()
  (load "/media/sf_Shared-Folder/kem-systems/art/source/loaders/art-loader"))

(format t "type '(load-art)' to load ART~%")

;#+:cmu
(progn 
  ;(defparameter *load-binary-pathname-types* *load-object-types*)
  ;(defparameter *load-source-pathname-types* *load-source-types*)
  (defparameter *load-binary-pathname-types* '("fasl" "x86f" "sparcf" "ppcf" "mipsf" "alpha"))
  (defparameter *load-source-pathname-types* '("fasl" "lisp" "cl" "lsp"))
  (export '(*load-binary-pathname-types* *load-source-pathname-types*)))
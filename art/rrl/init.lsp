;; Copy this file to the directory where you like to run RRL, then
;; invoke AKCL (or any other Common Lisp) in that directory.
;; If your common lisp cannot automatically load the file "init.lsp",
;; type the lisp command (load "init.lsp").

(in-package 'user)

(defconstant *rrl-directory* "/home/systems/systeme-musik/art/rrl/")
(defconstant *code-directory* "code/") 
(defvar $example-directory (concatenate 'string *rrl-directory* "induc/"))
(defun rrlload (file) (load (concatenate 'string *rrl-directory* *code-directory* file)))

(rrlload "rrl")

;; Eschbach Wed Jan 29 21:10:20 MET 1997
;; switch is parsed into the command-line-switches
#+:cmu (ext:defswitch "-file")

#|
#+:cmu
;; Eschbach Wed Jan 29 22:09:30 MET 1997
;; sieht zwar gut aus, klappt aber nicht :-(
(save-lisp "rrl.core" :init-function 
	   #'cmu-init-function)
|#

#+:cmu
;; Eschbach Wed Jan 29 22:09:42 MET 1997
(defun cmu-init-function ()
  (start) 
  (first (get-command-line-switch "-file")))

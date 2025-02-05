(in-package "COMMON-LISP-USER")

(defpackage "FAST-PARSER")
(defpackage "SCANNER-GENERATOR")
(defpackage "GII")

(defpackage "COMPILE-ASF"
  (:export "COMPILE-ASF" "XRRL" "MODID2SPECIDENT" "RENAMING" "PARSE" "XVI" "EMACS"
	   "SET-SPEC-DIR!")
  (:use "FAST-PARSER" "SCANNER-GENERATOR" "GII" "COMMON-LISP"))

(defpackage "SAVE-RRL"
  (:export "SAVE-RRL")
  (:import-from "COMPILE-ASF" "MODID2SPECIDENT" "RENAMING" "PARSE")
  (:use "COMMON-LISP"))

(defpackage "ART"
  (:export "ART" "SAVE-RRL" "COMPILE-ASF" "XRRL" "XVI" "EMACS" "SET-SPEC-DIR!")
  (:use "SAVE-RRL" "COMPILE-ASF" "COMMON-LISP"))

(defpackage "COMMON-LISP-USER"
  (:use "ART" "COMMON-LISP" "EXTENSIONS"))


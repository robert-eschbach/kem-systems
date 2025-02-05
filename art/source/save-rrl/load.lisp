; ******************************************************************
; ** Diese Datei dient zur Entwicklung des Programmes und sollte  **
; ** am Anfang einer Lisp-Session geladen werden.                 **
; ******************************************************************

(IN-PACKAGE "SAVE-RRL")

(defun load-sys ()
  (load "~/save-rrl/spec")
  (load "~/save-rrl/globals")
  (load "~/save-rrl/log-parser")
  (load "~/save-rrl/spec-parser")
  (load "~/save-rrl/asf-parser")
  (load "~/save-rrl/comp-diff")
  (load "~/save-rrl/print-asf-file")
  (load "~/save-rrl/save-rrl")
)

(defun compile-sys ()
  (compile-file "~/save-rrl/spec")
  (compile-file "~/save-rrl/globals")
  (compile-file "~/save-rrl/log-parser")
  (compile-file "~/save-rrl/spec-parser")
  (compile-file "~/save-rrl/asf-parser")
  (compile-file "~/save-rrl/comp-diff")
  (compile-file "~/save-rrl/print-asf-file")
  (compile-file "~/save-rrl/save-rrl")
)

; load Dateien

(defun globals ()
  (load "~/save-rrl/globals")
)

(defun spec ()
  (load "~/save-rrl/spec")
)

(defun logparser ()
  (load "~/save-rrl/log-parser")
)

(defun specparser ()
  (load "~/save-rrl/spec-parser")
)

(defun asfparser ()
  (load "~/save-rrl/asf-parser")
)

(defun compdiff ()
  (load "~/save-rrl/comp-diff")
)

(defun printasffile ()
  (load "~/save-rrl/print-asf-file")
)

; lade Carlos Parser
(load "~/save-rrl/load-parser")


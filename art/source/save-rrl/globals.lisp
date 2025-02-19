; *************************************************************************
; ** globals.lisp                                                        **
; **                                                                     **
; ** Diese Datei enthaelt alle globalen Variablen und ein ausfuehrliches **
; ** Kommentar zu ihrer Semantik                                         **
; *************************************************************************

(IN-PACKAGE "SAVE-RRL") 


;**********************************************************************
;** semantics  : Ausgabe-Staerke                                     **
;** remark     : 0 keine Ausgabe ...                                 **
;** edited     : 13.5.1992                                           **
;**********************************************************************
(defvar *trace-level* 0)

;**********************************************************************
;** semantics  : Ausgabe-Stream fuer trace-output                    **
;** remark     :                                  **
;** edited     : 14.5.1992                                           **
;**********************************************************************
(defvar *output-stream* t)

;**********************************************************************
;** semantics  : alle Theoreme, welche nicht in der ASF-Spezifikation**
;**  enthalten waren                                                 **
;** remark     :                                                     **
;** edited     : 03.06.1992                                          **
;**********************************************************************
(defvar *proved-additional-theorems* nil)

;**********************************************************************
;** semantics  : Tabelle zum Steuern des RRL-LOG-Parsers             **
;** remark     : Zugriff nur ueber Funktionen!                       **
;** edited     : 2.5.1991                                            **
;**********************************************************************
(defvar *rrl-log-parse-table* (list nil))

;**********************************************************************
;** semantics  : Tabelle zum Steuern des RRL-SPEC-Parsers            **
;** remark     : Der Parser versucht einen Tabelleneintrag, der Teil-**
;**              string der aktuellen Zeile ist. Bei Erfolg wird die **
;**              assozierte Funktion ausgefuehrt.                    **
;**              Wird kein Teilstring gefunden, wird versucht eine   **
;**              Gleichung zu lesen.                                 **
;** edited     : 29.5.1991                                           **
;**********************************************************************
(defvar *rrl-spec-parse-table* 
  '(("the arities of the operators are"
        read-arities)
    ("the system has the following constructors:"
        read-constructors)
    ("equivalence relation among operators"
        read-equivalence)
    ("precedence relation"
        read-precedence)
    ("operators with status"
        read-status)
    ("associative & commutative operator set"
        read-ac-set)
    ("commutative operator set"
        read-c-set)
    ("transitive operator set"
        nil)
    ("there are no equivalent operators."
        nil)
    ("there is no ordering yet in the precedence relation."
        nil)
    ("there are no operators with status."
        nil)
   )
)

;**********************************************************************
;** semantics  : Spezifikations-Datenstruktur zum Parsen der log-    **
;**              Datei                                               **
;** remark     :                                                     **
;** edited     : 8.5.1991                                            **
;**********************************************************************
(defvar *log-spec* (make-spec))

;**********************************************************************
;** semantics  : Spezifikations-Datenstruktur zum Parsen der ASF-    **
;**              Datei                                               **
;** remark     :                                                     **
;** edited     : 8.5.1991                                            **
;**********************************************************************
(defvar *asf-spec* (make-spec))

;**********************************************************************
;** semantics  : Spezifikations-Datenstruktur der Differenz zwischen **
;**              der ASF- und der RRL-Spezifikation.                 **
;** remark     :                                                     **
;** edited     : 29.5.1991                                           **
;**********************************************************************
(defvar *diff-spec* (make-spec))

;**********************************************************************
;** semantics  : Spezifikations-Datenstruktur der Differenz zwischen **
;**              der RRL- und der ASF-Spezifikation.                 **
;** remark     :                                                     **
;** edited     : 20.6.1991                                           **
;**********************************************************************
(defvar *diff-asf-spec* (make-spec))

;**********************************************************************
;** semantics  : Boole'sche Variable fuer den Testzustand            **
;** remark     :                                                     **
;** edited     : 29.5.1991                                           **
;**********************************************************************
(defvar *test* nil)


;**********************************************************************
;** function name :  initialize                                      **
;** arguments     :                                                  **
;** effect        :  initialisiert globale (laufabhaengige) Variablen**
;** return value  :                                                  **
;** edited        :  3.6.1991                                        **
;**********************************************************************
(defun initialize ()
  (setq *log-spec* (make-spec))
  (setq *asf-spec* (make-spec))
  (setq *diff-spec* (make-spec))
  (setq *diff-asf-spec* (make-spec))
  (setq *proved-additional-theorems* nil)
)

; ******************************************************************
; ** filename : spec.lisp                                         **
; ******************************************************************
; ** Diese Datei stellt die Funktionen fuer die Spezifikations-   **
; ** tabelle zur Verfuegung.					  **
; ******************************************************************
;** Version : euklid !!! **
; Erlaeuterung der Argumente:
;
;  insert-spec
;  -----------
;
;  sort:          ("Sorte" ..)
;  function:      (("f" ("s1" ... "sn") ("t1" ... "tm") "functor"/"infix"/"prefix") ..) 
;  variable:      (("Variable" "Sorte" &optional spec-pfad) ..)
;  add-equation:  (("t1" "=="/":="/"-->" "t2" ("t1,3" "t2,3" .. "t1,n" "t2,n")) ..)
;  spec-equation: (("t1" "=="/":="/"-->" "t2" ("t1,3" "t2,3" .. "t1,n" "t2,n")) ..)
;  option:        ("lrpo" ..)
;  constructor:   (("succ" ?) ...)
;                 "succ"      - unbekannt, ob frei
;                 "succ" NIL  - nicht frei
;                 "succ" TRUE - frei
;  ac-operator:   ("succ" ...)
;  c-operator:    ("succ" ...)
;  status:        (("succ" "l"/"r"/"m") ...)
;  precedence:    (("succ" "pred" .. "0") ...)
;                 "succ" > "pred" .. "0"
;  prove:         ("t1" "=="/"-->" "t2" ("t1,3" "t2,3" .. "t1,n" "t2,n")
;                                       ("e"/"o"/"h"))
;  suffice:       (("succ" ?) ...)
;                 "succ" NIL  - nicht sufficient complete
;                 "succ" TRUE - sufficient complete


(IN-PACKAGE "SAVE-RRL")

;**********************************************************************
;** function name :  make-spec                                       **
;** arguments     :                                                  **
;** effect        :                                                  **
;** return value  :  leere Datenstruktur fuer eine Spezifikation     **
;** edited        :  3.6.1991                                        **
;**********************************************************************
(defun make-spec ()
  (list (make-set)   ; Sorten                Index: 0
        (make-set)   ; Funktionen            Index: 1
        (make-set)   ; Variablen             Index: 2
        nil          ; add-Gleichungen       Index: 3
        nil          ; spec-Gleichungen      Index: 4
        (make-set)   ; Optionen              Index: 5
        (make-set)   ; Konstruktoren         Index: 6
        (make-set)   ; AC-Operatoren         Index: 7
        (make-set)   ; C-Operatoren          Index: 8
        (make-set)   ; Status                Index: 9
        (make-liste) ; Ordnung               Index: 10
        nil          ; Theoreme              Index: 11
        (make-liste) ; Sufficient Complete   Index: 12
  )
)

;**********************************************************************
;** function name :  insert-spec                                     **
;** arguments     :  Spezifikation, Befehlscode und Argumente        **
;** effect        :  fuegt die Argumente (destruktiv) gemaess des    **
;**                  Codes in die Spezifikation ein                  **
;** return value  :  die geaenderte Spezifikation                    **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun insert-spec (spec code liste)
  (cond ((equal code 'sort)
         (dolist (l liste) 
                 (insert-set (nth 0 spec) (list l)))
	)
	((equal code 'function)
         (dolist (l liste)
                 (insert-set (nth 1 spec) l))
        )
        ((equal code 'variable)
         (dolist (l liste)		
		 (if (var-spec l) ; es koennen gleiche Variablen in unterschiedlichen Modulen auftreten
					; etwa x : -> NAT in den Modulen nat und arithmetic
;		     (push l (nth 2 spec))
		     (rplaca (nth 2 spec) (cons l (car (nth 2 spec))))
		   (insert-set (nth 2 spec) l)))
        )
	((equal code 'add-equation)
         (do ((l liste (cdr l))
              (spec-list (nth 3 spec))
             )
             ((null l)
              (rplaca (nthcdr 3 spec) spec-list)
             )
             (push (car l) spec-list)
         )
	)
	((equal code 'spec-equation)
         (do ((l liste (cdr l))
              (spec-list (nth 4 spec))
             )
             ((null l)
              (rplaca (nthcdr 4 spec) spec-list)
             )
             (push (car l) spec-list)
         )
	)
	((equal code 'option)
         (dolist (l liste)
                 (insert-set (nth 5 spec) (list l)))
	)
        ((equal code 'constructor)
         (dolist (l liste)
                 (if (cdr l)
                     (insert-set (nth 6 spec)  
                                 (list (car l)
                                       (if (cadr l)
                                           'frei
                                           nil
                                       )
                                 )
                     )
                     (insert-set-no-attr (nth 6 spec)
                                         (list (car l))
                     )
                 )
         )
        )
	((equal code 'ac-operator)
         (dolist (l liste)
                 (insert-set (nth 7 spec) (list l)))
	)
	((equal code 'c-operator)
         (dolist (l liste)
                 (insert-set (nth 8 spec) (list l)))
	)
        ((equal code 'status)
         (dolist (l liste)
                 (insert-set (nth 9 spec) l))
	)
	((equal code 'precedence)
         (dolist (l liste)
                 (do ((k (cdr l) (cdr k))
                      (key (car l))
                     )
                     ((null k) )
                     (insert-liste (nth 10 spec) (list key (car k)))
                 ))
        )
	((equal code 'prove)
          (do ((l liste (cdr l))
              (spec-list (nth 11 spec))
             )
             ((null l)
              (rplaca (nthcdr 11 spec) spec-list)
             )
             (push (car l) spec-list)
         )
	)
        ((equal code 'suffice)
          (dolist (l liste)
                   (insert-set (nth 12 spec) 
                               (list (car l)
                                     (if (and (cadr l)
                                              (not (equal (cadr l) "not-sufficient")))
                                         'sufficient
                                         'not-sufficient
                                     )
                               )
                   ))
	)
	('t
	  (error "Fehler in ADT-spec! Unbekannter Code: " code)
        )
  )
  spec
)

;**********************************************************************
;** function name :  get-spec                                        **
;** arguments     :  Spezifikation, Befehlscode                      **
;** return value  :  alle Eintraege unter dem Code                   **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun get-spec (spec code)
  (cond ((equal code 'sort)
         (list-set (nth 0 spec))
	)
	((equal code 'function)
         (list-set (nth 1 spec))
	)
        ((equal code 'variable)
         (list-set (nth 2 spec))
	)
	((equal code 'add-equation)
         (nth 3 spec)
	)
	((equal code 'spec-equation)
         (nth 4 spec)
	)
	((equal code 'option)
         (list-set (nth 5 spec))
	)
        ((equal code 'constructor)
         (list-set (nth 6 spec))
	)
	((equal code 'ac-operator)
         (list-set (nth 7 spec))
	)
	((equal code 'c-operator)
         (list-set (nth 8 spec))
        )
        ((equal code 'status)
         (list-set (nth 9 spec))
	)
	((equal code 'precedence)
         (list-liste (nth 10 spec))
        )
	((equal code 'prove)
         (nth 11 spec)
	)
        ((equal code 'suffice)
         (list-set (nth 12 spec))
	)
	('t
	 (error "Fehler in ADT-spec! Unbekannter Code: " code)
        )
  )
)

;**********************************************************************
;** function name :  get-entry                                       **
;** arguments     :  Spezifikation, Befehlscode, Symbol              **
;** return value  :  gibt Eintrag fuer das betreffende Symbol        **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun get-entry (spec code symbol)
  (cond ((equal code 'sort)
         (get-key-set (nth 0 spec) symbol)
	)
	((equal code 'function)
         (get-key-set (nth 1 spec) symbol)
	)
        ((equal code 'variable)
         (get-key-set (nth 2 spec) symbol)
	)
	((equal code 'option)
         (get-key-set (nth 5 spec) symbol)
	)
        ((equal code 'constructor)
         (get-key-set (nth 6 spec) symbol)
	)
	((equal code 'ac-operator)
         (get-key-set (nth 7 spec) symbol)
	)
	((equal code 'c-operator)
         (get-key-set (nth 8 spec) symbol)
	)
        ((equal code 'status)
         (get-key-set (nth 9 spec) symbol)
	)
	((equal code 'precedence)
         (get-key-liste (nth 10 spec) symbol)
        )
        ((equal code 'suffice)
         (get-key-set (nth 12 spec) symbol)
	)
	('t
	 (error "Fehler in ADT-spec! Unbekannter oder nicht unterstuetzter Code : " code)
	)
  )
)

;**********************************************************************
;** function name :  delete-spec                                     **
;** arguments     :  Spezifikation, Befehlscode                      **
;** effect        :  loescht alle Eintraege unter dem Code           **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun delete-spec (spec code)
  (cond ((equal code 'sort)
         (kill-set (nth 0 spec))
	)
	((equal code 'function)
         (kill-set (nth 1 spec))
	)
        ((equal code 'variable)
         (kill-set (nth 2 spec))
	)
	((equal code 'add-equation)
         (rplaca (nthcdr 3 spec) nil)
        )
	((equal code 'spec-equation)
         (rplaca (nthcdr 4 spec) nil)
	)
	((equal code 'option)
         (kill-set (nth 5 spec))
	)
        ((equal code 'constructor)
         (kill-set (nth 6 spec))
	)
	((equal code 'ac-operator)
         (kill-set (nth 7 spec))
	)
	((equal code 'c-operator)
         (kill-set (nth 8 spec))
	)
        ((equal code 'status)
         (kill-set (nth 9 spec))
        )
	((equal code 'precedence)
         (kill-liste (nth 10 spec))
        )
	((equal code 'prove)
         (rplaca (nthcdr 11 spec) nil)
	)
        ((equal code 'suffice)
         (kill-set (nth 12 spec))
	)
	('t
	 (error "Fehler in ADT-spec! Unbekannter Code: " code)
	)
  )
)

;**********************************************************************
;** function name :  delete-entry                                    **
;** arguments     :  Spezifikation, Befehlscode, Symbol              **
;** return value  :  loescht Eintrag fuer das betreffende Symbol     **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun delete-entry (spec code symbol)
  (cond ((equal code 'sort)
         (delete-key-set (nth 0 spec) symbol)
	)
	((equal code 'function)
         (delete-key-set (nth 1 spec) symbol)
	)
        ((equal code 'variable)
         (delete-key-set (nth 2 spec) symbol)
	)
	((equal code 'option)
         (delete-key-set (nth 4 spec) symbol)
	)
        ((equal code 'constructor)
         (delete-key-set (nth 5 spec) symbol)
	)
	((equal code 'ac-operator)
         (delete-key-set (nth 6 spec) symbol)
	)
	((equal code 'c-operator)
         (delete-key-set (nth 7 spec) symbol)
	)
        ((equal code 'status)
         (delete-key-set (nth 8 spec) symbol)
	)
	((equal code 'precedence)
         (delete-key-liste (nth 9 spec) symbol)
        )
        ((equal code 'suffice)
         (delete-key-set (nth 11 spec) symbol)
        )
	('t
	 (error "Fehler in ADT-spec! Unbekannter oder nicht unterstuetzter Code: " code)
	)
  )
)

;**********************************************************************
;** function name :  print-spec                                      **
;** arguments     :  Spezifikation                                   **
;** effect        :  druckt den Inhalt der Spezifikation auf den     **
;**                  Bildschirm                                      **
;** return value  :                                                  **
;** remarks       :  dient nur zu TEST-ZWECKEN !!                    **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-spec (spec)
  (let ((data nil)
       )
       (setq data (get-spec spec 'sort))
       (when data
             (format t "~%sorts : ")
             (print-sort data)
       )
       (setq data (get-spec spec 'function))
       (when data
             (format t "~%functions : ")
             (print-function data)
       )
       (setq data (get-spec spec 'variable))
       (when data      
             (format t "~%variables : ")
             (print-variable data)
       )
       (setq data (get-spec spec 'add-equation))
       (when data
             (format t "~%add-equations: ")
             (print-equation data)
       )
       (setq data (get-spec spec 'spec-equation))
       (when data
             (format t "~%spec-equations : ")
             (print-equation data)
       )
       (setq data (get-spec spec 'option))
       (when data
             (format t "~%options : ") 
             (print-option data)
       )
       (setq data (get-spec spec 'constructor))
       (when data
             (format t "~%constructors : ")
             (print-constructor data)
       ) 
       (setq data (get-spec spec 'ac-operator))
       (when data
             (format t "~%ac-operators : ") 
             (print-ac-operator data)
       )
       (setq data (get-spec spec 'c-operator))
       (when data
             (format t "~%c-operators : ") 
             (print-c-operator data)
       )
       (setq data (get-spec spec 'status))
       (when data
             (format t "~%status : ")
             (print-status data)
       )
       (setq data (get-spec spec 'precedence))
       (when data
             (format t "~%precedence : ")
             (print-precedence data)
       )
       (setq data (get-spec spec 'prove))
       (when data
             (format t "~%theorems : ")
             (print-prove data)
       )
       (setq data (get-spec spec 'suffice))
       (when data
             (format t "~%sufficient complete : ") 
             (print-suffice data)
       )
  )
  (terpri) (terpri)
)

;**********************************************************************
;** function name :  print-sort                                      **
;** arguments     :  Liste von Sorten                                **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-sort (sort)
  (dolist (l sort)
          (format t "~%   ~A" (car l))
  )
)

;**********************************************************************
;** function name :  print-variable                                  **
;** arguments     :  Liste von Variablendeklarationen                **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-variable (variable)
  (dolist (l variable)
      (format t "~%   ~A :-> ~A" (car l) (cadr l))
  )
)

;**********************************************************************
;** function name :  print-function                                  **
;** arguments     :  Liste von Funktionsdeklarationen                **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-function (function)
  (dolist (l function)
          (format t "~%   ")
          (when (member (fdef-code l) '("infix" "prefix") :test 'equal)
                (format t "_ ")
          )
          (princ (fdef-name l))
          (when (member (fdef-code l) '("infix") :test 'equal)
                (format t " _")
          )
          (princ " : ")
          (do ((k (fdef-eingabe-sorten l) (cdr k))
              )
              ((null k) )
              (format t "~A " (car k))
          )
          (princ "-> ")
          (do ((k (fdef-ausgabe-sorten l) (cdr k))
              )
              ((null k) )
              (format t "~A " (car k))
          )
 )
)

;**********************************************************************
;** function name :  print-equation                                  **
;** arguments     :  Liste von Gleichungen                           **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-equation (equation)
  (dolist (l equation)
          (format t "~%   ")
          (print-term (equ-t1 l))
          (format t " ~A " (equ-gl l))
          (print-term (equ-t2 l))
          (when (equ-conds l)
                (format t " if { ")
                (do ((cond (equ-conds l) (cddr cond))
                    )
                    ((null (cddr cond))
                     (print-term (car cond))
                     (format t " = ")
                     (print-term (cadr cond))
                    )
                    (print-term (car cond))
                    (format t " = ")
                    (print-term (cadr cond))
                    (format t ", ")
                )
                (format t " }")
         )
  )
)

;**********************************************************************
;** function name :  print-option                                    **
;** arguments     :  Liste von Optionen                              **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-option (option) 
  (dolist (l option)
          (format t "~%   ~A" (car l))
  )
)

;**********************************************************************
;** function name :  print-constructor                               **
;** arguments     :  Liste von Konstruktoren                         **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-constructor (constructor) 
  (do ((l constructor (cdr l))
       (frei nil)
       (nicht-frei nil)
       (unknown nil)
      )
      ((null l)
        (format t "~%   frei :       ")
        (do ((k frei (cdr k))
            )
            ((null k))
            (format t "~A " (car k))
        )
        (terpri) (princ "   nicht frei : ")
        (do ((k nicht-frei (cdr k))
            )
            ((null k))
            (format t "~A " (car k))
        )
        (terpri) (princ "   unbekannt  : ")
        (do ((k unknown (cdr k))
            )
            ((null k))
            (format t "~A " (car k))
        )
       )
       (cond ((null (cdar l))
              (push (caar l) unknown))
             ((equal (cadar l) 'frei)
              (push (caar l) frei))
             ('TRUE
              (push (caar l) nicht-frei))
       )
  )
)

;**********************************************************************
;** function name :  print-ac-operator                               **
;** arguments     :  Liste von AC-Operatoren                         **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-ac-operator (ac-operator) 
  (dolist (l ac-operator)
          (format t "~%   ~A" (car l))
  )
)

;**********************************************************************
;** function name :  print-c-operator                                **
;** arguments     :  Liste von C-Operatoren                          **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-c-operator (c-operator) 
  (dolist (l c-operator)
          (format t "~%   ~A" (car l))
  )
)

;**********************************************************************
;** function name :  print-status                                    **
;** arguments     :  Liste von Stati                                 **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-status (status)
  (dolist (l status)
          (format t "~%   ~A ~A" (car l) (cadr l))
  )
)

;**********************************************************************
;** function name :  print-precedence                                **
;** arguments     :  Ordnungsliste                                   **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-precedence (precedence)
  (dolist (l precedence)
          (format t "~%   ~A > ~A" (car l) (cadr l))
  )
)

;**********************************************************************
;** function name :  print-prove                                     **
;** arguments     :  Liste von Theoremen                             **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-prove (prove)
  (dolist (l prove)
          (format t "~%   ")
          (print-term (equ-t1 l))
          (format t " ~A " (equ-gl l))
          (print-term (equ-t2 l))
          (when (equ-conds l)
                (format t " if { ")
                (do ((cond (equ-conds l) (cddr cond))
                    )
                    ((null (cddr cond))
                     (print-term (car cond))
                     (format t " = ")
                     (print-term (cadr cond))
                    )
                    (print-term (car cond))
                    (format t " = ")
                    (print-term (cadr cond))
                    (format t ", ")
                )
                (format t " }")
         )
         (when (equ-flags l)
               (format t " Flags ")
               (do ((k (equ-flags l) (cdr k))
                   )
                   ((null (cdr k)) 
                    (format t "~A" (car k))
                   )
                   (format t "~A, " (car k))
               )
         )
  )
)

;**********************************************************************
;** function name :  print-suffice                                   **
;** arguments     :  Liste von Sufficient Deklarationen              **
;** effect        :  druckt den Inhalt der Liste auf den Bildschirm  **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun print-suffice (suffice) 
  (do ((l suffice (cdr l))
       (suffice nil)
       (not-suffice nil)
      )
      ((null l)
        (format t "~%   sufficient:     ")
        (do ((k suffice (cdr k))
            )
            ((null k))
            (format t "~A " (car k))
        )
        (format t "~%   not sufficient: ")
        (do ((k not-suffice (cdr k))
            )
            ((null k))
            (format t "~A " (car k))
        )
       )
       (if (equal (cadar l) 'sufficient)
           (push (caar l) suffice)
           (push (caar l) not-suffice)
       )
  )
)

;**********************************************************************
;** function name :  print-term                                      **
;** arguments     :  Term in Baumdarstellung                         **
;** effect        :                                                  **
;** return value  :                                                  **
;** edited        :  10.6.1991                                       **
;**********************************************************************
(defun print-term (term)
  (cond ((atom term)
         (format t "~A" term))
        ((equal (term-code term) "prefix")
         (format t "(~A " (term-function term))
         (print-term (car (term-args term)))
         (format t ")"))
        ((equal (term-code term) "infix")
         (format t "(")
         (print-term (car (term-args term)))
         (format t " ~A " (term-function term))
         (print-term (cadr (term-args term)))
         (format t ")"))
        ((equal (term-code term) "functor")
         (format t "~A(" (term-function term))
         (do ((l (term-args term) (cdr l))
             )
             ((null (cdr l))
              (print-term (car l))
              (format t ")"))
             (print-term (car l))
             (format t ", ")
         )
        )
  )
)


;**********************************************************************
;**                    Hilfsstrukturen                               **
;**********************************************************************


; Menge von Objekten mit Attributen
; ---------------------------------

; ein Objekt existiert nur einmal

;**********************************************************************
;** function name :  make-set                                        **
;** arguments     :                                                  **
;** effect        :                                                  **
;** return value  :  leere Menge                                     **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun make-set ()
  (list nil)
)

;**********************************************************************
;** function name :  kill-set                                        **
;** arguments     :  set                                             **
;** effect        :  loescht Menge                                   **
;** return value  :                                                  **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun kill-set (set)
  (rplaca set nil)
)

;**********************************************************************
;** function name :  insert-set                                      **
;** arguments     :  Menge, Objekt und zugehoerige Attribute         **
;** effect        :  fuegt Objekt (destruktiv) in die Menge ein      **
;** return value  :                                                  **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun insert-set (set attributes)
  (let ((eintrag (assoc (car attributes) (car set) :test 'equal))
       )
       (if eintrag
           (rplacd eintrag (cdr attributes))
           (rplaca set
                   (cons attributes (car set))
           )
       )
  )
)

;**********************************************************************
;** function name :  insert-set-no-attr                              **
;** arguments     :  Menge, Objekt und zugehoerige Attribute         **
;** effect        :  fuegt Objekt (destruktiv) in die Menge ein      **
;** return value  :                                                  **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun insert-set-no-attr (set attributes)
  (let ((eintrag (assoc (car attributes) (car set) :test 'equal))
       )
       (if eintrag
           ; Attribute sollen nicht veraendert werden
           nil
           (rplaca set
                   (cons attributes (car set))
           )
       )
  )
)

;**********************************************************************
;** function name :  list-set                                        **
;** arguments     :  Menge                                           **
;** effect        :                                                  **
;** return value  :  Liste der Elemente                              **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun list-set (set)
  (car set)
)

;**********************************************************************
;** function name :  get-key-set                                     **
;** arguments     :  Menge, Symbol                                   **
;** effect        :                                                  **
;** return value  :  Symboleintrag                                   **
;** edited        :  6.6.1991                                        **
;**********************************************************************
(defun get-key-set (set symbol)
  (assoc symbol (car set) :test 'equal)
)

;**********************************************************************
;** function name :  delete-key-set                                  **
;** arguments     :  Menge, Symbol                                   **
;** effect        :  loescht Symbol aus Menge                        **
;** return value  :                                                  **
;** edited        :  6.6.1991                                        **
;**********************************************************************
(defun delete-key-set (set symbol)
  (rplaca set (print (remove (get-key-set set symbol) (car set) :test 'equal)))
)

; Liste von Objekten mit Attributen
; ---------------------------------

; eine Objekt-Attribute Kombination existiert nur einmal

;**********************************************************************
;** function name :  make-liste                                      **
;** arguments     :                                                  **
;** effect        :                                                  **
;** return value  :  leere Liste                                     **
;** edited        :  3.6.1991                                        **
;**********************************************************************
(defun make-liste ()
  (list nil)
)

;**********************************************************************
;** function name :  kill-liste                                      **
;** arguments     :  liste                                           **
;** effect        :  loescht Liste                                   **
;** return value  :                                                  **
;** edited        :  12.6.1991                                       **
;**********************************************************************
(defun kill-liste (liste)
  (rplaca liste nil)
)

;**********************************************************************
;** function name :  insert-liste                                    **
;** arguments     :  Liste, Objekt und zugehoerige Attribute         **
;** effect        :  fuegt Objekt (destruktiv) in die Liste ein      **
;** return value  :                                                  **
;** edited        :  3.6.1991                                        **
;**********************************************************************
(defun insert-liste (liste attributes)
  (let ((eintrag (member attributes (car liste) :test 'equal))
       )
       (unless eintrag
               (rplaca liste
                       (cons attributes (car liste))
               )
       )
  )
)

;**********************************************************************
;** function name :  list-liste                                      **
;** arguments     :  Liste                                           **
;** effect        :                                                  **
;** return value  :  Liste der Elemente                              **
;** edited        :  31.5.1991                                       **
;**********************************************************************
(defun list-liste (liste)
  (car liste)
)

;**********************************************************************
;** function name :  get-key-liste                                   **
;** arguments     :  Liste, Symbol                                   **
;** effect        :                                                  **
;** return value  :  Symboleintrag                                   **
;** edited        :  6.6.1991                                        **
;**********************************************************************
(defun get-key-liste (liste symbol)
  (do ((l (car liste) (cdr l))
       (result nil (if (equal symbol (caar l))
                       (cons (car l) result)
                       result
                   ))
      )
      ((null (cdr l)) result)
  )
)

;**********************************************************************
;** function name :  delete-key-liste                                **
;** arguments     :  Liste, Symbol                                   **
;** effect        :  loescht Symbol aus der Liste                    **
;** return value  :                                                  **
;** edited        :  6.6.1991                                        **
;**********************************************************************
(defun delete-key-liste (liste symbol)
  (rplaca liste (remove (get-key-liste liste symbol) (car liste) :test 'equal))
)

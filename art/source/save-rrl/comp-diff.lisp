; *********************************************************************
; ** filename : comp-diff.lisp                                       **
; *********************************************************************  
; ** Diese Datei berechnet die Differenz zwischen der ASF-Spezi-     **
; ** fikation und der RRL-Ausgabe.                                   **
; *********************************************************************


(IN-PACKAGE "SAVE-RRL")


;**********************************************************************
;** function name :  comp-diff                                       **
;** arguments     :                                                  **
;** effect        :  Berechnet die Differenz RRL - ASF und schreibt  **
;**                  diese in *diff-spec*. Ist ASF - RRL ungleich    **
;**                  Null, so wird das auf dem Bildschirm ausgegeben.**
;** return value  :                                                  **
;** edited        :  14.6.1991                                       **
;**********************************************************************
(defun comp-diff ()
  (when *test*
        (print "------------------------------------------------------------------")
        (print-spec *asf-spec*)
        (print "------------------------------------------------------------------")
        (print-spec *log-spec*)
        (print "------------------------------------------------------------------")
  )
  ; berechne die Differenz-Spezifikationen *diff-spec* und *diff-asf-spec*
  (let ((asf nil)
        (diff nil)
        (not-nil-diff-asf nil)
        (proves nil)
       )
  ; Sorten
       (setq diff (set-diff (simplify-structure (get-spec *asf-spec* 'sort))
                            (simplify-structure (get-spec *log-spec* 'sort))))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'sort (car diff))
       )
       (insert-spec *diff-spec* 'sort (cadr diff))
  ; Funktionen
       ; hier wird assoc-diff verwendet, weil Funktionsnamen eindeutig sind
       (setq diff (assoc-diff (get-spec *asf-spec* 'function)
                              (get-spec *log-spec* 'function)))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'function (car diff))
       )
       (insert-spec *diff-spec* 'function (cadr diff))
  ; Optionen
       (setq diff (set-diff (simplify-structure (get-spec *asf-spec* 'option))
                            (simplify-structure (get-spec *log-spec* 'option))))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'option (car diff))
       )
       (insert-spec *diff-spec* 'option (cadr diff))
  ; Konstruktoren
       ; hier wird set-diff verwendet, weil die assoziierten Werte wichtig sind
       (setq diff (set-diff (get-spec *asf-spec* 'constructor)
                            (get-spec *log-spec* 'constructor)))
       ; gemeldet werden nur die Werte, die etwas assoziiert haben
       (setq asf (collect-length-2 (car diff))) 
       (when asf
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'constructor asf)
       )
       (insert-spec *diff-spec* 'constructor (cadr diff))
  ; C-Operatoren
       (setq diff (set-diff 
                      (simplify-structure (get-spec *asf-spec* 'c-operator))
                      (simplify-structure (get-spec *log-spec* 'c-operator))))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'c-operator (car diff))
       )
       (insert-spec *diff-spec* 'c-operator (cadr diff))
  ; AC-Operatoren
       (setq diff (set-diff 
                      (simplify-structure (get-spec *asf-spec* 'ac-operator))
                      (simplify-structure (get-spec *log-spec* 'ac-operator))))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'ac-operator (car diff))
       )
       (insert-spec *diff-spec* 'ac-operator (cadr diff))
  ; Statusangaben
       ; hier wird set-diff verwendet, weil die assoziierten Werte wichtig sind
       (setq diff (set-diff (get-spec *asf-spec* 'status)
                            (get-spec *log-spec* 'status)))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'status (car diff))
       )
       (insert-spec *diff-spec* 'status (cadr diff))
  ; Vollstaendigkeit
       ; hier wird set-diff verwendet, weil die assoziierten Werte wichtig sind
       (setq diff (assoc-diff (get-spec *asf-spec* 'suffice)
                              (get-spec *log-spec* 'suffice)))
       (when (car diff)
             (setq not-nil-diff-asf 'TRUE)
             (insert-spec *diff-asf-spec* 'suffice (car diff))
       )
       (insert-spec *diff-spec* 'suffice (cadr diff))

  ; Gleichungen
       (let ((asf-equations
                 (do ((theorems (get-spec *asf-spec* 'prove) (cdr theorems))
                      (equs (get-spec *asf-spec* 'add-equation)
                            (if (member "o" (caddr (cddar theorems)) :test 'equal)
                                (cons (car theorems) equs)
                                equs
                            )
                      )
                     )
                     ((null theorems)
                      equs
                     )
                 )
             )
            )
       ; Add-Gleichungen
            (setq diff (equ-diff asf-equations
                                 (get-spec *log-spec* 'add-equation)))
            (when (car diff)
                  (insert-spec *diff-asf-spec* 'add-equation (car diff))
            )
;***************************nur zum Testen****
(print asf-equations)
(print (car diff))
(print (cadr diff))
;****************************
            (insert-spec *diff-spec* 'add-equation (cadr diff))
       ; Spec-Gleichungen
            (setq diff (equ-diff asf-equations
                                 (get-spec *log-spec* 'spec-equation)))
            ; beachte, dass nur die Gleichungen nicht in RRL sind, die sowohl nicht
            ; in add- als auch in spec-equation von *log-spec* sind
            (let ((diff2 (equ-diff (car diff) 
                                   (get-spec *diff-asf-spec* 'add-equation)))
                 )
                 (delete-spec *diff-asf-spec* 'add-equation)
                 (when (caddr diff2)
                       (setq not-nil-diff-asf 'TRUE)
                       (insert-spec *diff-asf-spec* 'add-equation (caddr diff2))
                 )
            )
            (insert-spec *diff-spec* 'spec-equation (cadr diff))
       ; Theoreme
            ; hier wird set-diff verwendet, weil die assoziierten Werte wichtig sind
            (setq diff (equ-diff-prove (get-spec *asf-spec* 'prove)
                                       (get-spec *log-spec* 'prove)))
            (when (car diff)
                  (setq not-nil-diff-asf 'TRUE)
                  (insert-spec *diff-asf-spec* 'prove (car diff))
            )
            (setq proves (cadr diff))
            (insert-spec *diff-spec* 'prove (caddr diff))
       )

  ;** Vergleich der precedence **
  (compute-difference-precedence)
   
  ; weise Benutzer auf Unterschiede in der ASF-Spezifikation hin:
       (when not-nil-diff-asf
             (format t "~%~% Folgende Angaben waren in der ASF-Spezifikation, aber nicht in den RRL-Dateien:")
             (show *diff-asf-spec*)
       )
       ; zeige Benutzer den Ausgang der Proves
       (show-proves (get-spec *log-spec* 'prove))
       ; Frage nach, ob add- oder kb-Gleichungen verwendet werden sollen
       (add-or-kb *diff-spec*)
       (format t "~%~%Wollen Sie folgende Theoreme aus den RRL-Dateien uebernehmen:~%")
       (selective-insert *diff-spec* 'prove proves)
  )
  (when *test*
        (print "------------------------------------------------------------------")
        (print-spec *diff-spec*)
  )
)

;***********************************************************************

(defun compute-difference ()
  (print "computing difference ... ")

  (compute-difference-sorts)
  (compute-difference-functions)
  (compute-difference-options)
  (compute-difference-constructors)
  (compute-difference-c-operators)
  (compute-difference-ac-operators)
  (compute-difference-status)
  (compute-difference-suffice)
  (compute-difference-equations)
  (compute-difference-precedence)
  (print-spec *diff-spec*)
  (print-spec *diff-asf-spec*)
  (print "done")
) ;** compute-difference **


(defun get-list-of-sorts (spec)
  ;** liefert die Liste der Sorten als Liste von Strings zurueck **
  (simplify-structure (get-spec spec 'sort))
) ;** get-list-of-sorts **


(defun compute-difference-sorts ()
  (let* ((asf-sorts (get-list-of-sorts *asf-spec*))
         (rrl-sorts (get-list-of-sorts *log-spec*))
         (asf-rrl (set-difference asf-sorts rrl-sorts :test 'equal))
         (rrl-asf (set-difference rrl-sorts asf-sorts :test 'equal))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'sort asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'sort rrl-asf)
  ) ;** let* **
) ;** compute-difference-sorts **


(defun compute-difference-functions ()
  (let* ((asf-functions (get-spec *asf-spec* 'function))
         (rrl-functions (get-spec *log-spec* 'function))
         (asf-rrl (assoc-difference asf-functions rrl-functions))
         (rrl-asf (assoc-difference rrl-functions asf-functions))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'function asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'function rrl-asf)
  ) ;** let* **
) ;** compute-difference-functions **


(defun get-list-of-options (spec)
  (simplify-structure (get-spec spec 'option))
) ;** get-list-of-options **


(defun compute-difference-options ()
  (let* ((asf-options (get-list-of-options *asf-spec*))
         (rrl-options (get-list-of-options *log-spec*))
         (asf-rrl (set-difference asf-options rrl-options :test 'equal))
         (rrl-asf (set-difference rrl-options asf-options :test 'equal))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'option asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'option rrl-asf)
  ) ;** let* **
) ;** compute-difference-options **


(defun compute-difference-constructors ()
  (let* ((asf-constructors (get-spec *asf-spec* 'constructor))
         (rrl-constructors (get-spec *log-spec* 'constructor))
         (asf-rrl (set-difference asf-constructors rrl-constructors :test 'equal))
         (rrl-asf (set-difference rrl-constructors asf-constructors :test 'equal))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'constructor asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'constructor rrl-asf)
  ) ;** let* **
) ;** compute-difference-constructors **


(defun get-list-of-c-operators (spec)
  (simplify-structure (get-spec spec 'c-operator))
) ;** get-list-of-c-operators **


(defun compute-difference-c-operators ()
  (let* ((asf-c-operators (get-list-of-c-operators *asf-spec*))
         (rrl-c-operators (get-list-of-c-operators *log-spec*))
         (asf-rrl (set-difference asf-c-operators rrl-c-operators :test 'equal))
         (rrl-asf (set-difference rrl-c-operators asf-c-operators :test 'equal))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'c-operator asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'c-operator rrl-asf)
  ) ;** let* **
) ;** compute-difference-c-operators **


(defun get-list-of-ac-operators (spec)
  (simplify-structure (get-spec spec 'ac-operator))
) ;** get-list-of-ac-operators **


(defun compute-difference-ac-operators ()
  (let* ((asf-ac-operators (get-list-of-ac-operators *asf-spec*))
         (rrl-ac-operators (get-list-of-ac-operators *log-spec*))
         (asf-rrl (set-difference asf-ac-operators rrl-ac-operators :test 'equal))
         (rrl-asf (set-difference rrl-ac-operators asf-ac-operators :test 'equal))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'ac-operator asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'ac-operator rrl-asf)
  ) ;** let* **
) ;** compute-difference-ac-operators **


(defun compute-difference-status ()
  (let* ((asf-status (get-spec *asf-spec* 'status))
         (rrl-status (get-spec *log-spec* 'status))
         (asf-rrl (set-difference asf-status rrl-status :test 'equal))
         (rrl-asf (set-difference rrl-status asf-status :test 'equal))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'status asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'status rrl-asf)
  ) ;** let* **
) ;** compute-difference-status **


(defun compute-difference-suffice ()
  (let* ((asf-suffice (get-spec *asf-spec* 'suffice))
         (rrl-suffice (get-spec *log-spec* 'suffice))
         (asf-rrl (assoc-difference asf-suffice rrl-suffice))
         (rrl-asf (assoc-difference rrl-suffice asf-suffice))
        )
        (when asf-rrl 
          (insert-spec *diff-asf-spec* 'suffice asf-rrl)
        ) ;** when **
        (insert-spec *diff-spec* 'suffice rrl-asf)
  ) ;** let* **
) ;** compute-difference-suffice **


(defun get-ok-theorems-and-add-equations (spec)
  (do ((theorems (get-spec spec 'prove) (cdr theorems))
       (equs (get-spec spec 'add-equation)
             (if (member "o" (caddr (cddar theorems)) :test 'equal)
                 (cons (car theorems) equs)
                 equs))
      )
      ((null theorems) equs)
  ) ;** do **                    
) ;** get-ok-theorems-and-equations **


(defun compute-difference-equations ()
  (let* ((asf-equations (append (get-ok-theorems-and-add-equations *asf-spec*)
                                (get-spec *asf-spec* 'spec-equation)))
         (rrl-equations (append (get-spec *log-spec* 'add-equation)
                                (get-spec *log-spec* 'spec-equation)))
         (asf-add-equations (get-ok-theorems-and-add-equations *asf-spec*))
         (rrl-add-equations (get-spec *log-spec* 'add-equation))
         (asf-spec-equations (get-spec *asf-spec* 'spec-equation))
         (rrl-spec-equations (get-spec *log-spec* 'spec-equation))
         (asf-rrl nil)
         (rrl-asf nil)
        )
       (setq asf-rrl (car (equ-diff rrl-add-equations asf-equations)))
       (insert-spec *diff-spec* 'add-equation asf-rrl)
       (setq asf-rrl (car (equ-diff rrl-spec-equations asf-equations))) 
       (insert-spec *diff-spec* 'spec-equation asf-rrl)
       (setq rrl-asf (car (equ-diff asf-add-equations rrl-equations)))
       (insert-spec *diff-asf-spec* 'add-equation rrl-asf)
       (setq rrl-asf (car (equ-diff asf-spec-equations rrl-equations)))
       (insert-spec *diff-asf-spec* 'spec-equation rrl-asf)
  ) ;** let* **
) ;** compute-difference-equations **


(defun compute-difference-precedence ()
  (let ((asf-prec (get-spec *asf-spec* 'precedence))
        (rrl-prec (get-spec *log-spec* 'precedence))
        (diff-prec nil)
       )
       (setq diff-prec (compare-precedence asf-prec rrl-prec))
       (when *test*
             (print "asf-prec rrl-prec diff-prec")
             (print asf-prec)
             (print rrl-prec)
             (print diff-prec)
       ) ;** when **       
       (when diff-prec
             (insert-spec *diff-spec* 'precedence diff-prec)
       ) ;** when **
  ) ;** let **
) ;** compute-difference-precedence **



;*************************************************************************


;**********************************************************************
;** function name :  show-proves                                     **
;** arguments     :  Liste von Theoremen                             **
;** effect        :  gibt Theoreme nach ihrem Beweisstand aus        **
;** return value  :                                                  **
;** edited        :  12.8.1991                                       **
;**********************************************************************
(defun show-proves (liste)
  (do ((l liste (cdr l))
       (equ nil) ; equational theorems
       (ind nil) ; inductive theorems
       (not nil) ; not proved theorems (the rest)
      )
      ((null l)
       (when (or equ ind not)
             (format t "~%Folgende Theoreme wurden als Gleichungstheoreme bewiesen:~%")
             (print-prove equ)
             (when equ (terpri))
             (format t "~%Folgende Theoreme wurden als induktive Theoreme bewiesen:~%")
             (print-prove ind)
             (when ind (terpri))
             (format t "~%Folgende Theoreme konnten nicht bewiesen werden:~%")
             (print-prove not)
             (format t "~%~% <RETURN>, bitte ...")
             (read-line)
             (terpri)
       )
      )
      (cond ((member "eq" (cadddr (cdar l)) :test 'equal)
             (push (car l) equ))
            ((member "in" (cadddr (cdar l)) :test 'equal)
             (push (car l) ind))
            ('TRUE
             (push (car l) not))
      )
  )
)

;**********************************************************************
;** function name :  selective-insert                                **
;** arguments     :  spec code liste (von Gleichungen)               **
;** effect        :  laesst den Benutzer die Gleichungen selektiv    **
;**                  einfuegen                                       **
;** return value  :                                                  **
;** edited        :  13.8.1991                                       **
;**********************************************************************
(defun selective-insert (spec code liste)
  (delete-spec spec code)
  (do ((equs liste (cdr equs))
      )
      ((null equs) 
      )
      (format t "Gleichung: ")
      (print-prove (list (car equs)))
      (format t "~%Uebernehmen ? ")
      (let ((antwort (read-line))
           )
           (if (and (> (length antwort) 0)
                    (or (char-equal #\y (char antwort 0))
                        (char-equal #\Y (char antwort 0))))
               (insert-spec spec code (list (car equs)))
           )
      )
  )
)

;**********************************************************************
;** function name :  add-or-kb                                       **
;** arguments     :  spec                                            **
;** effect        :  laesst den Benutzer zwischen add- und spec-     **
;**                  equations waehlen                               **
;** return value  :                                                  **
;** edited        :  12.8.1991                                       **
;**********************************************************************
(defun add-or-kb (spec)
  (format t "~%~%Es wurden Gleichungen ueber die ADD-Funktion von RRL eingegeben, und~%")
  (format t "RRL hat ein Gleichungssystem erzeugt. Voreingestellt ist die Uebernahme~%")
  (format t "der ADD-Gleichungen.~%")
  (format t "~%~%ADD-Gleichungen :~%")
  (print-equation (get-spec spec 'add-equation))
  (format t "~%~%~%RRL-Gleichungen :~%")
  (print-equation (get-spec spec 'spec-equation))
  (format t "~%~%Wollen Sie die RRL-Gleichungen uebernehmen ? ")
  (let ((antwort (read-line))
       )
       (if (and (> (length antwort) 0)
                (or (char-equal #\y (char antwort 0))
                    (char-equal #\Y (char antwort 0))))
           (progn
             (delete-spec spec 'add-equation)
             (format t "Wollen Sie selektiv uebernehmen ? ")
             (let ((antwort (read-line))
                  )
                  (if (and (> (length antwort) 0)
                           (or (char-equal #\y (char antwort 0))
                               (char-equal #\Y (char antwort 0))))
                      (selective-insert spec 'spec-equation 
                                        (get-spec spec 'spec-equation))
                  )
             )
           )
           (delete-spec spec 'spec-equation) 
       )
  )
)

;**********************************************************************
;** function name :  show                                            **
;** arguments     :  spec                                            **
;** effect        :  gibt spec auf dem Bildschirm aus                **
;** return value  :                                                  **
;** edited        :  19.6.1991                                       **
;**********************************************************************
(defun show (spec)
  (let ((data nil)
       )
       (setq data (get-spec spec 'sort))
       (when data
             (format t "~%~%Sorten : ")
             (print-sort data)
       )
       (setq data (get-spec spec 'function))
       (when data
             (format t "~%~%Funktionen : ")
             (print-function data)
       )
       (setq data (get-spec spec 'add-equation))
       (when data
             (format t "~%~%Add-Gleichungen : ")
             (print-equation data)
       )
       (setq data (get-spec spec 'spec-equation))
       (when data
             (format t "~%~%KB-Gleichungen : ")
             (print-equation data)
       )
       (setq data (get-spec spec 'option))
       (when data
             (format t "~%~%Optionen : ") 
             (print-option data)
       )
       (setq data (get-spec spec 'constructor))
       (when data
             (format t "~%~%Konstruktoren : ")
             (print-constructor data)
       ) 
       (setq data (get-spec spec 'ac-operator))
       (when data
             (format t "~%~%AC-Operatoren : ") 
             (print-ac-operator data)
       )
       (setq data (get-spec spec 'c-operator))
       (when data
             (format t "~%~%C-Operatoren : ") 
             (print-c-operator data)
       )
       (setq data (get-spec spec 'status))
       (when data
             (format t "~%~%Status : ")
             (print-status data)
       )
       (setq data (get-spec spec 'precedence))
       (when data
             (format t "~%~%Ordnung : ")
             (print-precedence data)
       )
       (setq data (get-spec spec 'prove))
       (when data
             (format t "~%~%Theoreme : ")
             (print-prove data)
       )
       (setq data (get-spec spec 'suffice))
       (when data
             (format t "~%~%Vollstaendigkeit : ") 
             (print-suffice data)
       )
  )
  (terpri) (terpri)
)

;**********************************************************************
;** Funktionen fuer Vergleich der ASF-precedence mit der             **
;** RRL-precedence                                                   **
;**********************************************************************

;**********************************************************************
;** function name : compare-precedence                               **
;** arguments     : ASF-prec RRL-prec                                **
;** effect        : Die ASF-precedence wird mit der RRL-precedence   **
;**   verglichen. Dabei stellt jede precedence fuer sich eine Menge  ** 
;**   M mit einer Partialordnung < dar. (M,<) wird als gerichteter   **
;**   Graph repraesentiert, intern als eine Liste von Tupeln (u,v),  **
;**   wobei (u,v) die Kante von u nach v  u->v beschreibt. Es wird   **
;**   vorausgesetzt, dass jeder der beiden gericheten Graphen G(asf) **
;**   bzw. G(rrl) azyklisch ist, d.h. G(asf) bzw. G(rrl) ist ein     **
;**   dag. Desweitern wird vorausgesetzt, dass G(asf) bzw. G(rrl)    **
;**   transitiv reduziert sind, d.h. es gibt keine Kante von u nach  **
;**   v u->v, falls es einen nicht-direkten Weg von u nach v u~~>v   **
;**   gibt. Es wird ueberprueft, ob G(asf) in G(rrl) enthalten       **
;**   ist, d.h. gibt es in G(asf) die Kante u->v, dann wird ueber-   **
;**   prueft, ob es in G(rrl) einen Weg u~~>v gibt. In G(delta)      **
;**   werden werden alle Unterschiede von G(asf) und G(rrl)          **
;**   gesammelt.                                                     **
;** return value  : G(delta) als Liste von Tupeln                    **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun compare-precedence (ASF-prec RRL-prec)
  (let ((G_asf ASF-prec)
        (G_rrl RRL-prec)
        (G_delta NIL)
        (S_delta NIL)
       )
       (unless (and (null ASF-prec) (null RRL-prec))
               (same-edges RRL-prec 
                           (compare-precedence-help G_asf G_rrl G_delta))
       ) ;** unless **
  ) ;** let **
) ;** compare-precedence **


;**********************************************************************
;** function name : compare-precedence-help                          **
;** arguments     : G_asf G_rrl G_delta                              **
;** effect        : berechnet den Unterschied zwischen G_asf         **
;**                 und G_rrl                                        **
;** return value  : G_delta                                          **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun compare-precedence-help (G_asf G_rrl G_delta)
  (if (null G_asf)
      ;** ist G_asf leer, dann fuege G_rrl in G_delta ein **
      (insert-graph G_rrl G_delta)
      ;** ansonsten bestimme ein Element 'element von G_asf         **
      ;** die direkte Nachfolgermenge 'S_asf von 'element in G_asf  **
      ;** die direkte Nachfolgermenge 'S_rrl von 'element in G_rrl  **
      (let* ((element (caar G_asf))
             (S_asf (successors G_asf element))
             (S_rrl (successors G_rrl element))
             (S_delta nil)
            )
            ;** in S_delta kommen uebereinstimmenden Kanten **
            ;** von S_asf und S_rrl hinein
            (setq S_delta (same-edges S_asf S_rrl))
            ;** diese koennen aus G_asf entfernt werden  **
            (setq G_asf (remove-edges G_asf S_delta))
            ;** alle Kanten u->x aus S_delta werden in G_rrl durch          **
            ;** die Kanten u->y ersetzt, wobei x->y in G_rrl enthalten ist. **
            (setq G_rrl (replace-through-successors G_rrl S_delta)) 
            ;** S_asf und S_rrl werden neu gesetzt **
            (setq S_asf (remove-edges S_asf S_delta))
            (setq S_rrl (successors G_rrl element))
            (cond ((null S_asf)
                   ;** alle Elemente von S_asf in G_rrl gefunden **
                   ;** fuege S_rrl in G_delta ein, loesche sie   **
                   ;** aus G_rrl und rufe wieder compare... auf  **
                   (setq G_delta (insert-graph S_rrl G_delta))
                   (setq G_rrl (remove-edges G_rrl S_rrl))
                   (compare-precedence-help G_asf G_rrl G_delta)
                  )
                  ((null S_rrl)
                   ;** S_asf ist nicht leer, diese Kanten sind in G_rrl
                   ;** nicht enthalten. Fehler !
                   (print "ASF precedence nicht in RRL precedence enthalten ! ")
                  )
                  ;** fuege S_rrl in G_delta ein und ersetze diese Kanten **
                  ;** wie oben durch Nachfolger (u->x --> u->y)           **
                  ;** rufe compare... auf                                 **
                  (t (setq G_delta (insert-graph S_rrl G_delta))
                     (setq G_rrl (replace-through-successors G_rrl S_rrl))
                     (compare-precedence-help G_asf G_rrl G_delta)
                  )
            ) ;** cond **
      ) ;** let* **
  ) ;** if **
) ;** compare-precedence-help **


;**********************************************************************
;** function name : successors                                       **
;** arguments     : Graph element                                    **
;** effect        : bestimmt die Menge der Nachfolger des Elements   **
;**                 in Graph                                         **
;** return value  : Nachfolgermenge                                  **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun successors (Graph element)
  (do ((G Graph (cdr G))
       (S NIL)
       (edge NIL)
       )
      ((null G) S)
      (setq edge (car G))
      (if (equal (car edge) element)
          (setq S (cons edge S))
      ) ;** if **
  ) ;** do **
) ;** successors **


;**********************************************************************
;** function name : same-edges                                       **
;** arguments     : list1-of-edges list2-of-edges                    **
;** effect        : bestimmt die Menge der gleichen Kanten           **
;** return value  : Menge                                            **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun same-edges (list1-of-edges list2-of-edges)
  (intersection list1-of-edges list2-of-edges :test 'equal)
) ;** same-edges **


;**********************************************************************
;** function name : remove-edges                                     **
;** arguments     : graph list-of-edges                              **
;** effect        : entfernt list-of-edges aus graph                 **
;** return value  : verkleinerter graph                              **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun remove-edges (graph list-of-edges)
  (set-difference graph list-of-edges :test 'equal)
) ;** remove-eges **


;**********************************************************************
;** function name : insert-graph                                     **
;** arguments     : list-of-edges graph                              **
;** effect        : fuegt list-of-edges in graph ein                 **
;** return value  :  erweiterter graph                               **
;** edited        :  14.06.1991                                      **
;**********************************************************************
(defun insert-graph (list-of-edges graph)
  (append list-of-edges graph)
) ;** insert-graph **


;**********************************************************************
;** function name : replace-through-successors                       **
;** arguments     : graph list-of-edges                              **
;** effect        : ersetzt jede Kante u->x in graph, welche in      **
;**                 list-of-edges enthalten ist durch die Kanten     **
;**                 u->y, wobei x->y in graph enthalten ist          **
;** return value  : veraenderter graph                               **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun replace-through-successors (graph list-of-edges)
  (do ((l list-of-edges (cdr l))
       (g (remove-edges graph list-of-edges))
       (element nil)
       (successor-list nil)
       (help nil)
      )
      ((null l) g)
      (setq element (car l))
      (setq successor-list (successors g (cadr element)))
      (setq successor-list 
            (make-new-successors successor-list (car element)))
      (setq help (remove-edges g successor-list))
      (setq g (insert-graph successor-list help))
  ) ;** do **
) ;** replace-through-successors **


;**********************************************************************
;** function name : make-new-successors                              **
;** arguments     : successor-list element                           **
;** effect        : macht aus jeder Kante u->x in successor-list die **
;**                 Kante element->x                                 **
;** return value  : neue successor-list                              **
;** edited        : 14.06.1991                                       **
;**********************************************************************
(defun make-new-successors (successor-list element)
  (do ((s-list successor-list (cdr s-list))
       (new-list nil)
       (edge nil)
      )
      ((null s-list) new-list)
      (setq edge (cons element (cdar s-list)))
      (setq new-list (cons edge new-list))
  ) ;** do **
) ;** make-new-successors ** 


;**********************************************************************
;**                         Hilfsfunktionen                          **
;**********************************************************************

;**********************************************************************
;** function name :  collect-length-2                                **
;** arguments     :  Liste                                           **
;** effect        :                                                  **
;** return value  :  Liste der Elemente, die laenger als eins sind.  **
;** remark        :  Kann nur auf Argumente vom Typ Sequenz angewend-**
;**                  et werden.                                      **
;** edited        :  14.6.1991                                       **
;**********************************************************************
(defmacro collect-length-2 (liste)
  `(do ((l ,liste (cdr l))
        (r nil (if (> (length (car l)) 1)
                   (cons (car l) r)
                   r
               ))
       )
       ((null l) r)
   )
)

;**********************************************************************
;** function name :  simplify-structure                              **
;** arguments     :  Liste                                           **
;** effect        :                                                  **
;** return value  :  Liste der Cars                                  **
;** edited        :  14.6.1991                                       **
;**********************************************************************
(defmacro simplify-structure (liste)
  `(mapcar #'car ,liste)
)

;**********************************************************************
;** function name :  complicate-structure                            **
;** arguments     :  Liste                                           **
;** effect        :                                                  **
;** return value  :  Liste von Listen deren erstes Car, das jeweilige**
;**                  Listenelement der uerspruenglichen Liste ist.   **
;** edited        :  14.6.1991                                       **
;**********************************************************************
(defmacro complicate-structure (liste)
  `(mapcar (function (lambda (x) (cons x nil))) ,liste)
)

;**********************************************************************
;** function name :  set-diff                                        **
;** arguments     :  Zwei Mengen                                     **
;** effect        :                                                  **
;** return value  :  Liste der Differenzen s1-s2 und s2-s1           **
;** edited        :  14.6.1991                                       **
;**********************************************************************
(defmacro set-diff (s1 s2)
  `(list (set-difference ,s1 ,s2 :test 'equal)
         (set-difference ,s2 ,s1 :test 'equal))
)

;**********************************************************************
;** function name :  assoc-diff                                      **
;** arguments     :  Zwei Assoziationslisten                         **
;** effect        :                                                  **
;** return value  :  Liste der Differenzen s1-s2 und s2-s1           **
;** edited        :  14.6.1991                                       **
;**********************************************************************
(defmacro assoc-diff (s1 s2)
  `(list (set-difference ,s1 ,s2 :test 'equal :key 'car)
         (set-difference ,s2 ,s1 :test 'equal :key 'car))
)


;**********************************************************************
;** function name :  assoc-difference                                **
;** arguments     :  Zwei Assoziationslisten                         **
;** return value  :  die Differenz s1-s2                             **
;** edited        :  22.08.1991                                      **
;**********************************************************************
(defmacro assoc-difference (s1 s2)
  `(set-difference ,s1 ,s2 :test 'equal :key 'car)
)

;**********************************************************************
;**                     Gleichungsfunktionen                         **
;**********************************************************************

;**********************************************************************
;** function name :  exchange-bool-op                                **
;** arguments     :  Term (Praedikat)                                **
;** effect        :  ersetzt boolesche Praedikate "equ", "or", "not" **
;**                  durch aequivalente xor-and-Darstellung          **
;** return value  :  umbenannter Term                                **
;** edited        :  10.7.1991                                       **
;**********************************************************************
(defun exchange-bool-op (term)
  (cond ((stringp term)
         term
        )
        ((equal (caar term) "equ")
         (cond ((equal (cadr term) "true")
                (caddr term)
               )
               ((equal (cadr term) "false")
                (list (cons "xor" "infix") (exchange-bool-op (caddr term)) "true")
               )
               ((equal (caddr term) "true")
                (cadr term)
               )
               ((equal (caddr term) "false")
                (list (cons "xor" "infix") (exchange-bool-op (cadr term)) "true")
               )
               ('TRUE
                (list (cons "xor" "infix") (exchange-bool-op (cadr term))
                                           (exchange-bool-op (caddr term))
                                           "true")
               )
         )
        )
        ((equal (caar term) "or")
         (let ((p (exchange-bool-op (cadr term)))
               (q (exchange-bool-op (caddr term)))
              )
              (list (cons "xor" "infix") p q (list (cons "and" "infix") p q))
         )
        )
        ((equal (caar term) "not")
         (list (cons "xor" "infix") (exchange-bool-op (cadr term)) "true")
        )
        ((equal (caar term) "and")
         (do ((l (cdr term) (cdr l))
              (r nil (cons (exchange-bool-op (car l)) r))
             )
             ((null l)
              (cons (car term) (nreverse r))
             )
         )
        )
        ((equal (caar term) "xor")
         (do ((l (cdr term) (cdr l))
              (r nil (cons (exchange-bool-op (car l)) r))
             )
             ((null l)
              (cons (car term) (nreverse r))
             )
         )
        )
        ('TRUE
         term
        )
  )
)

;**********************************************************************
;** function name :  reduce-duplicates                               **
;** arguments     :  Polynomdarstellung                              **
;** effect        :                                                  **
;** return value  :  normalisierte Polynomdarstellung                **
;** edited        :  10.7.1991                                       **
;**********************************************************************
(defun reduce-duplicates (term)
  (cond ((stringp term)
         term
        )
        ((equal (caar term) "and")
         ; (and p p) --> p
         ; (and p p ..) --> (and p ..)
         (do ((l (cdr term) (cdr l))
              (r nil (if (member (car l) (cdr l) :test 'equal)
                         r
                         (cons (car l) r)
                     ))
             )
             ((null l)
              (if (cdr r)
                  (cons (car term) (nreverse r))
                  (car r)
              )
             )
         )
        )
        ((equal (caar term) "xor")
         ; reduziere erst alle Argumente
         (do ((l (cdr term) (cdr l))
              (r nil (cons (reduce-duplicates (car l)) r))
             )
             ((null l)
              ; (xor p p) --> false
              ; (xor p p ..) -> (xor ..)
              (do ((k (nreverse r) (cdr k))
                   (s nil (if (member (car k) (cdr k) :test 'formel-equal)
                              (let ((entry (member (car k) (cdr k) 
                                                   :test 'formel-equal))
                                   )
                                ; entferne (nur) das zweite Exemplar aus der Liste
                                   (if (cdr entry)
                                       (progn
                                          (rplaca entry (cadr entry))
                                          (rplacd entry (cddr entry))
                                       )
                                       (rplacd (nthcdr (- (length k) 2) k) nil)
                                   )
                                   s
                              )
                              (cons (car k) s)
                          ))
                  )
                  ((null k)
                   (if (null s)
                       "false"
                       (if (cdr s)
                           (cons (car term) (nreverse s))
                           (car s)
                       )
                   )
                  )
              )
             )
         )
        )
        ('TRUE
         term
        )
  )
)

;**********************************************************************
;** function name :  normalize-conds                                 **
;** arguments     :  Bedingungsteile von Gleichungen                 **
;** effect        :                                                  **
;** return value  :  normalisierte Polynomdarstellung                **
;** edited        :  10.7.1991                                       **
;**********************************************************************
(defun normalize-conds (conds)
  ; fasse Bedingungsgleichungen zu einer Formel zusammen
  ; und ersetze boolesche Operatoren "or", "equ" und "not" (exchange-bool-op)
  (let ((f (exchange-bool-op
             (do ((l conds (cddr l))
                  (r nil (cond ((equal (car l) "true")
                                (cons (cadr l) r)
                               )
                               ((equal (car l) "false")
                                (cons (list (cons "not" "functor") (cadr l)) r)
                               )
                               ((equal (cadr l) "true")
                                (cons (car l) r)
                               )
                               ((equal (cadr l) "false")
                                (cons (list (cons "not" "functor") (car l)) r)
                               )
                               ('TRUE
                                (cons (list (cons "=" "infix") (car l) (cadr l)) r)
                               )
                         )
                  )
                 )
                 ((null l) 
                  ; alle Bedingungen werden durch "and" verknuepft (es sei denn
                  ; es gibt nur eine Bedingung)
                  (if (cdr r)
                      (cons (cons "and" "functor") r)
                      (car r)
                  )
                 )
             ) ;** do **
           )
        )
       ) ;** let-vars **
       ; bringe Term auf Polynomdarstellung
; Vorgehensweise: die Formel wird ausmultipliziert
;   Es wird die Argumentenliste "durchgecdrt" und fuer jedes Argument solange
; ausmultipliziert, bis dies nicht mehr geht. Es gibt fuenf moegliche Faelle:
; (andere Kombinationen koennen nicht auftreten)
       (unless (stringp f)
               (do ((l (cdr f) (if b (cdr l) l))
                    (b nil nil)   ; gibt an, ob Argument ausmultipliziert ist
                    (m nil (if b (cons (car l) m) m))
                                  ; weil beim ausmultiplizieren, alle Argumente
                                  ; benoetigt werden, werden bereits bearbeitete
                                  ; Argumente abgespeichert
                   )
                   ((null l) )
                   (cond ((stringp (car l))
                          (setq b 'TRUE)
                         )
; 1. Fall: (xor .. (xor a b) ..) --> (xor .. a b ..)
                         ((and (equal (caar f) "xor")
                               (equal (caaar l) "xor"))
                          (rplacd l (append (cddar l) (cdr l)))
                          (rplaca l (cadar l))
                         )
; 2. Fall: (and .. (and a b) ..) --> (and .. a b ..)
                         ((and (equal (caar f) "and")
                               (equal (caaar l) "and"))
                          (rplacd l (append (cddar l) (cdr l)))
                          (rplaca l (cadar l))
                         )
; 3. Fall: (and .x. (xor a b ..) .y.) --> (xor (and a .x. .y.) (and b .x. .y.) ..)
                         ((and (equal (caar f) "and")
                               (equal (caaar l) "xor"))
                          ; erzeuge Argumente fuer xor
                          (do ((k (cdar l) (cdr k))
                               (a (append (nreverse m) (cdr l)))
                               (r nil (cons (list* (cons "and" "functor")
                                                   (car k)
                                                   a
                                            ) 
                                            r))
                              )
                              ((null k)
                               (setq f (cons (cons "xor" "infix") (nreverse r)))
                               ; beginne aeussere Schleife von neuem
                               (setq l (cdr f))
                               (setq m nil)
                              )
                          )
                         )
; 4. Fall a: (xor (and .x. (and .z.) .y.)) --> (xor (and .x. .z. .y.))
; 4. Fall b: (xor (and .x. (xor a b ..) .y.)) --> (xor (and a .x. .y.)
;                                                      (and b .x. .y.) ..)
                         ((and (equal (caar f) "xor")
                               (equal (caaar l) "and"))
                          (do ((k (cdar l) (cdr k))
                               (c nil)
                               (n nil (cons (car k) n))
                              )
                              ((or c (null k))
                               (unless c
                                       (setq b 'TRUE)
                               )
                              )
                              (cond ((stringp (car k))
                                    )
                                    ((equal (caaar k) "and")
                                     (rplacd k (append (cddar k) (cdr k)))
                                     (rplaca k (cadar k))
                                     (setq c 'TRUE)
                                    )
                                    ((equal (caaar k) "xor")
                                     (do ((p (cdar k) (cdr p))
                                          (a (append (nreverse n) (cdr k)))
                                          (r nil (cons (list* (cons "and" "functor")
                                                              (car p)
                                                              a
                                                       )
                                                       r))
                                         )
                                         ((null p)
                                          (rplacd l (append (cdr r) (cdr l)))
                                          (rplaca l (car r))
                                         )
                                     )
                                     (setq c 'TRUE)
                                    )
                              )
                          )
                         )
                         ('TRUE
                          (setq b 'TRUE)
                         )
                   )
               )
               ; entferne gleiche Terme
               ; p*p = p
               ; p+p = null
               (setq f (reduce-duplicates f))
       )
  )
)

;**********************************************************************
;** function name :  formel-equal                                    **
;** arguments     :  Formeln (Praedikate) als xor-and-Polynome       **
;** effect        :                                                  **
;** return value  :  TRUE, gdw beide Praedikate dieselbe Darstellung **
;**                  haben                                           **
;** edited        :  10.7.1991                                       **
;**********************************************************************
(defun formel-equal (c1 c2)
  (cond (; Variable oder Konstante
         ; eigentlich duerfte das nur "true" oder "false" sein
         (stringp c1)
         (equal c1 c2)
        )
        ((stringp c2)
         (equal c1 c2)
        )
        ((equal (car c1) (car c2))
         ; haben beide die Funktion "xor" oder "and", so sind sie gleich, wenn
         ; sie bis auf Permutation auf oberster Ebene gleich sind         
         (cond ((equal (caar c1) "and")
                (and (null (set-difference (cdr c1) (cdr c2) :test 'equal))
                     (null (set-difference (cdr c2) (cdr c1) :test 'equal)))
               )
               ((equal (caar c1) "xor")
                (and (null (set-difference (cdr c1) (cdr c2) :test 'formel-equal))
                     (null (set-difference (cdr c2) (cdr c1) :test 'formel-equal)))
               )
               ('TRUE
                (equal c1 c2)
               )
         )
        )
        ('TRUE
         (equal c1 c2)
        )
  )
)

;**********************************************************************
;** function name :  equ-equal                                       **
;** arguments     :  Zwei Gleichungen                                **
;** effect        :  markiert die zweite Gleichung, falls beide      **
;**                  gleich sind                                     **
;** return value  :  TRUE, gdw beide Gleichungen gleich sind         **
;** edited        :  10.7.1991                                       **
;**********************************************************************
(defun equ-equal (e1 e2)
  ; sind die Terme gleich?
  (if (or (and (equal (nth 2 e1) (nth 4 e2))
               (equal (nth 2 e1) (nth 4 e2))
               ; sind die Terme ueber Kreuz gleich, duerfen beide
               ; keine Regeln sein (sie wuerden sich widersprechen)
               (not (and (equal (nth 3 e1) "-->")
                         (equal (nth 3 e2) "-->")))
          )
          (and (equal (nth 2 e1) (nth 2 e2))
               (equal (nth 4 e2) (nth 4 e1))
          )
      )
      (cond (; beide haben keine Bedingungen
             (and (null (nth 5 e1))
                  (null (nth 5 e2)))
             ; markiere in der zweiten Gleichung, dass es eine Gleichung gibt,
             ; die zu dieser gleich ist
             (rplaca e1 (list (equ-flags (nthcdr 2 e1))
                              (equ-flags (nthcdr 2 e2))))
             (rplaca e2 (list (equ-flags (nthcdr 2 e1))
                              (equ-flags (nthcdr 2 e2))))
             'TRUE
            )
            (; e1 hat keine Bedingungen (aber e2 wohl)
             (null (nth 5 e1))
             nil
            )
            (; e2 hat keine Bedingungen (aber e1 wohl)
             (null (nth 5 e2))
             nil
            )
            ('TRUE
             ; normalisiere Bedingungen
             (if (null (cadr e1))
                 (rplaca (cdr e1) (normalize-conds (nth 5 e1)))
             )
             (if (null (cadr e2))
                 (rplaca (cdr e2) (normalize-conds (nth 5 e2)))
             )
             (if (formel-equal (cadr e1) (cadr e2))
                 (progn
                    ; die Flags beider Gleichungen werden fuer 
                    ; equ-diff-prove benoetigt
                    (rplaca e1 (list (equ-flags (nthcdr 2 e1))
                                     (equ-flags (nthcdr 2 e2))))
                    (rplaca e2 (list (equ-flags (nthcdr 2 e1))
                                     (equ-flags (nthcdr 2 e2))))
                    'TRUE
                 )
                 nil
             )
            )
      )
      nil
  )
)

;**********************************************************************
;** function name :  equ-diff                                        **
;** arguments     :  Zwei Gleichungslisten                           **
;** effect        :                                                  **
;** return value  :  Liste der Differenzen s1-s2 und s2-s1           **
;** edited        :  10.7.1991                                       **
;**********************************************************************
(defun equ-diff (s1 s2)
  ; alle Gleichungen werden um zwei Listenelemente erweitert:
  ; 1. LE: gibt an, ob bereits ein erfolgreicher Vergleich stattgefunden hat (nur fuer l2 wichtig)
  ; 2. LE: enthaelt die normalisierten Bedingungen
  (let* ((f (function (lambda (x) (list* nil nil x))))
         (l1 (mapcar f s1))
         (l2 (mapcar f s2))
         (d1 nil)
         (d2 nil)
         (d3 nil) ; welche in beiden drin sind
        )
        (do ((l l1 (cdr l))
            )
            ((null l) )
            (do ((k l2 (cdr k))
                 (b nil (or b (equ-equal (car l) (car k))))
                )
                ((null k)
                 (if b
                     (push (cddar l) d3)
                     (push (cddar l) d1)
                 )
                )
            )
        )
        (do ((l l2 (cdr l))
            )
            ((null l)
            )
            (unless (caar l)
                    (push (cddar l) d2)
            )
        )
        (list d1 d2 d3)
  )
)

;**********************************************************************
;** function name :  equ-diff-prove                                  **
;** arguments     :  Zwei Gleichungslisten (Theoreme)                **
;** effect        :                                                  **
;** return value  :  Liste der Differenzen s1-s2 und s2-s1           **
;** edited        :  13.8.1991                                       **
;**********************************************************************
(defun equ-diff-prove (s1 s2)
  ; alle Gleichungen werden um zwei Listenelemente erweitert:
  ; 1. LE: gibt an, ob bereits ein erfolgreicher Vergleich stattgefunden hat (nur fuer l2 wichtig)
  ; 2. LE: enthaelt die normalisierten Bedingungen
  (let* ((f (function (lambda (x) (list* nil nil x))))
         (l1 (mapcar f s1))
         (l2 (mapcar f s2))
         (d1 nil)
         (d2 nil)
         (d3 nil) ; welche in beiden drin sind
        )
        (do ((l l1 (cdr l))
            )
            ((null l) )
            (do ((k l2 (cdr k))
                 (b nil (or (equ-equal (car l) (car k)) b))
                )
                ((null k)
                 (unless b
                         (push (cddar l) d1)
                 )
                )
            )
        )
        (do ((l l2 (cdr l))
            )
            ((null l)
            )
            (if (caar l)
                ; in d3 werden nur die aufgenommen, wo k ein Flag "o", 
                ; l aber keins gesetzt hat
                (if (and (not (member "o" (caaar l) :test 'equal))
                         (member "o" (cadaar l) :test 'equal))
                    (push (cddar l) d3)
                )
                (push (cddar l) d2)
            )
        )
        (list d1 d2 d3)
  )
)

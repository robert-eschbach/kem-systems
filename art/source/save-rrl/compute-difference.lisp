; *********************************************************************
; ** filename : compute-difference.lisp                              **
; *********************************************************************  
; ** Diese Datei berechnet die Differenz zwischen der ASF-Spezi-     **
; ** fikation und der RRL-Ausgabe.                                   **
; *********************************************************************

(in-package "SAVE-RRL")


;**********************************************************************
;** function name : compute-difference                               **
;** arguments     : --                                               **
;** effect        : berechnet die Differenzen *asf-spec*-*log-spec*  **
;**                 und *log-spec*-*asf-spec*                        ** 
;** return value  : die globalen Variablen *diff-spec* und           **
;**                 *diff-asf-spec* werden geaendert                 **
;** edited        : 23.08.1991                                       **
;**********************************************************************
(defun compute-difference ()
  (trace-output 4 "compute difference : sorts~%")
  (compute-difference-sorts)
  (trace-output 4 "                     functions~%")
  (compute-difference-functions)
  (trace-output 4 "                     options~%")
  (compute-difference-options)
  (trace-output 4 "                     contructors~%")
  (compute-difference-constructors)
  (trace-output 4 "                     c-operators~%")
  (compute-difference-c-operators)
  (trace-output 4 "                     ac-operators~%")
  (compute-difference-ac-operators)
  (trace-output 4 "                     status~%")
  (compute-difference-status)
  (trace-output 4 "                     sufficient complete~%")
  (compute-difference-suffice)
  (trace-output 4 "                     equations~%")
  (compute-difference-equations)
  (trace-output 4 "                     theorems~%")
  (compute-difference-theorems)
  (trace-output 4 "                     precedence~%")
  (compute-difference-precedence)
) ;** compute-difference **


;**********************************************************************
;** function name : get-list-of-sorts                                **
;** arguments     : spec                                             **
;** return value  : liefert die Liste der Sorten als Liste von       **
;**                 Strings zurueck                                  **
;** edited        : 23.08.1991                                       **
;**********************************************************************
(defun get-list-of-sorts (spec)
  ;; Eschbach Tue Aug  2 21:41:53 MET DST 1994
  ;; Sorten alle klein
  (mapcar #'(lambda(x) (string-downcase (car x))) (get-spec spec 'sort)))

;**********************************************************************
;** function name : compute-difference-sorts                         **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der Sorten               **
;** edited        : 23.08.91                                         **
;**********************************************************************
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


;**********************************************************************
;** function name : compute-difference-functions                     **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der Funktionen           **
;** edited        : 23.08.91                                         **
;**********************************************************************
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


;**********************************************************************
;** function name : get-list-of-options                              **
;** arguments     : spec                                             **
;** effect        : liefert die Liste der Optionen als Liste von     **
;**                 Strings zurueck                                  **
;** edited        : 23.08.91                                         **
;**********************************************************************
(defun get-list-of-options (spec)
  (mapcar #'car  (get-spec spec 'option))
) ;** get-list-of-options **


;**********************************************************************
;** function name : compute-difference-options                       **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der Optionen             **
;** edited        : 23.08.91                                         **
;**********************************************************************
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


;**********************************************************************
;** function name : compute-difference-constructors                  **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der Konstruktoren        **
;** edited        : 23.08.91                                         **
;**********************************************************************
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


;**********************************************************************
;** function name : get-list-of-c-operators                          **
;** arguments     : spec                                             **
;** effect        : liefert die Liste der C-Operatoren als Liste von **
;**                 Strings zurueck                                  **
;** edited        : 23.08.91                                         **
;**********************************************************************
(defun get-list-of-c-operators (spec)
  (simplify-structure (get-spec spec 'c-operator))
) ;** get-list-of-c-operators **


;**********************************************************************
;** function name : compute-difference-c-operators                   **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der C-Operatoren         **
;** edited        : 23.08.91                                         **
;**********************************************************************
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


;**********************************************************************
;** function name : get-list-of-ac-operators                         **
;** arguments     : spec                                             **
;** effect        : liefert die Liste der AC-Operatoren als Liste von**
;**                 Strings zurueck                                  **
;** edited        : 23.08.91                                         **
;** changed       : 05.06.92                                         **
;**********************************************************************
(defun get-list-of-ac-operators (spec)
  (mapcar #'car (get-spec spec 'ac-operator)))

;**********************************************************************
;** function name : compute-difference-ac-operators                  **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der AC-Operatoren        **
;** edited        : 23.08.91                                         **
;**********************************************************************
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

;**********************************************************************
;** function name : compute-difference-status                        **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz des Status               **
;** edited        : 23.08.91                                         **
;**********************************************************************
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



;**********************************************************************
;** function name : compute-difference-suffice                       **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz von suffice              **
;** edited        : 23.08.91                                         **
;********************************************************************** (load "parser-to-intern")
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


;**********************************************************************
;** function name : get-ok-theorems-and-add-equations                **
;** arguments     : spec                                             **
;** effect        : liefert alle Theoreme mit Flag "o" bzw. "h"      **
;**                 und alle add-equation der spec zurueck           **
;** edited        : 23.08.91                                         **
;** changed       : 16.08.92                                         **
;**********************************************************************
(defun get-ok-theorems-and-add-equations (spec)
  (do ((theorems (get-spec spec 'prove) (cdr theorems))
       (equs (get-spec spec 'add-equation)
             (if (or (member "o" (caddr (cddar theorems)) :test 'equal)
		     (member "h" (caddr (cddar theorems)) :test 'equal))
                 (cons (first theorems) equs)
                 equs))
      )
      ((null theorems) equs)
  ) ;** do **                    
) ;** get-ok-theorems-and-equations **


;**********************************************************************
;** function name : compute-difference-equations                     **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der equations            **
;** edited        : 23.08.91                                         **
;**********************************************************************
;** <-- hier
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


;**********************************************************************
;** function name : compute-difference-precedence                    **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der precedence           **
;** edited        : 23.08.91                                         **
;**********************************************************************
(defun compute-difference-precedence ()
  (let* ((asf-prec (get-spec *asf-spec* 'precedence))
         (rrl-prec (get-spec *log-spec* 'precedence))
         (diff-prec (compare-precedence asf-prec rrl-prec))
        )
        (when diff-prec
              (insert-spec *diff-spec* 'precedence diff-prec)
        ) ;** when **
  ) ;** let* **
) ;** compute-difference-precedence **


;**********************************************************************
;** function name : compute-difference-theorems                      **
;** arguments     : --                                               **
;** effect        : berechnet die Differenz der Theoreme             **
;** edited        : 23.08.91                                         **
;**********************************************************************
(defun compute-difference-theorems ()
  (let* ((asf-theorems (get-spec *asf-spec* 'prove))
         (rrl-theorems (get-spec *log-spec* 'prove))
         (diff (equ-diff-prove asf-theorems rrl-theorems))
         (asf-rrl (first diff))
         (rrl-asf (third diff)) ;** bewiesene Beweisaufgaben !
	 )
    (setq *proved-additional-theorems* (second diff))
    (when asf-rrl
          (insert-spec *diff-asf-spec* 'prove asf-rrl)
	  )				;** when **
    (insert-spec *diff-spec* 'prove rrl-asf)
    )					;** let* **
  )					;** compute-difference-theorems **

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
             (format t "~%equational theorems :~%")
             (print-prove equ)
             (when equ (terpri))
             (format t "~%inductive theorems :~%")
             (print-prove ind)
             (when ind (terpri))
             (format t "~%not proved theorems :~%")
             (print-prove not)
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
      (print-prove (list (car equs)))
      (format t "~% (y/n) ? ")
      (let ((antwort (read-line))
           )
           (if (and (> (length antwort) 0)
                    (or (char-equal #\y (char antwort 0))
                        (char-equal #\Y (char antwort 0))))
               (insert-spec spec code (list (car equs)))
           ) ;** if **
      ) ;** let **
  ) ;** do **
) ;** selective-insert **



;**********************************************************************
;** function name :  add-or-kb                                       **
;** arguments     :  spec                                            **
;** effect        :  laesst den Benutzer zwischen add- und spec-     **
;**                  equations waehlen                               **
;** return value  :                                                  **
;** edited        :  12.8.1991                                       **
;**********************************************************************
(defun add-or-kb (spec)
  (when (or (get-spec spec 'add-equation)
	    (get-spec spec 'spec-equation))
  (show-add-or-kb-menu spec))
) ;** add-or-kb **

(defun show-add-or-kb-menu (spec)
  (format t "~%")
  (format t "****************************************~%")
  (format t "* Auswahl der Gleichungen              *~%")
  (format t "****************************************~%")
  (format t "* (0) help                             *~%")
  (format t "* (1) show add-equations               *~%")
  (format t "* (2) show spec-equations              *~%")
  (format t "* (3) select add-equations             *~%")
  (format t "* (4) select spec-equations            *~%")
  (format t "****************************************~%")
  (format t "~%")
  (format t "type any symbol : ")
  (let ((antwort (read-line))
	)
	(cond ((equal antwort "1") (show-add-or-kb 1 spec))
	      ((equal antwort "2") (show-add-or-kb 2 spec))
	      ((equal antwort "3") (show-add-or-kb 3 spec))
	      ((equal antwort "4") (show-add-or-kb 4 spec))
	      (t (show-add-or-kb 0 spec))
	      )
       )
  )

(defun show-add-or-kb (auswahl spec)
  (cond ((equal auswahl 0)
	 (format t "~%")
	 (format t "********~%")
	 (format t "* help *~%")
	 (format t "********~%")
	 (format t "~%")
	 (format t "Mit dem Befehl add sind in RRL Gleichungen eingegeben worden.~%")
	 (format t "Diese muessen aber nicht mit den Gleichungen aus dem spec-file ~%")
	 (format t "uebereinstimmen (Vervollstaendigung !). ~%")
	 (format t "Durch die Vervollstaendigung koennen vom Benutzer eingegebene ~%")
	 (format t "Gleichungen entfernt worden, und neue Gleichungen hinzugekommen sein.~%")
	 (format t "Hier muss entschieden werden, welche Gleichungen uebernommen ~%")
	 (format t "werden. Mit (3) werden die durch den Befehl add eingebenen ~%")
	 (format t "Gleichungen, mit (4) die im spec-file vorgefundenen Gleichungen ~%")
	 (format t "uebernommen~%")
	 (format t "Bei (4) wird eine selektive Uebernahme der Gleichungen angeboten.~%")
	 (show-add-or-kb-menu spec)
	 )
	((equal auswahl 1)
	 (format t "~%")
	 (format t "**********************~%")
	 (format t "* show add-equations *~%")
	 (format t "**********************~%")
	 (format t "~%")
         (print-equation (get-spec spec 'add-equation))
	 (format t "~%")
	 (show-add-or-kb-menu spec)
	 )
	((equal auswahl 2)
	 (format t "~%")
	 (format t "***********************~%")
	 (format t "* show spec-equations *~%")
	 (format t "***********************~%")
	 (format t "~%")
         (print-equation (get-spec spec 'spec-equation))
	 (format t "~%")
	 (show-add-or-kb-menu spec)
	 )
        ((equal auswahl 3)
	 (format t "~%")
	 (format t "************************~%")
	 (format t "* select add-equations *~%")
	 (format t "************************~%")
	 (format t "~%")
         (delete-spec spec 'spec-equation) 
	 (format t "done ~%")
	 )
	((equal auswahl 4)
	 (format t "~%")
	 (format t "*************************~%")
	 (format t "* select spec-equations *~%")
	 (format t "*************************~%")
	 (format t "~%")
         (progn
           (delete-spec spec 'add-equation)
	   (format t "selective (y/n) ? : ")
	   (let ((answer (read-line))
		 )
		(if (or (equal answer "y") (equal answer "Y"))
	          (selective-insert spec 'spec-equation (get-spec spec 'spec-equation))
		  )
		)
	 ))
	(t nil)
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
             (format t "~%~%sorts : ")
             (print-sort data)
       )
       (setq data (get-spec spec 'function))
       (when data
             (format t "~%~%funktions : ")
             (print-function data)
       )
       (setq data (get-spec spec 'add-equation))
       (when data
             (format t "~%~%add-equation : ")
             (print-equation data)
       )
       (setq data (get-spec spec 'spec-equation))
       (when data
             (format t "~%~%spec-equation : ")
             (print-equation data)
       )
       (setq data (get-spec spec 'option))
       (when data
             (format t "~%~%options : ") 
             (print-option data)
       )
       (setq data (get-spec spec 'constructor))
       (when data
             (format t "~%~%constructors : ")
             (print-constructor data)
       ) 
       (setq data (get-spec spec 'ac-operator))
       (when data
             (format t "~%~%ac-operators : ") 
             (print-ac-operator data)
       )
       (setq data (get-spec spec 'c-operator))
       (when data
             (format t "~%~%c-operators : ") 
             (print-c-operator data)
       )
       (setq data (get-spec spec 'status))
       (when data
             (format t "~%~%status : ")
             (print-status data)
       )
       (setq data (get-spec spec 'precedence))
       (when data
             (format t "~%~%precedence : ")
             (print-precedence data)
       )
       (setq data (get-spec spec 'prove))
       (when data
             (format t "~%~%theorems : ")
             (print-prove data)
       )
       (setq data (get-spec spec 'suffice))
       (when data
             (format t "~%~%sufficient complete : ") 
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
(defun  simplify-structure (liste)
  (mapcar #'car liste)
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
(defun assoc-difference (s1 s2)
  (set-difference s1 s2 :test 'equal :key 'car))


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
            (do ((k l2 (cdr k)) ;** equ-equal veraendert (car l) 
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
	    (trace-output 20 "check ASF-theorem ~A ~%" (car l))
            (do ((k l2 (cdr k))
                 (b nil (or b (equ-equal (car l) (car k))))
		 )
                ((null k) (unless b (push (cddar l) d1)))
		(when (equ-equal (car l) (car k))
		      (trace-output 20 "  found RRL-theorem ~A ~%" (car k)))
		)
	    )
        (do ((l l2 (cdr l))
	     )
            ((null l))
            (if (caar l) ;** falls schon verglichen 
		(trace-output 20 "theorem (RRL and ASF) : ~A ~%" (car l)))
	    (if (caar l) ;** falls schon verglichen 
					; in d3 werden nur die aufgenommen, 
					; wo k ein Flag "o", 
					; l aber keins gesetzt hat
					; d.h : in ASF Beweisaufgabe , in 
					; RRL Theorem  
					; 1.Fall : exportierte Beweisaufgabe
					; dann haenge Flag e an 
					; 2. Fall : Beweisaufgabe , 
					; dann kein Flag anhaengen
                (if (and (not (member "o" (caaar l) :test 'equal))
                         (member "o" (cadaar l) :test 'equal))
		    (if (null (caaar l)) ; kein Flag 
			(push (cddar l) d3)
		      (progn 
			(push (caaaar l)  (seventh (car l)))
			(push (cddar l) d3))
		      ))
		  (push (cddar l) d2)
		  )
	    )
        (list d1 d2 d3)
  )
)


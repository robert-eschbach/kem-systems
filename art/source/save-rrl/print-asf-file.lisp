(IN-PACKAGE "SAVE-RRL")

;******************************************************************************
;**    Funktionen zum Umbenennen der Variablen
;******************************************************************************

;**********************************************************************
;** function name :  get-allowed-variables                           **
;** arguments     :  spec und spec-name                              **
;** effect        :  Es werden nur die Variablen weitergegeben, die  **
;**                  unter spec-name deklariert wurden!              **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun get-allowed-variables (spec spec-name)
  (do ((vars (get-spec spec 'variable) (cdr vars))
       (new-vars nil (if (string= spec-name (var-spec (first vars)))
; (string= spec-name (var-spec (first vars)) :end1 (length (var-spec (first vars))))
                         (cons (car vars) new-vars)
                         new-vars))
      )
      ((null vars) new-vars)
      (trace-output 20 "variable : ~A ~%" (first vars))
      (trace-output 20 "new-vars : ~A ~%" new-vars)))
      
  

;**********************************************************************
;** function name :  get-forbidden-variable-names                    **
;** arguments     :  spec, spec-name und umbenennungsliste           **
;** effect        :  Es werden alle Variablennamen gelistet, die     **
;**                  nicht fuer neue Namen benutzt werden duerfen.   **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun get-forbidden-variable-names (spec spec-name um-liste)
  (do ((vars (get-spec spec 'variable) (cdr vars))
       (names nil (when (string= spec-name (var-spec (first vars)))
					; der Originalname darf nicht benutzt werden, 
					; weil es sonst in der spec zu Konflikten kommt
			(let ((entry (find-var (var-name (car vars)) um-liste))
			      )
			  (if entry
			      (cons (cdr entry) names)
					; names
			    (cons (var-name (car vars)) names))))))
					; dieser Name darf nicht benutzt werden, weil er sonst
					; spaeter umbenannt wird
					;   (cons (var-name (car vars)) names)
      ((null vars) names)))


;**********************************************************************
;** function name :  find-variables                                  **
;** arguments     :  spec, Funktionsdefinitionen, Variablendefinit., **
;**                  und verbotene Namen                             **
;** effect        :  Da nicht alle vorkommenden Funktionen in        **
;**                  der spec deklariert sind, wird eine (vollst.)   **
;**                  Funktionenliste mitgegeben.                     **
;**                  Es werden alle Variablen gesammelt, die nicht   **
;**                  in der aktuellen Spezifikation deklariert       **
;**                  wurden. Sie werden so umgenannt, dass keine     **
;**                  Kollisionen mit anderen Variablen (verbotene    **
;**                  Namen) entstehen.                               **
;** return value  :                                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun find-variables (spec functions allowed-variables forbidden-names)
  ; !!!! Achtung !!!!
  ; Die Termstruktur wird destruktiv veraendert, um die Gleichungen nicht
  ; loeschen und neu einfuegen zu muessen.
  ; Sollte dies auf einmal nicht funktionieren, muessen die Gleichungen (bei 
  ; Veraenderung) in der spec geloescht und (richtig!) eingetragen werden !!!

  (do* ((equ-list (append (get-spec spec 'add-equation)
                          (get-spec spec 'spec-equation)
                          (get-spec spec 'prove))
                  (cdr equ-list))
        (new-variables nil)		; neu erzeugte Variablen
        (all-variables allowed-variables)  ; alle (auch entstehende) Variablen
        (trans-variables nil nil)       ; Uebersetzungstabelle fuer die Variablen einer Gleichung
      )
      ((null equ-list)
       ; fuege neue Variablen in die spec ein
       (insert-spec spec 'variable new-variables)
      )

      ; nehme alle Terme einer Gleichung und erstelle Variablenliste
      ; erstelle konsistente Uebersetzungstabelle fuer die Variablen
      (do ((vars (select-variables functions (car equ-list)) (cdr vars))
          )
          ((null vars) )

          (let ((entry (find-var (var-name (car vars)) all-variables))
               )
;** change : "(cond (( .... (string= ... (var-sorte vars)..." **
;** 27.11.91 Eschbach **

               (cond ((or (and entry (not (string= (string-downcase (var-sorte entry))
                                                    (string-downcase (var-sorte (car vars))))))
                          (and (not entry) 
                               (member (var-name (car vars)) forbidden-names
                                       :test 'equal))
                      )
                      ; nenne Variable um, weil sonst ein Konflikt entsteht
                      (let ((new-name (rename-var (var-name (car vars))
                                                  (var-sorte (car vars))
                                                  all-variables forbidden-names))
                           )
                           (push (list new-name (var-sorte (car vars)))
                                 new-variables)
                           (push (list new-name (var-sorte (car vars)))
                                 all-variables)
                           (push (cons (var-name (car vars)) new-name)
                                 trans-variables)
                      ) ;** let **
                     ) ;** cond 1 **

                     ((not entry)
                      (push (car vars) new-variables)
                      (push (car vars) all-variables)
                     ) ;** cond 2 **

               ) ;** cond **

          ) ;** let **

      ) ;** do **

      ; aendere die Variablen in den Termen (destruktiv)
      (when trans-variables
	    (trace-output 20 "rename variables in equation ~A ~%" (car equ-list))
	    (trace-output 20 "variables for renaming : ~A ~%" trans-variables)
            (rename-equation (car equ-list) trans-variables)
	    (trace-output 20 "renamed equation : ~A ~%" (car equ-list))
      )
  )
)

;**********************************************************************
;** function name :  select-variables                                **
;** arguments     :  Funktionsdefinitionen und Gleichung             **
;** effect        :                                                  **
;** return value  :  Liste aller in den Termen vorkommenden Variablen**
;** edited        :  28.6.1991                                       **
;**********************************************************************
(defun select-variables (functions equation)
					;  die (faelschlich eingefuegten) Variablen 
					; "true" und "false" werden
					;  entfernt
  (do ((l (select-term-variables functions (equ-t1 equation) (equ-t2 equation))
	  (cdr l))
       (result nil (if (or (string= "false" (var-name (car l)))
			   (string= "true" (var-name (car l)))
			   (find-var (var-name (car l)) result))
		       result
		     (cons (car l) result)))
       )
      ((null l) result)
      )
  )

;**********************************************************************
;** function name :  select-term-variables                           **
;** arguments     :  Funktionsdeklarationen und zwei Terme           **
;** effect        :                                                  **
;** return value  :  Liste aller in den Termen vorkommenden Variablen**
;** '( (var-name sort) ... )                                         **
;** edited        :  28.6.1991                                       **
;** changed       : 12.05.92 Eschbach                                **
;**   das RRL built-in = muss beachtet werden                        **
;** remark        : diese Funktion arbeitet noch nicht korrekt !!!   **
;**   Eschbach 12.05.92                                              **
;**********************************************************************
(defun select-term-variables (functions t1 t2)
  ; Es wird vorausgesetzt, dass eine Variable in einer Gleichung nur eine
  ; Sorte haben kann. Deshalb werden die Variablensorten in einer Assoziations-
  ; liste gesammelt.
  ; Tritt eine Gleichung der Form "Variable == Variable" auf, so sind werden
  ; diese Variable an anderer Stelle verwendet (wo ihre Sorte implizit definiert
  ; wird). Daher wird dieser Fall ausgelassen.
  ; Wegen dem Fall "term == variable" muessen beide Terme simultan verarbeitet
  ; werden.
  (cond ((and (stringp t1) (stringp t2))
         (let ((value1 (find-function t1 functions))
               (value2 (find-function t2 functions))
              )
              ; nur wenn genau ein Term eine konstante Funktion ist,
              ; kann der Typ der anderen Variable bestimmt werden.
              (when (or (and value1 (not value2))
                        (and (not value1) value2)) 
                    (cond ((null value1)
                           ; Term1 ist eine Variable
                           ; assoziiere mit Variable die Ergebnissorte von Term2
                           (list (cons t1 (fdef-ausgabe-sorten value2)))
                          )
                          ((null value2)
                           ; Term2 ist eine Variable
                           ; assoziiere mit Variable die Ergebnissorte von Term1
                           (list (cons t2 (fdef-ausgabe-sorten value1)))
                          )
                    )
              )
         )
        )
        ((or (and (not (stringp t1)) (stringp t2))
             (and (stringp t1) (not (stringp t2))))
         (let* ((variable (if (stringp t1) t1 t2))
                (function (if (stringp t1) t2 t1))
					;** RRL built-in = ist nicht in der Signatur ! **
					;** 12.05.92 Eschbach **
                (value (if (equal (term-function function) '("=" . "infix"))
			   '("=" ("univ" "univ") ("bool") "infix")
			 (find-function (term-function function) functions)))
	        )	
					; ein Term ist eine Variable, der andere 
					; eine Funktionsanwendung
	   (if (find-function variable functions)
					; falls variable eine Konstante ist,
					; ermittle Variablen aus function 
					;(Funktionsanwendung !)
	       (select-variables-term-help functions function)
	     (cons (cons variable (fdef-ausgabe-sorten value))
		   (select-variables-term-help functions function))
	     )
	   )
	 )
        ('TRUE
         (append (select-variables-term-help functions t1)
                 (select-variables-term-help functions t2))
        )
  )
)

;**********************************************************************
;** function name :  select-term-variables-help                      **
;** arguments     :  Funktionsdeklaration und ein Term               **
;** effect        :                                                  **
;** return value  :  Liste aller in dem Term vorkommenden Variablen  **
;** edited        :  28.6.1991                                       **
;** changed       :  12.05.92 Eschbach                               **
;**   das RRL built-in = muss beachtet werden                        **
;**********************************************************************
(defun select-variables-term-help (functions term)
					; term ist eine Funktionsanwendung
  (do ((subterme (term-args term) (cdr subterme))
;** Eschbach 13.05.92
       (sorten   (if (equal (term-function term) "=")
		     (compute-input-sorts-for-RRL-equality term functions)
		     (fdef-eingabe-sorten (find-function (term-function term) functions)))
                 (cdr sorten))
       (liste nil (if (stringp (car subterme))
                      (let ((value (find-function (car subterme) functions))
			    )
			(if value ; d.h.: (car subterme) ist Konstante !
			    liste
					; falls nicht schon vorhanden 
			      (adjoin (list (car subterme) (car sorten)) liste :test 'equal)
			  )
			)
		    (union (select-variables-term-help functions (car subterme))
			    liste :test 'equal)
		    ))
       )
      ((null subterme) liste)
      ) ;** do **
  )


;**********************************************************************
;** function      :  compute-input-sorts-for-RRL-equality            **
;** arguments     :                                                  **
;** effect        :                                                  **
;** return value  :  Eingabe-Sorten                                  **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun compute-input-sorts-for-RRL-equality (term functions)
  (let* ((arguments (term-args term))
	 (left-term   (car arguments))
	 (right-term  (cadr arguments))
	 )
    (trace-output 20 " term : ~A ~%" term)
    (cond ((not (stringp left-term))
					; linke Seite ist Funktionsanwendung
					; f t1 ... tn  = t
	   (if (equal (term-function left-term) "=") ; d.h. = : bool # bool -> bool
	       '("bool" "bool")
					; ansonsten ist f in functions enthalten 
	     (append (fdef-ausgabe-sorten (find-function (term-function left-term) functions))
		     (fdef-ausgabe-sorten (find-function (term-function left-term) functions))
		     )
		     
	     )				;** if **
	   )
	  ((not (stringp right-term))
					; rechte Seite ist Funktionsanwendung
					; f t1 ... tn  = t
	   (if (equal (term-function right-term) "=") ; d.h. = : bool # bool -> bool
	       '("bool" "bool")
					; ansonsten ist f in functions enthalten 
	     (append (fdef-ausgabe-sorten (find-function (term-function right-term) functions))
		     (fdef-ausgabe-sorten (find-function (term-function right-term) functions))
		     )
	     )				;** if **
	   )
					; ab hier kann folgendes eintreten : 
					; c = c' oder x = c oder c = x oder x = y 
	  ((find-function left-term  functions)
					; falls  c = ?
	   (append (fdef-ausgabe-sorten (find-function left-term functions))
		   (fdef-ausgabe-sorten (find-function left-term functions))
		   )
	   )
	  ((find-function right-term functions)
					; falls ? = c
	   (append (fdef-ausgabe-sorten (find-function right-term functions))
		   (fdef-ausgabe-sorten (find-function right-term functions))
		   )
	   )
					; hier ist jetzt x = y
	  (t (trace-output 20 "Der Term ~A hat die Gestalt Variable = Variable ~%" term )
	     (trace-output 20 "gegebenenfalls Substitution !~%")
	     )
	  )				;** cond **
    )					;** let* **
  )


(defmacro unique-name (name sorte vars forbids)
  ; TRUE iff name is unique or there exists a variable with the same sort
  `(and (let ((entry (assoc ,name ,vars :test 'equal))
             )
             (if (null entry)
                 'TRUE
                 (if (string= (cadr entry) ,sorte)
                     'TRUE
                     nil
                 )
             )
        )
        (not (member ,name ,forbids :test 'equal))
   )
)

;**********************************************************************
;** function      :  rename-var                                      **
;** arguments     :  Variable, Sorte, Variablenliste und verbotene   **
;**                  Namen                                           **
;** effect        :                                                  **
;** return value  :  neuer Name fuer die Sorte                       **
;** edited        :  8.8.1991                                        **
;**********************************************************************
(defun rename-var (var sorte variables forbidden-names)
  ; versuche erst die Sorte als Suffix anzufuegen
;(format t "renaming var ~A with sort ~A variables ~A~%" var sorte variables )
  (do ((new-name (concatenate 'string var 
                                      (string (char (string-downcase sorte) 0)))
                 (concatenate 'string new-name 
                                      (string (char (string-downcase sorte) i)))
       )
       (i 1 (+ i 1))
       (unique? nil nil)
      )
      ((or (= i (length sorte))     ; Sorte ist vollstaendig angefuegt
           (setq unique? (unique-name new-name sorte variables forbidden-names)))
       (if unique?
           new-name
           ; kein Erfolg, fuege weiter einsen an
           (do ((new-name2 (concatenate 'string new-name "1")
                           (concatenate 'string new-name2 "1"))
               )
               ((unique-name new-name sorte variables forbidden-names)
                new-name2
               )
           )
       )
      )
  )
)

;**********************************************************************
;** function      :  rename-equation                                 **
;** arguments     :  Gleichung und Uebersetzungsliste                **
;** effect        :  veraendert destruktiv die Gleichung             **
;** return value  :                                                  **
;** edited        :  28.6.1991                                       **
;**********************************************************************
(defun rename-equation (equation trans-list)
					;** da destruktiv geaendert wird, 
					;** koennen die Terme nicht direkt 
					;** uebergeben werden !!!
  (rename-term equation trans-list)	;** left term 
  (rename-term (cddr equation) trans-list) ;** right term 
  (cond ((fourth equation)		;** if conditionals 
	 (maplist #'(lambda(term)
		      (rename-term term trans-list))
		  (fourth equation))))
  )

;**********************************************************************
;** function      :  rename-term                                     **
;** arguments     :  Term und Uebersetzungstabelle                   **
;** effect        :  veraendert destruktiv den Term                  **
;** return value  :                                                  **
;** edited        :  28.6.1991                                       **
;**********************************************************************
(defun rename-term (term trans-list)
  (cond ((stringp (car term)) ; falls Konstante oder Variable 
         (let ((entry (assoc (car term) trans-list :test 'equal))
              )
              (when entry
                    (rplaca term (cdr entry))
              )
         )
        )
        ('TRUE
         (rename-term-help (car term) trans-list))
  )
)

;**********************************************************************
;** function      :  rename-term-help                                **
;** arguments     :  Term und Uebersetzungstabelle                   **
;** effect        :  veraendert destruktiv den Term                  **
;** return value  :                                                  **
;** edited        :  28.6.1991                                       **
;**********************************************************************
(defun rename-term-help (term trans-list)
  (do ((subterme (cdr term) (cdr subterme))
      )
      ((null subterme) )
      (if (stringp (car subterme))
          (let ((entry (assoc (car subterme) trans-list :test 'equal))
               )
               (when entry
                     (rplaca subterme (cdr entry))
               )
          )
          (rename-term-help (car subterme) trans-list)
      )
  )
)

;******************************************************************************
;**    Funktionen zum Umbenennen der spec
;******************************************************************************

;**********************************************************************
;** function      :  benenne-term-um                                 **
;** arguments     :  Umbenennungstabelle und Term                    **
;** effect        :  veraendert destruktiv den Term                  **
;** return value  :                                                  **
;** edited        :  24.7.1991                                       **
;**********************************************************************
(defun benenne-term-um (umbenennung term)
  (cond ((stringp (car term))
         (let ((entry (assoc (car term) umbenennung :test 'equal))
              )
              (if entry
                  (rplaca term (cdr entry))
              )
         )
        )
        ((consp (car term))
         (let ((entry (assoc (term-function (car term)) umbenennung :test 'equal))
              )
              (if entry 
                  (rplaca (caar term) (cdr entry))
              )
              (do ((t1 (cdar term) (cdr t1))
                  )
                  ((null t1)
                  )
                  (if (stringp (car t1))
                      (let ((entry (assoc (car t1) umbenennung :test 'equal))
                           )
                           (if entry
                               (rplaca t1 (cdr entry))
                           )
                      )
                      (benenne-term-um umbenennung t1)
                  )
              )
         )
        )
  )
)

;**********************************************************************
;** function      :  benenne-um                                      **
;** arguments     :  Umbenennungstabelle und Spezifikation           **
;** effect        :  veraendert destruktiv die Spec                  **
;** return value  :                                                  **
;** edited        :  24.7.1991                                       **
;**********************************************************************
(defun benenne-um (spec umbenennung)
  ; diese Funktion ist destruktiv, sollte dies nicht funktionieren,
  ; muessen alle Objekte geloescht und umbenannt neu eingefuegt werden!
  ; nenne Funktionsdeklarationen um
  (trace-output 2 "rename difference~%")
  (let ((liste (get-spec spec 'function))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (fdef-name (car l)) umbenennung :test 'equal))
                )
                (if entry
                    (fdef-set-name (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne Variablen um
  (let ((liste (get-spec spec 'variable))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (var-name (car l)) umbenennung :test 'equal))
                )
                (if entry
                    (var-set-name (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne Konstruktoren um
  (let ((liste (get-spec spec 'constructor))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (caar l) umbenennung :test 'equal))
                )
                (if entry
                    (rplaca (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne AC-Operator um
  (let ((liste (get-spec spec 'ac-operator))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (caar l) umbenennung :test 'equal))
                )
                (if entry
                    (rplaca (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne C-Operator um
  (let ((liste (get-spec spec 'c-operator))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (caar l) umbenennung :test 'equal))
                )
                (if entry
                    (rplaca (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne Status um
  (let ((liste (get-spec spec 'status))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (caar l) umbenennung :test 'equal))
                )
                (if entry
                    (rplaca (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne Ordnung um
  (let ((liste (get-spec spec 'precedence))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (do ((p (car l) (cdr p))
               )
               ((null p)
               )
               (let ((entry (assoc (car p) umbenennung :test 'equal))
                    )
                    (if entry
                        (rplaca p (cdr entry))
                    )
               )
           )
       )
  )
  ; nenne Suffice um
  (let ((liste (get-spec spec 'suffice))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           (let ((entry (assoc (caar l) umbenennung :test 'equal))
                )
                (if entry
                    (rplaca (car l) (cdr entry))
                )
           )
       )
  )
  ; nenne Gleichungen um
  (let ((liste (get-spec spec 'add-equation))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           ; aendere Gleichung destruktiv
           (benenne-term-um umbenennung (car l))
           (benenne-term-um umbenennung (cddar l))
           (do ((p (equ-conds (car l)) (cdr p))
               )
               ((null p)
               )
               (benenne-term-um umbenennung p)
           )
       )
  )
  ; nenne Gleichungen um
  (let ((liste (get-spec spec 'spec-equation))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           ; aendere Gleichung destruktiv
           (benenne-term-um umbenennung (car l))
           (benenne-term-um umbenennung (cddar l))
           (do ((p (equ-conds (car l)) (cdr p))
               )
               ((null p)
               )
               (benenne-term-um umbenennung p)
           )
       )
  )
  ; nenne Gleichungen um
  (let ((liste (get-spec spec 'prove))
       )
       (do ((l liste (cdr l))
           )
           ((null l)
           )
           ; aendere Gleichung destruktiv
           (benenne-term-um umbenennung (car l))
           (benenne-term-um umbenennung (cddar l))
           (do ((p (equ-conds (car l)) (cdr p))
               )
               ((null p)
               )
               (benenne-term-um umbenennung p)
           )
       )
  )
)


;******************************************************************************
;**    Funktionen zum Ausdrucken einer Spezifikation in ein ASF-File
;******************************************************************************

;**********************************************************************
;** function      :  print-sorts                                     **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt die Sorten in ASF-Notation auf dem Stream  **
;**                  aus                                             **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-sorts (spec stream)
  (let ((liste (get-spec spec 'sort)))
    (when liste
	  (format stream "~%  sorts ")
	  (do ((l liste (cdr l))
	       (i 0 (+ i 1)))
	      ((null (cdr l))
	       ;; Eschbach Tue Aug  2 22:19:53 MET DST 1994
	       ;; sorts-names only in uppercase lettters
	       (if l (format stream "~A~%" (string-upcase (caar l)))))
	      (cond ((= i 4)
		     (format stream "~A,~%        " (string-upcase (caar l)))
		     (setq i 0))
		    (t (format stream "~A, " (string-upcase (caar l)))))))))

;**********************************************************************
;** function      :  print-functions                                 **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt die Funktionsdefinitionen in ASF-Notation  **
;**                  auf dem Stream aus                              **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-functions (spec stream)
  (let ((liste (get-spec spec 'function))
        (sufficient (get-spec spec 'suffice))
       )
       (when liste
             (format stream "~%  functions~%")
             (do ((l liste (cdr l))
                 )
                 ((null l) )
                 (let ((fcode (cadddr (car l)))
                      )
                      (cond ((string= fcode "infix")
                             (format stream "    _ ~A _ : " (caar l)))
                            ((string= fcode "prefix")
                             (format stream "    _ ~A : " (caar l)))
                            ('TRUE
                             (format stream "    ~A : " (caar l)))                                      )
                 )
                 (do ((k (cadar l) (cdr k))
                     )
		     ;; Eschbach Tue Aug  2 22:19:53 MET DST 1994
		     ;; sort-names only in uppercase letters
                     ((null (cdr k))
                      (if k (format stream "~A " (string-upcase (car k)))))
                     (format stream "~A # " (string-upcase (car k)))
                 )
                 (format stream "-> ")
                 (do ((k (caddar l) (cdr k))
                     )
                     ((null (cdr k))
                      (if k (format stream "~A~%" (string-upcase (car k)))))
                     (format stream "~A # " (string-upcase (car k)))
                 )
            )
            (do ((l sufficient (cdr l))
                )
                ((null l) )
                (if (string= (cadar l) "sufficient")
                    (format stream "    % Funktion ~A ist sufficient complete.~%" (caar l))
                    (format stream "    % Funktion ~A ist nicht sufficient complete.~%" (caar l))
                )
            )
       )
  )
)

;**********************************************************************
;** function      :  print-variables                                 **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt die Variablendefinitionen in ASF-Notation  **
;**                  auf dem Stream aus                              **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-variables (spec stream)
  (let ((liste (get-spec spec 'variable))
       )
       (when liste
             (format stream "~%  variables~%")
             (do ((l liste (cdr l))
                 )
                 ((null l) )
		 ;; Eschbach Tue Aug  2 22:19:53 MET DST 1994
		 ;; sort-names only in uppercase letters
		 (format stream "    ~A : -> ~A~%" (caar l) (string-upcase (cadar l)))
             )
       )
  )
)

;**********************************************************************
;** function      :  print-term-help                                 **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt einen Term in ASF-Notation auf dem Stream  **
;**                  aus                                             **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-term-help (stream term)
  (if (stringp term)
      (format stream "~A" term)
      (cond ((member (caar term) '("and" "or" "xor" "equ") :test 'equal)
             (format stream "~A(" (caar term))
             (do ((l (cdr term) (cdr l))
                 )
                 ((null (cdr l))
                  (print-term-help stream (car l))
                 )
                 (print-term-help stream (car l))
                 (format stream ", ")
             )
             (format stream ")")
            )
            ((equal (cdar term) "prefix")
             (format stream "(~A " (caar term))
             (print-term-help stream (cadr term))
             (format stream ")")
            )
            ((equal (cdar term) "infix")
             (format stream "(" (caar term))
             (print-term-help stream (cadr term))
             (format stream " ~A " (caar term))
             (print-term-help stream (caddr term))
             (format stream ")")
            )
            ('TRUE
             (format stream "~A(" (caar term))
             (do ((l (cdr term) (cdr l))
                 )
                 ((null (cdr l))
                  (print-term-help stream (car l))
                 )
                 (print-term-help stream (car l))
                 (format stream ", ")
             )
             (format stream ")")
            )             
      )
  )
)

;**********************************************************************
;** function      :  print-equation-help                             **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt eine Gleichung in ASF-Notation auf dem     **
;**                  Stream aus                                      **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-equation-help (stream equ)
  (print-term-help stream (car equ))
  (format stream " ~A " (cadr equ))
  (print-term-help stream (caddr equ))
  (when (cadddr equ)
        (format stream " when ")
	(do ((conds (cadddr equ) (cddr conds))
	     )
	    ((null conds) nil)
	    (print-term-help stream (car conds))
	    (format stream " == ")
	    (print-term-help stream (cadr conds))
	    (when (> (length conds) 2)
		(format stream " , ")))))


;**********************************************************************
;** function      :  print-equations                                 **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt die Gleichungen in ASF-Notation auf dem    **
;**                  Stream aus                                      **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-equations (spec stream)
  (let ((liste (append (get-spec spec 'add-equation)
                       (get-spec spec 'spec-equation)))
       )
       (when liste
             (format stream "~%  equations")
             (do ((l liste (cdr l))
                 )
                 ((null l)
                  (format stream "~%")
                 )
                 (format stream "~%    ")
                 (print-equation-help stream (car l))
                 (format stream " ;")
             )
       )
  )
)

;**********************************************************************
;** function      :  print-properties                                **
;** arguments     :  spec und stream                                 **
;** effect        :  gibt die Properties in ASF-Notation auf dem     **
;**                  Stream aus                                      **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-properties (spec stream)
  (let ((con (get-spec spec 'constructor))
        (aco (get-spec spec 'ac-operator))
        (co  (get-spec spec 'c-operator))
        (ord (get-spec spec 'option))
        (pre (get-spec spec 'precedence))
        (sta (get-spec spec 'status))
        (pro (get-spec spec 'prove))
       )
       (when (or con aco co ord pre sta pro)
             (format stream "~%  properties~%")
             (format stream "  begin")
             ; constructors
             (when con
                   (format stream "~%    constructors ")
                   (do ((l con (cdr l))
                        (i 0 (+ i 1))
                       )
                       ((null l)
;                        (format stream "~%")
                       )
                       (format stream "~A" (caar l))
                       (if (cadar l)
                           (format stream " : f")
                       )     
                       (if (= i 4)
                           (if (cdr l)        
                               (format stream "~%                 ")
                               (setq i 0)
                           )
                           (format stream "  ")
                       )
                    )
             )
             ; ac-operators
             (when aco
                   (format stream "~%    ac-operators ")
                   (do ((l aco (cdr l))
                        (i 0 (+ i 1))
                       )
                       ((null l) )
                       (if (and (cdr l) (= i 4))
                           (progn
                                  (format stream "~A~%                 " (caar l))
                                  (setq i 0)
                           )
                           (format stream "~A " (caar l))
                       )
                   )
             )
             ; c-operators
             (when co
                   (format stream "~%    c-operators ")
                   (do ((l co (cdr l))
                        (i 0 (+ i 1))
                       )
                       ((null l) )
                       (if (and (cdr l) (= i 4))
                           (progn
                                  (format stream "~A~%                " (caar l))
                                  (setq i 0)
                           )
                           (format stream "~A " (caar l))
                       )
                   )
             )
             ; precedence
             (when (or ord pre sta)
                   (format stream "~%    ordering ")
                   (do ((l ord (cdr l))
                       )
                       ((null l) )
                       (format stream "~A " (caar l))
                   )
                   (when pre
                         (format stream "~%      precedence ")
                         (do ((l pre (cdr l))
                              (i 0 (+ i 1))
                             )
                             ((null (cdr l))
                              (format stream "~A ~A" (caar l) (cadar l))
                             )
                             (format stream "~A ~A, " (caar l) (cadar l))
                             (when (= i 4) 
                                   (format stream "~%                 ")
                                   (setq i 0)
                             )
                         )
                   )
                   (when sta
                         (format stream "~%      status ")
                         (do ((l sta (cdr l))
                              (i 0 (+ i 1))
                             )
                             ((null l) )
                             (format stream "~A : ~A   " (caar l) (cadar l))
                             (when (and (cdr l) (= i 4))             
                                   (format stream "~%             ")
                                   (setq i 0)
                             )
                         )
                   )
             )
             ; proves
             (when pro
                   (format stream "~%    theorems")
                   (do ((l (reverse pro) (cdr l))
                       )
                       ((null l) )
                       (format stream "~%      ")
                       (print-equation-help stream (reverse (cdr (reverse (car l)))))
                       (let ((flags (car (last (car l))))
                            )
                            (when flags
                                  (format stream " [ ")
                                  (do ((k (do ((f flags (cdr f))
                                               (r nil (if (member (car f) '("e" "o" "h") :test 'equal)
                                                          (cons (car f) r)
                                                          r
                                                      ))
                                              )
                                              ((null f) r)
                                          )
                                          (cdr k))
                                      )
                                      ((null (cdr k))
                                       (format stream "~A ]" (car k))
                                      )
                                      (format stream "~A, " (car k))
                                  )
                            )
                       )
                       (format stream " ;")
                   )
                   (format stream "~%")
             )
             (format stream "~%  end~%")
       )
  )
)

;**********************************************************************
;** function      :  print-asf-file                                  **
;** arguments     :  spec und pfadname                               **
;** effect        :  schreibt die spec in ein file                   **
;** return value  :                                                  **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun print-asf-file (spec spec-name)
  (let ((filename (create-directory spec-name))
	)
    (when filename
	  (trace-output 1 "write new asf-file : ~A~%" filename)
	  (with-open-file (stream filename :direction :output)
			  (format stream "specification ~A~%" (pathname-name spec-name))
			  (format stream "begin~%")
			  (print-sorts spec stream)
			  (print-functions spec stream)
			  (print-variables spec stream)
			  (print-equations spec stream)
			  (print-properties spec stream)
			  (format stream "end~%")
			  )
	  )
    filename
    )
  )					;** print-asf-file **

;**********************************************************************
;** function      :  create-directory                                **
;** arguments     :  pfadname mit Spezifikationsuffix, zu druckende  **
;**                  spec                                            **
;** effect        :  erzeugt ein Unterdirectory und gibt den neuen   **
;**                  Dateinamen zurueck                              **
;** return value  :                                                  **
;** edited        :  3.7.1991                                        **
;**********************************************************************
(defun create-directory (spec-name)
  (let* ((directory-prefix (directory-namestring spec-name))
         (last-directory (car (nreverse (cdr (pathname-directory spec-name)))))
         (specification (pathname-name spec-name))
         (impl 0)
         (prop 0)
         (new-directory (cond ((search "prop_" last-directory)
                               (setq impl (read-from-string (subseq last-directory (+ (search "impl_" last-directory) 5))))
                               (setq prop (read-from-string (subseq last-directory (+ (search "prop_" last-directory) 5))))
                               (format nil "~A~D"
                                 (subseq last-directory 0 (+ (search "prop_" last-directory) 5))
                                 prop
                               )
                              )
                              ((search "impl_" last-directory)
                               (setq impl (read-from-string (subseq last-directory (+ (search "impl_" last-directory) 5))))
                               (concatenate 'string last-directory ".prop_1")
                              )
                              ('TRUE
                               ; suche naechste freie impl-Nummer
                               (do ((dl (directory directory-prefix) (cdr dl))
                                    (spec_impl (concatenate 'string specification ".impl_"))
                                    (l '(0) (let ((name (file-namestring (car dl)))
                                                )
                                                (if (search spec_impl name)
                                                    (cons (read-from-string (subseq name (+ (search "impl_" name) 5)))
                                                          l
                                                    )
                                                    l
                                                )
                                           )
                                    )
                                   )
                                   ((null dl) 
                                    ; waehle naechst hoehere impl-Nummer
                                    (format nil "~A.impl_~D"
                                            specification
                                            (+ (apply #'max l) 1)
                                    )
                                   )
                               )
                              )
                        ))
         (directory (concatenate 'string directory-prefix new-directory))
         (break nil)
        )
        (unless (= 0
		   ;; Eschbach Sun Feb  2 19:05:47 MET 1997
		   #+:cmu ('unix:unix-mkdir directory)
		   #+:lucid (system::shell (concatenate 'string "mkdir " directory))
		   )
                (format t "~%~% WARNING: directory already exist : ~A~%" directory)
                (format t "Overwrite ? ")
                (if (string= (string-upcase (read-line)) "N")
                    (setq break 'TRUE)
                )
        )
        (unless break
                (concatenate 'string directory "/" new-directory ".asf")
        )
  )
)

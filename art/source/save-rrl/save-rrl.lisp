; *********************************************************************
; ** filename : save-rrl.lisp                                        **
; *********************************************************************  
; **                        Hauptprogramm                            **
; *********************************************************************
(in-package "SAVE-RRL")

;**********************************************************************
;** function name : trace-output                                     **
;** arguments     :                                                  **
;** effect        :                                                  **
;** return value  :                                                  **
;** edited        :  13.05.1992                                      **
;**********************************************************************
(defun trace-output (level str &rest args)
  (if (<= level *trace-level*)
      (format *output-stream* str (car args))))

;**********************************************************************
;** function name :  save-rrl                                        **
;** arguments     :  Hauptprogramm                                   **
;** effect        :                                                  **
;** return value  :                                                  **
;** edited        :  20.6.1991                                       **
;**********************************************************************
(defun save-rrl (spec-path)
  ;** create filenames **
  (let* ((path (cond ((pathnamep spec-path) 
                      spec-path)
                     ((stringp spec-path)
                      (nth 3 (modid2specident spec-path)))
                     (t (nth 3 spec-path))))
         (asf-file spec-path)
         (dir (directory-namestring path))
         (file (file-namestring path))
         (spec-name (subseq file 0 (- (length file) 4)))
	 (module-name (first (modid2specident spec-path))) ; funktioniert nur, wenn spec-path ein String ist !
         (out-path (concatenate 'string dir spec-name))
         (log-file (concatenate 'string out-path ".cmd"))
         (spec-file (concatenate 'string out-path ".spec"))
         (umbenennungsliste nil)
        )
        (initialize)
       ;** parse files **
       ;** erst die Spec-Datei lesen, da der log-parser diese Information **
       ;** benoetigt **
       (format t "parsing spec-file : ~A ~%" spec-file)
       (spec-parser (load-spec spec-file))
       (format t "parsing log-file  : ~A ~%" log-file)
       (log-parser (load-log log-file))
       (setq umbenennungsliste (renaming (parse asf-file)))
       (asf-parser (car umbenennungsliste))
       (setq umbenennungsliste (cdr umbenennungsliste))
       ;** mache *log-spec* und *asf-spec* konsistent **
       (make-consistent *log-spec* *asf-spec*)

       ;** ermittle Unterschiede : ASF-RRL und RRL-ASF **
       ;** ASF-RRL in *diff-spec* **
       ;** RRL-ASF in *diff-asf-spec* **
       (compute-difference)

       ;** gebe dem Benutzer die Unterschiede heraus
       (show-differences-menu)
       ;** add-equations oder spec-equations ? **
       (add-or-kb *diff-spec*)
       ;** zeige Benutzer den Ausgang der Proves **
       (select-theorems *diff-spec*)

       ;**  mache *diff-spec* konsistent **
       ;** uebernehme alle Variablen aus der ASF-Spezifikation **
       (trace-output 2 "check variables in difference ~%")
       (find-variables *diff-spec* (get-spec *log-spec* 'function)
                                   (get-allowed-variables *asf-spec* module-name)
                                   (get-forbidden-variable-names 
				    *asf-spec* module-name umbenennungsliste
                                   ))
       ;** fuehre Umbenennung durch **
       (trace-output 2 "renaming difference ~%")
       (benenne-um *diff-spec* umbenennungsliste)
       ;** print *diff-spec* **
       (print-asf-file *diff-spec* out-path)
  ) ;** let* **
) ;** save-rrl **	

(defun select-theorems (spec)
  (when *proved-additional-theorems*
	(show-theorems-menu spec)))

(defun show-theorems-menu (spec)
  (format t "~%")
  (format t "********************************~%")
  (format t "* Auswahl der Theoreme         *~%")
  (format t "********************************~%")
  (format t "* (0) help                     *~%")
  (format t "* (1) show theorems            *~%")
  (format t "* (2) select all theorems      *~%")
  (format t "* (3) select theorems          *~%")
  (format t "********************************~%")
  (format t "~%")
  (format t "type any symbol : ")
  (let ((antwort (read-line))
        )
       (cond ((equal antwort "1") (show-theorems 1 spec))
	     ((equal antwort "2") (show-theorems 2 spec))
	     ((equal antwort "3") (show-theorems 3 spec))
	     (t (show-theorems 0 spec))
	     )
       )
  )

(defun show-theorems (antwort spec)
  (cond ((equal antwort 0)
         (format t "~%")
	 (format t "********~%")
	 (format t "* help *~%")
	 (format t "********~%")
	 (format t "~%")
	 (format t "Die bewiesenen Theoreme, welche nicht (!) in der ASF-Spezifikation ~%")
	 (format t "als Beweisaufgaben enthalten waren, koennen ausgegeben werden. ~%")
	 (format t "Mit (2) werden alle Theoreme uebernommen, und mit (3) hat man ~%")
         (format t "die Moeglichkeit selektiv die Theoreme zu uebernehmen.~%")
	 (format t "~%")
	 (show-theorems-menu spec)
	 )
	((equal antwort 1)
         (format t "~%")
         (format t "*****************~%")
         (format t "* show theorems *~%")
         (format t "*****************~%")
	 (show-proves *proved-additional-theorems*)
         (format t "~%")
	 (show-theorems-menu spec)
	 )
	((equal antwort 2)
         (format t "~%")
         (format t "***********************~%")
         (format t "* select all theorems *~%")
         (format t "***********************~%")
         (format t "~%")
	 (insert-spec *diff-spec* 'prove *proved-additional-theorems*)
         )
	((equal antwort 3)
         (format t "~%")
         (format t "*******************~%")
         (format t "* select theorems *~%")
         (format t "*******************~%")
	 (let ((proves *proved-additional-theorems*)
	       )
	       (selective-insert *diff-spec* 'prove proves)
	       )
         (format t "~%")
	 )
	(t nil))
  )

(defun show-differences-menu ()
  (format t "~%")
  (format t "****************************************~%")
  (format t "* Ausgabe der ermittelten Unterschiede *~%")
  (format t "****************************************~%")
  (format t "* (0) help                             *~%")
  (format t "* (1) RRL - ASF                        *~%")
  (format t "* (2) ASF - RRL                        *~%")
  (format t "* (3) ASF                              *~%")
  (format t "* (4) RRL                              *~%")
  (format t "* (5) theorems                         *~%")
  (format t "* (6) continue                         *~%")
  (format t "****************************************~%")
  (format t "~%")
  (format t "type any symbol : ")
  (let ((antwort (read-line))
       )
       (cond ((equal antwort "1") (show-differences 1))
	     ((equal antwort "2") (show-differences 2))
             ((equal antwort "3") (show-differences 3))
             ((equal antwort "4") (show-differences 4))
             ((equal antwort "5") (show-differences 5))
             ((equal antwort "6") (show-differences 6))
             (t (show-differences 0))
       ) ;** cond **
  ) ;** let **
) ;** show-differences-menu **


(defun show-differences (auswahl)
  (cond ((equal auswahl 0)
         (format t "~%")
         (format t "********~%")
	 (format t "* help *~%")
         (format t "********~%")
	 (format t "~%")
	 (format t "Die ermittelten Unterschiede koennen ausgegeben ~%")
	 (format t "werden ! ~%")
	 (format t " (1) liefert alle Informationen, welche in den ~%")
	 (format t "     RRL-files aber nicht in der ASF-Spezifikation ~%")
	 (format t "     gefunden wurden ~%")
	 (format t "     (also hinzugekommene Informationen) ~%")
	 (format t " (2) liefert alle Informationen, welche in der ASF- ~%")
	 (format t "     Spezifikation aber nicht in den RRL-Files ~%")
	 (format t "     gefunden wurden ~%")
	 (format t " (3) liefert alle Informationen aus der ASF-Spezifikation~%")
	 (format t " (4) liefert alle Informationen aus den RRL-Files      ~%")
	 (format t " (5) zeigt die in RRL bewiesenen Theoreme ~%")
         (format t "~%")
         (show-differences-menu)
        ) ;** cond 0 **

	((equal auswahl 1)
	 (format t "~%")
         (format t "*************~%")
         (format t "* RRL - ASF *~%")
         (format t "*************~%")
	 (print-spec *diff-spec*)
	 (show-proves (get-spec *log-spec* 'prove))
         (format t "~%")
         (show-differences-menu)
        ) ;** cond 1 **

        ((equal auswahl 2)
	 (format t "~%")
         (format t "*************~%")
         (format t "* ASF - RRL *~%")
         (format t "*************~%")
	 (print-spec *diff-asf-spec*)
         (format t "~%")
         (show-differences-menu)
        ) ;** cond 2 **
        ((equal auswahl 3)
	 (format t "~%")
         (format t "*************~%")
         (format t "* ASF       *~%")
         (format t "*************~%")
	 (print-spec *asf-spec*)
         (format t "~%")
         (show-differences-menu)
        ) 
        ((equal auswahl 4)
	 (format t "~%")
         (format t "*************~%")
         (format t "* RRL       *~%")
         (format t "*************~%")
	 (print-spec *log-spec*)
         (format t "~%")
         (show-differences-menu)
        )
        ((equal auswahl 5)
	 (format t "~%")
         (format t "*************~%")
         (format t "* theorems  *~%")
         (format t "*************~%")
	 (show-proves (get-spec *log-spec* 'prove))
         (format t "~%")
         (show-differences-menu)
        ) 
        (t nil)
  ) ;** cond **
) ;** show-differences **


;**********************************************************************
;** Konsistenz-Funktionen                                            **
;**********************************************************************

;**********************************************************************
;** function name :  enter-all-sorts                                 **
;** arguments     :  spec                                            **
;** effect        :  fuegt alle in den Funktionsdefinitionen vor-    **
;**                  kommenden Sorten ein                            **
;** return value  :                                                  **
;** edited        :  13.6.1991                                       **
;**********************************************************************
(defun enter-all-sorts (spec)
  (do ((f-list (get-spec spec 'function) (cdr f-list))
      )
      ((null f-list) )
      (insert-spec spec 'sort (fdef-eingabe-sorten (car f-list)))
      (insert-spec spec 'sort (fdef-ausgabe-sorten (car f-list)))
  )
)


;**********************************************************************
;** function name :  insert-bool                                     **
;** arguments     :  spec                                            **
;** effect        :  fuegt bool, falls in Funktionsdeklaration vor-  **
;**   handen, als Sorte ein.                                         **
;** return value  :                                                  **
;** edited        :  08.08.1991                                      **
;**********************************************************************
(defun insert-bool (spec)
  (do* ((funclist (get-spec spec 'function) (cdr funclist))
        (sorts (append (fdef-eingabe-sorten (car funclist))
                       (fdef-ausgabe-sorten (car funclist)))
               (append (fdef-eingabe-sorten (car funclist))
                       (fdef-ausgabe-sorten (car funclist))))
        (done nil)
       )
       ((or (null funclist) done) nil)
       (when (member "bool" sorts :test 'equal)
             (insert-spec spec 'sort (list "bool"))
             (setq done 'true)
       ) ;** when **
  ) ;** do **
) ;** insert-bool **


;**********************************************************************
;** function name :  make-consistent                                 **
;** arguments     :  spec, ref-spec                                  **
;** effect        :  ueberfuehrt spec in einen (syntaktisch)         **
;**                  konsistenten Zustand                            **
;** return value  :                                                  **
;** edited        :  6.6.1991                                        **
;**********************************************************************
(defun make-consistent (logspec asfspec)
  ;** folgendes wird gemacht :
  ;** (1) Infix/Praefix der Funktionen aus der logspec wird an die asfspec
  ;**     angeglichen. --> change-function-code
  ;** (2) Da man in ASF die Moeglichkeit hat built-ins zu benutzen, muss
  ;**     gegebenenfalls die Sorte "bool" in die asfspec eingetragen
  ;**     werden. Sorten werden durch den spec-parser eingetragen, wenn 
  ;**     dieser Funktionsdefinitionen einliest. Deswegen ist die logspec
  ;**     diesbezueglich konsistent. --> insert-bool
  ;** (3) Die RRL-precedence und die ASF-precedence werden auf Konsistenz
  ;**     ueberprueft und gegebenenfalls geloescht. 
  ;** (4) Da in der asfspec die built-ins nicht als Funktionen deklariert
  ;**     sind, werden alle aus der logspec als Funktion herausgeworfen.
  ;** (5) Der log-parser kann als constructor,ac-operator, c-operator, suffice,
  ;**     status, precedence nicht-existierende Funktionen in die logspec laden.
  ;**     Dies ist aus dem log-file allein nicht zu entscheiden, deswegen
  ;**     muessen diese Funktionen aus der log-spec geloescht werden.
  ;**     --> delete-non-existing-functions, delete-in-precedence

  (format t "make consistent : check prefix/infix~%") 
  (change-function-code logspec asfspec)
  (format t "                  check built-ins~%")
  (insert-bool asfspec)
  (format t "                  check precedence + transitive reduction~%")
  ;** ueberpruefe precedence 
  (let ((log-prec (check-precedence logspec))
        (asf-prec (check-precedence asfspec))
       )
       (unless (and log-prec asf-prec)
               (if log-prec
                   (format t "inconsistent RRL-precedence !~% ")
                   )
                   (if asf-prec
                       (format t "inconsistent ASF-precedence !~%")
                   )
                   ; loesche Praezedenz
                   (delete-spec logspec 'precedence)
                   (delete-spec asfspec 'precedence)
       ) ;** unless **
  ) ;** let **

;** Variablen werden bei der Berechnung der Differenz nicht beachtet, daher
;** wird hier kein Versuch unternommen, die Variablen in den Termen zu
;** bestimmen.
;** Beim Rausschreiben der Gleichungen muessen allerdings die verwendeten
;** Variablen bestimmt werden und eventuelle Umbenennungen vorgenommen
;** werden!!!!
  ;** entferne built-in
;** 3.12.91 : Ausgabe der Funktionen auf Bildschirm !!! **
  (do* ((funclist (get-spec logspec 'function) (cdr funclist))
        (func (fdef-name (car funclist)) (fdef-name (car funclist))) 
        (built-ins '("true" "false" "not" "and" "or" "xor" "equ"))
       )
       ((null funclist) nil)
       (if (member func built-ins :test 'equal)
           (delete-entry logspec 'function func)
       ) ;** if **
  ) ;** do **
  (format t "                  delete non-existing functions : ~%")
  (format t "                    constructors~%")
  (delete-non-existing-functions logspec 'constructor)
  (format t "                    ac-operators~%")
  (delete-non-existing-functions logspec 'ac-operator)
  (format t "                    c-operators~%")
  (delete-non-existing-functions logspec 'c-operator)
  (format t "                    status~%")
  (delete-non-existing-functions logspec 'status)
  (format t "                    sufficient complete~%")
  (delete-non-existing-functions logspec 'suffice)
  ;** Bei der Ordnung muss beachtet werden, dass undefinierte Funktionen
  ;** bezueglich der Ordnung zu einer existierenden Funktion als kleiner
  ;** eingetragen werden koennen
  (format t "                    precedence~%")
  (delete-in-precedence logspec)
) ;** make-consistent **


;**********************************************************************
;** function name :  delete-non-existing-functions                   **
;** arguments     :  spec code                                       **
;** effect        :  loescht alle nicht als Funktionen eingetragene  **
;**                  Symbole                                         **
;** return value  :                                                  **
;** edited        :  6.6.1991                                        **
;**********************************************************************
(defun delete-non-existing-functions (spec code)
  (do ((l (get-spec spec code) (cdr l))
      )
      ((null l) )
      (if (null (get-entry spec 'function (caar l)))
          (delete-entry spec code (caar l))
      )
  )
)

;**********************************************************************
;** function name :  delete-in-precedence                            **
;** arguments     :  spec                                            **
;** effect        :  loescht alle nicht als Funktionen eingetragene  **
;**                  Symbole, die vorkommen                          **
;** remark        :  dies ist eine spezielle Funktion                **
;** return value  :                                                  **
;** edited        :  12.6.1991                                       **
;**********************************************************************
(defun delete-in-precedence (spec)
  (do ((l (get-spec spec 'precedence) (cdr l))
       (r nil 
          (if (null (get-entry spec 'function (caar l)))
              ; entferne Eintrag
              r
              ; ueberpruefe assoziierte Funktionen
              (do ((k (cdar l) (cdr k))
                   (s nil
                      (if (null (get-entry spec 'function (car k)))
                          ; entferne Eintrag
                          s
                          ; fuege hinzu
                          (cons (car k) s)
                      )
                   )
                  )
                  ((null k)
                   (if (null s)
                       ; alle kleineren Funktionen wurden geloescht
                       r
                       ; fuege Praezedenz ein
                       (cons (cons (caar l) (reverse s))
                             r)
                   )
                  )
              ) ;** do **
          )
       ) ;** r **
      )
      ((null l)
       ; loesche alte Eintraege und fuege neu ein
       (delete-spec spec 'precedence)
       (insert-spec spec 'precedence r)
      )
  )
)

;**********************************************************************
;** function name :  combine-symbol-lists                            **
;** arguments     :  liste (Assoziationsliste)                       **
;** effect        :  fuegt alle Assoziationen fuer ein Symbol in     **
;**                  einem Eintrag zusammen                          **
;** return value  :  neue Liste                                      **
;** edited        :  13.6.1991                                       **
;**********************************************************************
(defun combine-symbol-lists (liste)
  (do ((l liste (cdr l))
       (result nil 
               (let ((entry (assoc (caar l) result :test 'equal))
                    )
                    (if entry
                        (progn
                          (rplacd entry (append (cdar l) (cdr entry)))
                          result
                        )
                        (cons (car l) result)
                    )
               )
       )
      )
      ((null l) result)
  )
)

;**********************************************************************
;** function name :  find-maximal-elements                           **
;** arguments     :  Ordnung                                         **
;** effect        :  finde alle Element, die keine eingehende Kanten **
;**                  haben                                           **
;** return value  :  die Eintraege der maximalen Elemente            **
;** edited        :  13.6.1991                                       **
;**********************************************************************
(defun find-maximal-elements (precedence)
  (do ((l (do ((p precedence (cdr p))
               (r nil (append (cdar p) r))
              )
              ((null p) r)
          )) ; l ist die Liste aller Knoten, die eine eingehende Kante haben
       (pred precedence (cdr pred))
       (result nil (if (member (caar pred) l :test 'equal)
                       result
                       (cons (car pred) result)
                   )
       )
      )
      ((null pred) result)
  )
)

;**********************************************************************
;** function name :  remove-elements                                 **
;** arguments     :  Liste von Elementen und eine Assoziationsliste  **
;** effect        :  loescht alle Eintrage der Elemente              **
;** return value  :  neue Liste                                      **
;** edited        :  13.6.1991                                       **
;**********************************************************************
(defun remove-elements (elements liste)
  (do ((l liste (cdr l))
       (result nil
               (if (assoc (caar l) elements :test 'equal)
                   result
                   (cons (car l) result)
               )
       )
      )
      ((null l) result)
  )
)

;**********************************************************************
;** function name :  erreichbar?                                     **
;** arguments     :  Anfangselement, zu suchendes Element und Liste  **
;** effect        :  bestimmt die Nachfolgemenge des Anfangselement  **
;** return value  :  TRUE, gdw zu suchendes Element in der Nachfolge-**
;**                  menge                                           **
;** edited        :  13.6.1991                                       **
;**********************************************************************
(defun erreichbar? (start kante precedence)
  (do ((queue (list start) (cdr queue))
       (visited nil (cons (car queue) visited))
       (kanten nil)
       (found nil)
      )
      ((or (null queue)
           found)
       found)
      (setq kanten (cdr (assoc (car queue) precedence :test 'equal)))
      (do ((k kanten (cdr k))
          )
          ((null k) )
          (cond ((equal (car k) kante)
                 (setq found 'TRUE))
                ((member (car k) (append visited queue) :test 'equal)
                 )
                ('TRUE
                 (setq queue (append queue (list (car k)))))
          )
      )
  )
)

;**********************************************************************
;** function name :  check-precedence                                **
;** arguments     :  spec                                            **
;** effect        :  Loescht alle transitiven Kanten in der Ordnung. **
;**                  Dabei wird die Praezedenz auf Konsistenz ueber- **
;**                  prueft.                                         **
;** return value  :  TRUE, gdw die Ordnung konsistent ist            **
;** edited        :  13.6.1991                                       **
;**********************************************************************
(defun check-precedence (spec)
  ; Diese Funktion bestimmt die kuerzeste Darstellung der Ordnung.
  ; Dabei wird auf Konsistenz geprueft.

  ; Idee: 
  ;   Es werden alle maximalen Elemente bestimmt (dabei werden sie aus
  ; dem Graphen entfernt). Fuer jede von diesen (maximalen Element, ge-
  ; nannt "maximum") ausgehende Kante wird ueberprueft, ob das erreichte
  ; Element (genannt "node") in der Folgemenge das maximalen Elementes ist.
  ; Es ist zu beachten, dass die Kanten der uebrigen maximalen Elemente nicht
  ; erreichbar sind (und daher auch entfernt wurden). Benoetigt werden also
  ; nur alle uebrigen von "maximum" ausgehenden Kanten.
  (let ((precedence (combine-symbol-lists (get-spec spec 'precedence)))
        (result-precedence nil)
       )
       (do* ((maximal-elements (find-maximal-elements precedence)
                               (find-maximal-elements rest-precedence))
             (rest-precedence (remove-elements maximal-elements precedence)
                              (remove-elements maximal-elements rest-precedence))
            )
            ((null maximal-elements) 
             (if (null rest-precedence)
                 ; fertig
                 (progn
                   (delete-spec spec 'precedence)
                   (insert-spec spec 'precedence result-precedence)
                   'TRUE
                 )
                 ; der Graph ist zyklisch
                 nil
             ))
            ; ueberpruefe fuer jedes maximals Element
            (do* ((maximal-list maximal-elements (cdr maximal-list))
                  (maximum (car maximal-list) (car maximal-list))
                 )
                 ((null maximal-list) )
                 ; betrachte jede Kante des maximalen Elements
                 (do* ((kanten-liste (cdr maximum) (cdr kanten-liste))
                       ; zu betrachtende Kanten
                       (kante (car kanten-liste) (car kanten-liste))
                       ; kontrollierte Kanten
                       (neue-kanten nil )
                      )
                      ((null kanten-liste) (setq result-precedence
                                                 (cons 
                                                   (cons (car maximum)
                                                         neue-kanten)
                                                   result-precedence)))
                      (unless (erreichbar? (car maximum)
                                           kante
                                           (cons 
                                            ; alle uebrigen Kanten von maximum
                                            (cons (car maximum)
                                                  (append neue-kanten
                                                          (cdr kanten-liste)))
                                            ; die restliche Ordnung
                                            rest-precedence))
                          (setq neue-kanten (cons kante neue-kanten))
                      )
                 )
            )
       )
  )
)

;**********************************************************************
;** function name :  change-function-code                            **
;** arguments     :  zu aendernde Spec und Referenz-Spec             **
;** effect        :  Veraendert die Funktionscodes gemaess der Dar-  **
;**                  stellung in der Referenz-Spec                   **
;** remark        :  diese Methode ist destruktiv                    **
;** edited        :  1.7.1991                                        **
;**********************************************************************
(defun change-function-code (spec refspec)
  (let ((funktionen (get-spec spec 'function))
        (ref-funktionen (get-spec refspec 'function))
       )
       ;** aendere Funktionsdefinitionen **
       (do ((l funktionen (cdr l))
           )
           ((null l) )
           (let ((entry (assoc (fdef-name (car l)) ref-funktionen :test 'equal))
                 (fcode (fdef-code (car l)))
                )
                (when entry
                      (if fcode
                          (unless (string= fcode (fdef-code entry))
                                  (fdef-set-code (car l) (fdef-code entry))
                          )
                          (fdef-set-code (car l) (fdef-code entry))
                      ) ;** if **
                ) ;** when **
           ) ;** let **
       ) ;** do **
  ) ;** let **

  ;** nun muessen die Terme in den add-equations, kb-equations, prove
  ;** der *log-spec* gegebenfalls an die *asf-spec* angeglichen werden. 
  (let ((equations (append (get-spec spec 'add-equation)
                           (get-spec spec 'spec-equation)
                           (get-spec spec 'prove)))
       )
       (do ((l equations (cdr l))
           )
           ((null l) nil)
           (change-equation (car l) (get-spec spec 'function))
       ) ;** do **
  ) ;** let **
) ;** change-function-code **


(defun variable? (term)
  (stringp term)
) ;** variable? **


;**********************************************************************
;** function name :  change-equation                                 **
;** arguments     :  Gleichung und die Funktionen aus der Referenz-  **
;**   spec.                                                          **
;** effect        :  aendert destruktiv die Funktionen in der        **
;**  equation in Bezug auf praefix/infix gemaess functions           **
;** remark        :  diese Methode ist destruktiv                    **
;** edited        :  13.8.1991                                       **
;**********************************************************************
(defun change-equation (equation functions)
  (change-term (equ-t1 equation) functions)
  (change-term (equ-t2 equation) functions)
  (dolist (l (equ-conds equation))
          (change-term l functions)
  ) ;** dolist **
) ;** change-equation **


;**********************************************************************
;** function name : change-term                                      **
;** arguments     : ein Term und die Funktionen aus der Referenzspec **
;** effect        : siehe change-equation                            **
;** remark        :  diese Methode ist destruktiv                    **
;** edited        :  13.7.1991                                       **
;**********************************************************************
(defun change-term (term functions)
  (cond ((variable? term) nil)
        (t (let* ((func (term-function term))
                  (func-code (fdef-code (find-function func functions)))
                  (args (term-args term))
;** Eschbach
;** 07.05.92 "=" hinzugefuegt !
;; Eschbach Mon Aug 15 12:35:18 MET DST 1994
;; cond hinzugefuegt		  
                  (built-ins '("true" "false" "not" "and" "or" "xor" "equ" "=" "cond"))
                 )
                 ;** die built-ins sind nicht in der *asf-spec* deklariert,
                 ;** deswegen muss dies gesondert abgefragt werden.
                 (cond ((member func built-ins :test 'equal)
                        (if (member func '("and" "or" "xor" "equ") :test 'equal)
                            (term-set-code term "functor"))
                        )
                       ((not (equal (term-code term) func-code))
                        (term-set-code term func-code))
                       ('true nil)
                 ) ;** cond **
                 (dolist (l args)
                         (change-term l functions)
                 ) ;** dolist **
           ) ;** let* **
        )
  ) ;** cond **
) ;** change-term **




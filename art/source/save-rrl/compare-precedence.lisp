(IN-PACKAGE "SAVE-RRL")

;**********************************************************************
;** function name :    **
;** arguments     :    **
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
;**   gibt. Es wird ueberprueft, dass G(asf) in G(rrl) enthalten     **
;**   ist, d.h. gibt es in G(asf) die Kante u->v, dann wird ueber-   **
;**   prueft, ob es in G(rrl) einen Weg u~~>v gibt. In G(delta)      **
;**   werden werden alle Unterschiede von G(asf) und G(rrl)          **
;**   gesammelt.                                                     **
;** return value  : G(delta) als Liste von Tupeln                    **
;** edited        : 14.06.1991                                       **
;** author        : Robert                                           **
;**********************************************************************
(defun compare-precedence (ASF-prec RRL-prec)
  (let ((G_asf ASF-prec)
        (G_rrl RRL-prec)
        (G_delta NIL)
        (S_delta NIL)
       )
       (if (not (or (null ASF-prec) (null RRL-prec)))
           (same-edges RRL-prec 
                      (compare-precedence-help G_asf G_rrl G_delta))
       ) ;** if **
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


(setq ASF-prec '(("a" "b") ("b" "c") ("b" "d") ("a" "f") ("g" "h")))
(setq RRL-prec '(("a" "i") ("i" "b") ("b" "j") ("j" "k") ("k" "c") ("j" "l") ("b" "m") ("m" "d") ("a" "g") ("g" "f") ("f" "h")))
(setq RRL-prec '(("g" "f") ("f" "d") ("d" "z") ("z" "h") ("a" "f") ("a" "w") ("w" "b") ("b" "c") ("b" "d") ("q" "wer") ("wer" "a") ("wer" "g")))

;(successors ASF-prec "u")
;(print ASF-prec)
(print-precedence (compare-precedence ASF-prec RRL-prec))
;(compare-precedence '(("a" "b")) '(("a" "b")))
;(compare-precedence '(("a" "b")) '(("a" "b") ("a" "c")))
;(compare-precedence '(("a" "b") ("c" "d")) '(("a" "b") ("d" "b") ("c" "d")))
;(compare-precedence '(("a" "b") ("a" "d")) '(("a" "b") ("b" "d")))



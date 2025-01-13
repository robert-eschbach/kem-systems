;; example 3.11 from
;; CP prover

init

option prove e

add
[ f : NAT -> NAT ]

;; can't be oriented into a rule
;; but you can make a equation (x = y) --> true if .....
;; (x = y) if (f(x) = f(y))

not(f(x) = f(y)) if not(x = y)
] 

mr

add
not(f(x) = f(y)) or (x = y)
]

;; wird option prove e nicht gesetzt, so wird aus Gleichung
;; (F(X) = F(Y)) == FALSE  if  NOT((X = Y))
;; diese faellt dann weg
;; ist hengegen option prove e gesetzt,
;; so wird true--> false abgeleitet !
;; Gleichung bleibt :  (NOT((F(X) = F(Y))) OR (X = Y))

;; order-eqns
;;   process-eqns
;;     cover-norm-order (falls $induc)




;; (trace  bool-rewrite-at-root)
;; (trace cover-norm-term norm-bool-innermost norm-or-args)
;; (trace order-eqns process-equation cover-norm-order cover-normalize)
;; (trace cover-uncondi-norm)
;; (trace reduce-by-premises-at-root)

;; Fehler wahrscheinlich in reduce-by-premises-at-root (premises)
;; falls keine rules, wird nil zurueckgeliefert !
;; also false 
;; faengt man das in dieser Funktion ab, kommt es zu Endlos-Schleifen


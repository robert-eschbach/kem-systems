init

option prove e

add
;; f(x) == g(x) if ( f (x) = 0)  and ( f(f(x)) = 0 )    
;; Adding Rule:   [1] G(X) ---> 0  if  
;;         { (F(X) = 0),
;;           (F(0) = 0) }   [USER, 1]
;; d.h. eq(f(x),0) wird zu f(x) --> 0 (x als Konstante)
;; bei Simplifikation
;; und f(x) = 0 wird nach der Simplifikation mit den anderen
;; premises wieder in die Menge der premises aufgenommen
;; desweiteren wurde die Gleichung f(x) == g(x) mit den
;; premises simplifiziert
;; Klausen sind log. aequiv.

f(x) == g(x) if ( f(f(x)) = 0 ) and ( f (x) = 0 )

]


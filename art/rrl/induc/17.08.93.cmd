;; 17.08.93
;; Was passiert mit den Bedingungen innerhalb der Beweise ?
;; Werden sie als ind. Theoreme behandelt ?
;; Wo liegt der Unterschied bei der Simplifikation von bed. Definitionen 
;; und Eigenschaften, Beweisaufgaben ?

init
option prove e

add
[ 0 : num]
[ suc : num -> num]
[ + : num, num -> num]
[ < : num, num -> num]
x + 0 := x
x + suc(y) := suc(x + y)
x < 0 := false
0 < suc(x) := true
suc(x) < suc(y) := x < y
]

operator constructor
0 suc
y

makerule

option prove e

suffice

add
;; folgende Gleichung wird nach ihrer Orientierung geloescht !
x + y == 0 if (x = 0) and (y = 0)

;; wird auch wegsimplifiziert !
x + y == z if (z = suc(x)) and (y = suc(0))

;; hieraus wird : 
;; (X < (Z + X)) ---> TRUE  if   { (Z < X) }
x < y if (y = (z + x)) and (z < x)

;; hier entsteht ein Fehler in Lisp
;; vielleicht auch nicht richtig , denn
;; Orientierung z = ?, z = ?
;; das ist doch nicht interreduziert ? Oder ?
;; Pruefen !!
x = y if (suc(x) = z) and (z = suc(y))
]

makerule


;; Bei folgenden Beweis wird die Gleichung negiert zu den premises
;; hinzugenommen.
;; Danach wird simplifiziert, sowohl mit den den uebrigen premises
;; wie auch mit den rules
;; Die besondere Gestalt var = term in den premises, fuehrt zu Substitutionen :
;; am Ende hat man in den premises folgende Gleichung stehen 
;; (x + suc(0) = suc(x)) = false 
prove
x + y == z if (z = suc(x)) and (y = suc(0))


;; Hier mal was falsches !
;; Die Variable z kommt nur in der rechten Seite vor !
;; Induktion scheitert, RRL findet kein ind.scheme !
prove
x + y == z if (x = suc(suc(0))) and (y = suc(0))


;; Bedingung so aufbauen, dass eine premise zur Reduktion
;; einer anderen herangezogen werden kann !
;; nachher in $var-premises : (y (suc (0))) und (x (suc (suc (0))))
prove
suc(x) + suc(y) == x + y if ( y = suc(0)) and (x = suc(y))



;; auto 17.08.93


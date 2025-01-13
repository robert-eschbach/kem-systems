;; 19.08.93
;; Wie wird bed. Def. simplifiziert ?
;; Wie in Zhang beschrieben !
;; Wie wird Gleichung durch bed. Regel reduziert , simplifiziert ?
;; siehe Heft !


init
option prove e

option trace 3

add
[ 0 : num]
[ suc : num -> num]
[ + : num, num -> num]
[ < : num, num -> bool]
[div : num, num -> num]

x + 0 := x
x + suc(y) := suc(x + y)

x < 0 := false
0 < suc(x) := true
suc(x) < suc(y) := x < y

;; hier ist wichtig, dass option prove e gesetzt ist,
;; sonst wird diese Gleichung nicht zur Reduktion herangezogen !
;; x < y := true if (x < z) and (z < y)

div(x, 0) := 0
div(x, y) := 0 if x < y
div(y + x, y) := suc(div(x, y)) if not(0 = y)

]

;; auto 19.08.93

operator constructor
0 suc
y

makerule

;; siehe oben !
;; option prove e

suffice

add
div(y + x, y) == suc(0) if (x = 0) and not(y = 0)
]

makerule

;; auto 19.08.93

;; 18.08.93
;; Wie werden bedingte Definitionen simplifiziert ?
;; Es ist wichtig, dass das option prove e vor
;; den Definitionen kommt
;; etwa bei x < y := true if (x < z) and (z < y)
;; sonst wird diese Regel nicht zur 
;; Reduktion herangezogen !


init
option prove e

add
[ 0 : num]
[ suc : num -> num]
[ + : num, num -> num]
[ < : num, num -> bool]
x + 0 := x
x + suc(y) := suc(x + y)
x < 0 := false
0 < suc(x) := true
suc(x) < suc(y) := x < y
x < y := true if (x < z) and (z < y)
]

;; auto 18.08.93

operator constructor
0 suc
y

makerule

option prove e

suffice

add
]

makerule

prove
0 < y if not(y = 0)

prove
x < suc(x)

prove
x < suc(y) if (x < y)



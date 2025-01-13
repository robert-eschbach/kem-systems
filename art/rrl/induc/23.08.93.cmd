;; 23.08.93

init
option prove e

add
[ 0 : num]
[ suc : num -> num]
[ + : num, num -> num]
[ * : num, num -> num]
[- : num, num -> num]
[ < : num, num -> bool]
[div : num, num -> num]
[rem : num, num -> num]
[gcd : num, num -> num]

x + 0 := x
x + suc(y) := suc(x + y)

x * 0 := 0
x * suc(y) := x + x * y

0 < suc(x) := true
x < 0 := false
suc(x) < suc(y) := x < y

0 - x := 0
x - 0 := x
suc(x) - suc(y) := x - y

div(x, 0) := 0
div(x, y) := 0 if x < y
div(y + x, y) := suc(div(x, y)) if not(0 = y)

rem(x, 0) := x
rem(x, y) := x if x < y
rem(y + x, y) := rem(x, y)

gcd(x, 0) := x
gcd(0, y) := y
gcd(x + y, y) := gcd(x, y)
gcd(x, x + y) := gcd(x, y)
]

;; auto 23.08.93

operator constructor
0 suc
y

operator precedence
* +

makerule

suffice
y
y

add
]

makerule

;; auto 23.08.93

prove
div(0, y) == 0




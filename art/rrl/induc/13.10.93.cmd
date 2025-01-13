init

option prove e

add
[ 0 : nat ]
[ s : nat -> nat ]
[ + : nat , nat -> nat ]
[ * : nat , nat -> nat]

x + 0 := x 
x + s(y) := s(x + y)

x * 0 := 0 
x * s(y) := (x * y) + x
]

operator constructor 0

operator constructor s
y

operator precedence * +

makerule

;;add
;;(x + y)  == (y + x)
;;]

makerule

prove 
(x + y)  == (y + x)

prove 
x + (y + z)  == (x + y) + z

prove
x * (y * z) == (x * y) * z



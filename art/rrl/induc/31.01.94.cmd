init
option prove e

add
;; the constructors for the naturals:
[ 0 : num]
[ suc : num -> num]

[ + : num, num -> num]
x + 0 := x
x + suc(y) := suc(x + y)

[ * : num, num -> num]
x * 0 := 0
x * suc(y) := x + x * y

[< : num, num -> bool]
0 < suc(x) := true
x < 0 := false
suc(x) < suc(y) := x < y

[sub1 : num -> num]
sub1(0) := 0
sub1(suc(x)) := x

[- : num, num -> num]
0 - x := 0
x - 0 := x
suc(x) - suc(y) := x - y

[div : num, num -> num]
div(x, 0) := 0
div(x, y) := 0 if x < y
div(y + x, y) := suc(div(x, y)) if not(0 = y)

[rem : num, num -> num]
rem(x, 0) := x
rem(x, y) := x if x < y
rem(y + x, y) := rem(x, y)

[divides : num, num -> bool]
divides(x, y) := rem(y,x) = 0


;; the constructors for the lists.
[null : list]
[cons : univ, list -> list]

[append : list, list -> list]
append(null, y) := y
append(cons(x, y), z) := cons(x, append(y, z)) 

[length : list -> num]
length(null) := 0
length(cons(x, y)) := suc(length(y))

[delete : univ, list -> list]
delete(x, null) := null
delete(x, cons(y, z)) := cond((x = y), z, cons(y, delete(x, z)))

[prime1 : num, num -> bool]
;; prime1(x, y) returns true iff for any 0 < z <= y, not(z | x).
prime1(x, 0) := false
prime1(x, suc(0)) := true
prime1(x, suc(y)) := cond(divides(suc(y), x), false, prime1(x,y)) if not(y = 0)

[prime : num -> bool]
prime(0) := false
prime(suc(x)) := prime1(suc(x), x) 

[primelist : list -> bool]
primelist(null) := true
primelist(cons(x, y)) := cond(prime(x), primelist(y), false)

[products : list -> num]
products(null) := suc(0)
products(cons(x, y)) := x * products(y)

[primefacs : num -> list]
primefacs(0) := null
primefacs(suc(0)) := null
primefacs(suc(suc(x))) := cons(suc(suc(x)), null) if prime(suc(suc(x)))
primefacs(x * y) := append(primefacs(x), primefacs(y)) if not(x = 0) and not(y = 0)

[member : univ, list -> bool]
member(x, null) := false
member(x, cons(y, z)) := cond((x = y), true, member(x, z))

[sublist : list, list -> bool]
sublist(null, x) := true
sublist(cons(x, y), null) := false
sublist(cons(x, y), z) := cond(member(x, z), sublist(y, delete(x, z)), false)

[nocommon : list, list -> bool]
nocommon(null, x) := true
nocommon(cons(x, y), z) := cond(member(x, z), false, nocommon(y, z))

[prime2 : num, num -> bool]
prime2(x, y) := nocommon(primefacs(x), primefacs(y))
] ;; end of input

operator constructor
0 suc null cons
y
y

operator
precedence
prime2 primefacs products primelist prime prime1 nocommon sublist length member delete append divides rem div - sub1 < * + cond

operator status sublist lr

makerule


prove
div(0, y) == 0

y
y
y

prove
rem(0, y) == 0
 

add
rem(y, x1*x2) = 0 if 
	(rem(div(y, x1), x2) = 0) and not(x1 = 0) and not(x2 = 0) and (rem(y, x1) = 0)
]

prove 
rem(div(y, x1), x2) = 0 if 
     not(x1 = 0) and not(x2 = 0) and not(y = 0) and
     prime2(x1, x2) and (rem(y, x1) = 0) and (rem(y, x2) = 0)

;;prove
;;; an important lemma.
;;rem(y, x1 * x2) == 0 if
;;     not(x1 = 0) and not(x2 = 0) and not(y = 0) and
;;     prime2(x1, x2) and (rem(y, x1) = 0) and (rem(y, x2) = 0)



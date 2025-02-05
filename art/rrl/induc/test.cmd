;; This file contains RRL's commands for proving the Chinese remainder theorem.

init
option prove e

add
;; the constructors for the naturals:
[ 0 : num]
[ suc : num -> num]

1 == suc(0)

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

namerule prime2-def

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; the following lemmas are taken from prime.cmd
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

prove
div(0, y) == 0

y
y
y

prove
rem(0, y) == 0

kb

prove
x + y == y + x

prove
(x + y) + z == x + (y + z)

prove
(y * div(y + x, y)) == (y * suc(div(x, y)))

prove
(rem(x, y) + (y * div(x, y))) == x

prove
(y * div(x, y)) == x if divides(y, x)

prove
(x * (y + z)) == ((x * y) + (x * z))

prove
(x * y) * z == x * (y * z)

stat * l

prove
x * y == y * x 

prove
0 < x == not(x = 0)

prove
x < suc(0) == x = 0

prove
y < suc(y)

prove
(x + y) = 0 == (x = 0) and (y = 0)

prove
(x + y) = y == (x = 0)

prove
(x + z) = (y + z) == (x = y)

prove
(x * y) = 0 == (x = 0) or (y = 0)

prove
div((x * y), x) == y if not((x = 0))

prove
rem((y * x), x) == 0

prove
rem((u * y), x) == 0 if divides(x, u) and not(x = 0)

prove
rem(x + y,z) = rem(x, z) if divides(z, y)
exit

prove
delete(x, y) == y if not member(x, y)

prove
divides(x, products(y)) == true if member(x, y)

prove
primelist(delete(x, y)) if primelist(y)

prove 
div(z + y, x) == div(z, x) + div(y, x) if divides(x, z) and not(x = 0)
exit


option
undo
noundo
add

The arities of the operators are:
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [div : NAT, NAT -> NAT ]
      [rem : NAT, NAT -> NAT ]
      [divides : NAT, NAT -> bool ]
      [gcd : NAT, NAT -> NAT ]
      [sub1 : NAT -> NAT ]
      [succ : NAT -> NAT ]
      [null : -> NATLIST ]
      [cons : NAT, NATLIST -> NATLIST ]
      [append : NATLIST, NATLIST -> NATLIST ]
      [delete : NAT, NATLIST -> NATLIST ]
      [member : NAT, NATLIST -> bool ]
      [perm : NATLIST, NATLIST -> bool ]
      [prime : NAT -> bool ]
      [primelist : NATLIST -> bool ]
      [primefac : NAT -> NATLIST ]
      [prime1 : NAT, NAT -> bool ]
      [timelist : NATLIST -> NAT ]
      [0 : -> NAT ]


(x + 0) == x
(x + succ(y)) == succ((x + y))
(0 - x) == 0
(x - 0) == x
(succ(x) - succ(y)) == (x - y)
(x * 0) == 0
(x * succ(y)) == (x + (x * y))
(x < 0) == false
(0 < succ(x))
(succ(x) < succ(y)) == (x < y)
(x >= x)
(0 >= succ(y)) == false
(succ(x) >= y) == (x >= y) if not((succ(x) = y))
div(x, 0) == 0
div(x, y) == 0 if (x < y)
div((y + x), y) == succ(div(x, y)) if not((0 = y))
rem(x, 0) == x
rem(x, y) == x if (x < y)
rem((y + x), y) == rem(x, y)
divides(x, y) == (rem(y, x) = 0)
gcd(x, 0) == x
gcd(0, y) == y
gcd((x + y), y) == gcd(x, y)
gcd(x, (x + y)) == gcd(x, y)
sub1(0) == 0
sub1(succ(x)) == x
append(null, xnl1) == xnl1
append(cons(x, xnl1), xnl2) == cons(x, append(xnl1, xnl2))
delete(x, null) == null
delete(x, cons(x, xnl1)) == xnl1
delete(x, cons(y, xnl1)) == cons(y, delete(x, xnl1)) if not((y = x))
member(x, null) == false
member(x, cons(x, xnl1))
member(x, cons(y, xnl1)) == member(x, xnl1) if not((x = y))
perm(null, null)
perm(null, cons(x, xnl1)) == false
perm(cons(x, xnl1), null) == false
perm(cons(x, xnl1), xnl2) == (member(x, xnl2) and perm(xnl1, delete(x, xnl2)))
prime(0) == false
prime(succ(x)) == prime1(succ(x), x)
primelist(null)
primelist(cons(x, xnl)) == (prime(x) and primelist(xnl))
timelist(null) == succ(0)
timelist(cons(x, xnl)) == (x * timelist(xnl))
primefac(0) == null
primefac(succ(0)) == null
primefac((x * y)) == append(primefac(x), primefac(y)) if (not((x = 0)) and not((y = 0)))
prime1(x, 0) == false
prime1(x, succ(0))
prime1(x, succ(y)) == (not(divides(succ(y), x)) and prime1(x, y)) if not((y = 0))
]
operator
constructor
0 
operator
constructor
succ 
yes
operator
constructor
null 
operator
constructor
cons 
yes
operator
acoperator
+ * 
operator
commutative
gcd 
operator
precedence
* + 
operator
precedence
>= < 
operator
precedence
divides rem 
operator
precedence
div * 
operator
precedence
gcd * 
operator
precedence
perm member 
operator
precedence
perm delete 
operator
precedence
primelist prime 
operator
precedence
timelist * 
operator
precedence
primefac append 
operator
precedence
prime prime1 
operator
precedence
prime1 rem 
operator
status
*
operator
status
<
lr
operator
status
perm
lr
makerule
option
prove
e
cover
add

The arities of the operators are:
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [div : NAT, NAT -> NAT ]
      [rem : NAT, NAT -> NAT ]
      [divides : NAT, NAT -> bool ]
      [gcd : NAT, NAT -> NAT ]
      [sub1 : NAT -> NAT ]
      [succ : NAT -> NAT ]
      [null : -> NATLIST ]
      [cons : NAT, NATLIST -> NATLIST ]
      [append : NATLIST, NATLIST -> NATLIST ]
      [delete : NAT, NATLIST -> NATLIST ]
      [member : NAT, NATLIST -> bool ]
      [perm : NATLIST, NATLIST -> bool ]
      [prime : NAT -> bool ]
      [primelist : NATLIST -> bool ]
      [primefac : NAT -> NATLIST ]
      [prime1 : NAT, NAT -> bool ]
      [timelist : NATLIST -> NAT ]
      [0 : -> NAT ]


((u * y) < succ(y)) == false if (((0 = u) equ false) and (((succ(0) = u) equ false) and ((0 = y) equ false)))
((u + z) < succ(succ(y))) == false if (((0 = u) equ false) and (((succ(0) = u) equ false) and ((z < succ(y)) equ false)))
((u + x) < succ(y)) == false if ((((u + x) < succ(succ(y))) equ false) and (((x < y) equ false) and (((succ(0) = u) equ false) and ((0 = u) equ false))))
((u + x) < succ(y)) == false if ((x < succ(y)) and (((x < y) equ false) and (((succ(0) = u) equ false) and ((0 = u) equ false))))
(u < succ(succ(0))) == false if (((succ(0) = u) equ false) and ((0 = u) equ false))
(succ(x) < z) == (x < z) if ((succ(x) = z) equ false)
(true xor (u < u))
(0 < x) == true if ((0 = x) equ false)
(0 >= u) == (0 = u)
((x * y) = succ(0)) == false if ((succ(0) = x) equ false)
((x + z) = succ(0)) == false if (((succ(0) = x) equ false) and ((succ(0) = z) equ false))
((x * y) = x) == (((0 = x) xor (succ(0) = y)) xor ((0 = x) and (succ(0) = y)))
((x * y) = x) == (succ(0) = y) if ((0 = x) equ false)
((x * y) = 0) == (((0 = x) xor (0 = y)) xor ((0 = x) and (0 = y)))
((y + z) = (x + z)) == (y = x)
((x + y) = y) == (0 = x)
((x + y) = 0) == false if ((0 = x) equ false)
(x < succ(0)) == (0 = x)
(x + (z + z1)) == (z + (x + z1))
(succ(y) + x) == succ((y + x))
(0 + x) == x
((u * y) < succ(y)) == false if (not((u = 0)) and (not((u = succ(0))) and not((y = 0))))
(succ(x) < y) == true if ((x < y) and not((succ(x) = y)))
(succ(x) < y) == true if (((succ(x) = y) equ false) and (x < y))
(0 >= u) == (u = 0)
(y < succ(y))
((x * y) = succ(0)) == ((x = succ(0)) and (y = succ(0)))
((x * y) = x) == ((y = succ(0)) or (x = 0))
((x * y) = x) == (y = succ(0)) if not((x = 0))
((x * y) = 0) == ((x = 0) or (y = 0))
((x + z) = (y + z)) == (x = y)
((x + y) = y) == (x = 0)
((x + y) = 0) == ((x = 0) and (y = 0))
(x < succ(0)) == (x = 0)
(x * (y + z)) == ((x * y) + (x * z))
(x + y) == (y + x)
rem(y, y) == 0
rem(succ((y + x)), y) == rem(succ(x), y)
div(y, y) == succ(0) if not((0 = y))
gcd(x, succ(0)) == succ(0) if ((0 = x) equ false)
(sub1(x) < y) == (x < succ(y)) if ((0 = x) equ false)
rem(succ(0), x) == succ(0) if ((succ(0) = x) equ false)
div((y + (x * z)), x) == (z + div(y, x)) if ((0 = x) equ false)
(div(x, y) < x) == true if (((0 = x) equ false) and (((0 = y) equ false) and ((succ(0) = y) equ false)))
(succ(z) < (x + y)) == true if (((0 = y) equ false) and (((succ(0) = y) equ false) and (z < x)))
rem((x + (z * z1)), z) == rem(x, z)
rem((x * y), x) == 0
div((x * y), x) == y if ((0 = x) equ false)
(x * (y * z)) == (z * (x * y))
(succ(y) * x) == (x + (y * x))
(0 * x) == 0
((y * div(x, y)) + rem(x, y)) == x
(y * div((x + y), y)) == (y + (y * div(x, y)))
(succ(succ((x + y))) < y) == false if (((x + y) < y) and (x < y))
(succ(x) < x) == false
(gcd(x, y) = x) == false if not((rem(y, x) = 0))
rem(x, gcd(x, y)) == 0
(rem((y * z), x) = 0) == false if ((gcd((x * y), (y * z)) = y) and (not((y = 0)) and not((rem(y, x) = 0))))
(gcd((x * y), z) = y) == false if ((rem(z, x) = 0) and not((rem(y, x) = 0)))
gcd((x * z), (y * z)) == (z * gcd(x, y))
gcd(x, y) == gcd(y, x)
(sub1(x) < y) == (x < succ(y)) if not((x = 0))
rem(succ(0), x) == succ(0) if not((x = succ(0)))
div((z * y), x) == (y * div(z, x)) if (divides(x, z) and not((x = 0)))
div((z + y), x) == (div(z, x) + div(y, x)) if (divides(x, z) and not((x = 0)))
(div(x, y) < x) == true if (not((x = 0)) and (not((y = 0)) and not((y = succ(0)))))
rem((x + y), z) == rem(x, z) if (rem(y, z) = 0)
rem((y * z), x) == 0 if ((rem(z, x) = 0) and not((x = 0)))
rem((y * x), x) == 0
div((x * y), x) == y if not((x = 0))
(x * (y * z)) == ((x * y) * z)
(x * y) == (y * x)
(y * div(x, y)) == x if divides(y, x)
(rem(x, y) + (y * div(x, y))) == x
(y * div((y + x), y)) == (y * succ(div(x, y)))
rem(0, y) == 0
div(0, y) == 0
delete(x, xnl1) == xnl1 if not(member(x, xnl1))
]
makerule
prove
divides(x, timelist(xnl)) == true if member(x, xnl)
n
y

; All subgoals are proved so 
 ; rem(timelist(xnl), x) == 0 if  { member(x, xnl) } 

;  is an inductive theorem.
; Following equation
;    divides(x, timelist(xnl)) == true  if  member(x, xnl)  [user, 129]
;    is an inductive theorem in the current system.
prove
(x = succ(0)) == false if prime(x)
Yes, by switching the body and the premises, the following equation
    (succ(0) = x) == false  if   { prime(x) }   [user, 130]
    is an equational theorem.

y
prove
(x = 0) == false if prime(x)
Yes, by switching the body and the premises, the following equation
    (0 = x) == false  if   { prime(x) }   [user, 131]
    is an equational theorem.

y
prove
primelist(delete(x, xnl)) == true if primelist(xnl)

; All subgoals are proved so 
 ; primelist(delete(x, xnl)) == true if  { primelist(xnl) } 

;  is an inductive theorem.
; Following equation
;    primelist(delete(x, xnl)) == true  if  primelist(xnl)  [user, 132]
;    is an inductive theorem in the current system.
prove
timelist(delete(x, xnl)) == div(timelist(xnl), x) if (not((x = 0)) and member(x, xnl))
y

; All subgoals are proved so 
 ; timelist(delete(x, xnl)) == div(timelist(xnl), x) if 
        { (0 = x) <=> false,
          member(x, xnl) } 

;  is an inductive theorem.
; Following equation
;    timelist(delete(x, xnl)) == div(timelist(xnl), x)  if  not((x = 0)) & member(x, xnl)  [user, 133]
;    is an inductive theorem in the current system.
1 
prove
(timelist(xnl) = 0) == false if primelist(xnl)

; All subgoals are proved so 
 ; (timelist(xnl) = 0) == false if  { primelist(xnl) } 

;  is an inductive theorem.
; Following equation
;    (timelist(xnl) = 0) == false  if  primelist(xnl)  [user, 134]
;    is an inductive theorem in the current system.
prove
timelist(append(xnl, x1nl1)) == (timelist(xnl) * timelist(x1nl1)) if (not((timelist(xnl) = 0)) and not((timelist(x1nl1) = 0)))

; All subgoals are proved so 
 ; timelist(append(xnl, x1nl1)) == (timelist(x1nl1) * timelist(xnl)) if 
        { (timelist(x1nl1) = 0) <=> false,
          (timelist(xnl) = 0) <=> false } 

;  is an inductive theorem.
; Following equation
;    timelist(append(xnl, x1nl1)) == (timelist(x1nl1) * timelist(xnl))  if  not((timelist(x1nl1) = 0)) & not((timelist(xnl) = 0))  [user, 135]
;    is an inductive theorem in the current system.
prove
timelist(primefac(x)) == x if not((x = 0))

; All subgoals are proved so 
 ; timelist(primefac(x)) == x if  { (0 = x) <=> false } 

;  is an inductive theorem.
; Following equation
;    timelist(primefac(x)) == x  if  not((x = 0))  [user, 136]
;    is an inductive theorem in the current system.
prove
primelist(primefac(x)) == true if not((x = 0))

; All subgoals are proved so 
 ; primelist(append(z, z1)) == true if 
        { primelist(z1),
          primelist(z) } 

;  is an inductive theorem.

; All subgoals are proved so 
 ; primelist(primefac(x)) == true if  { (0 = x) <=> false } 

;  is an inductive theorem.
; Following equation
;    primelist(primefac(x)) == true  if  not((x = 0))  [user, 137]
;    is an inductive theorem in the current system.
prove
prime1((x * z), u) == false if (not((z = succ(0))) and (not((z = 0)) and ((u >= z) and not((u = succ(0))))))

; All subgoals are proved so 
 ; rem((x * z), succ(succ(0))) == 0 if 
        { (succ(succ(0)) >= z),
          (succ(0) = z) <=> false,
          (0 = z) <=> false } 

;  is an inductive theorem.
y

; All subgoals are proved so 
 ; prime1((u * x), u) == false if 
        { (0 = u) <=> false,
          (succ(0) = u) <=> false } 

;  is an inductive theorem.

; All subgoals are proved so 
 ; prime1((x * z), u) == false if 
        { (succ(0) = u) <=> false,
          (0 = z) <=> false,
          (succ(0) = z) <=> false,
          (u >= z) } 

;  is an inductive theorem.
; Following equation
;    prime1((x * z), u) == false  if  not((u = succ(0))) & not((z = 0)) & not((z = succ(0))) & (u >= z)  [user, 138]
;    is an inductive theorem in the current system.
prove
(u >= z) == not((u < z))

; All subgoals are proved so 
 ; (u >= z) == (true xor (u < z))

;  is an inductive theorem.
; Following equation
;    (u >= z) == not((u < z))  [user, 139]
;    is an inductive theorem in the current system.
prove
prime1(x, sub1(x)) == false if (not((z = succ(0))) and (not((z = x)) and (not((x = 0)) and (not((x = succ(0))) and divides(z, x)))))

; All subgoals are proved so 
 ; prime1((z * z1), sub1((z * z1))) == false if 
        { (succ(0) = z1) <=> false,
          (0 = z1) <=> false,
          (0 = z) <=> false,
          (succ(0) = z) <=> false } 

;  is an inductive theorem.
; Following equation
;    prime1(x, sub1(x)) == false  if  not((x = 0)) & not((x = succ(0))) & not((z = x)) & not((z = succ(0))) & divides(z, x)  [user, 140]
;    is an inductive theorem in the current system.
prove
(rem(x, y) = 0) == false if (prime(x) and (not((y = succ(0))) and not((x = y))))
n

; All subgoals are proved so 
 ; (rem(x, y) = 0) == false if 
        { (y = x) <=> false,
          (succ(0) = y) <=> false,
          prime(x) } 

;  is an inductive theorem.
; Following equation
;    (rem(x, y) = 0) == false  if  not((x = y)) & not((y = succ(0))) & prime(x)  [user, 141]
;    is an inductive theorem in the current system.
prove
prime(y) == false if ((rem(x, y) = 0) and (prime(x) and not((x = y))))
Yes, by switching the body and the premises, the following equation
    prime(y) == false  if  
        { (y = x) <=> false,
          prime(x),
          (rem(x, y) = 0) }   [user, 142]
    is an equational theorem.

y
prove
gcd(x, y) == succ(0) if ((rem(x, gcd(x, y)) = 0) and (not((x = 0)) and (not((x = succ(0))) and (prime1(x, sub1(x)) and not((gcd(x, y) = x))))))
Yes, by switching the body and the premises, the following equation
    gcd(x, y) == succ(0)  if  
        { prime1(x, sub1(x)),
          prime1(x, sub1(x)),
          (0 = x) <=> false,
          (succ(0) = x) <=> false,
          (gcd(x, y) = x) <=> false }   [user, 143]
    is an equational theorem.

y
prove
prime1(x, sub1(x)) == false if (not((rem(y, x) = 0)) and not((gcd(x, y) = succ(0))))
Yes, by switching the body and the premises, the following equation
    prime1(x, sub1(x)) == false  if  
        { (rem(y, x) = 0) <=> false,
          (gcd(x, y) = succ(0)) <=> false }   [user, 144]
    is an equational theorem.

y
prove
(rem((y * z), x) = 0) == false if (prime(x) and (not(divides(x, y)) and not(divides(x, z))))

; All subgoals are proved so 
 ; (rem((y * z), x) = 0) == false if 
        { (rem(y, x) = 0) <=> false,
          (rem(z, x) = 0) <=> false,
          prime(x) } 

;  is an inductive theorem.
; Following equation
;    (rem((y * z), x) = 0) == false  if  not(divides(x, y)) & not(divides(x, z)) & prime(x)  [user, 145]
;    is an inductive theorem in the current system.
prove
member(x, xnl) == true if (prime(x) and (primelist(xnl) and divides(x, timelist(xnl))))
y

; All subgoals are proved so 
 ; member(x, xnl) == true if 
        { prime(x),
          primelist(xnl),
          (rem(timelist(xnl), x) = 0) } 

;  is an inductive theorem.
; Following equation
;    member(x, xnl) == true  if  prime(x) & primelist(xnl) & divides(x, timelist(xnl))  [user, 146]
;    is an inductive theorem in the current system.
prove
perm(xnl, x1nl1) == true if (primelist(xnl) and (primelist(x1nl1) and (timelist(xnl) = timelist(x1nl1))))
y

; All subgoals are proved so 
 ; perm(xnl, x1nl1) == true if 
        { primelist(x1nl1),
          primelist(xnl),
          (timelist(xnl) = timelist(x1nl1)) } 

;  is an inductive theorem.
; Following equation
;    perm(xnl, x1nl1) == true  if  primelist(x1nl1) & primelist(xnl) & (timelist(xnl) = timelist(x1nl1))  [user, 147]
;    is an inductive theorem in the current system.
write
spec-write
/usr/users/eschbach/specs/primes/primes.impl_1/primes.impl_1.spec
y

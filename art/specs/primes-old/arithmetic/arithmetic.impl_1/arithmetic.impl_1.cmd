add
      [succ : NAT -> NAT ]
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
]
operator
constructor
0 
operator
constructor
succ 
yes
operator
acoperator
+ 
operator
order
l
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
status
*
rl
makerule
option
prove
e
cover
add

      [succ : NAT -> NAT ]
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
      [0 : -> NAT ]


((u * y) < succ(y)) == false if (((0 = u) equ false) and (((succ(0) = u) equ false) and ((0 = y) equ false)))
((u + z) < succ(succ(y))) == false if (((0 = u) equ false) and (((succ(0) = u) equ false) and ((z < succ(y)) equ false)))
((u + x) < succ(y)) == false if ((((u + x) < succ(succ(y))) equ false) and (((x < y) equ false) and (((succ(0) = u) equ false) and ((0 = u) equ false))))
((u + x) < succ(y)) == false if ((x < succ(y)) and (((x < y) equ false) and (((succ(0) = u) equ false) and ((0 = u) equ false))))
(u < succ(succ(0))) == false if (((succ(0) = u) equ false) and ((0 = u) equ false))
(u >= z) == (true xor (u < z))
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
(u >= z) == not((u < z))
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
]
makerule
prove
div(0, y) == 0

; All subgoals are proved so 
 ; div(0, y) == 0

;  is an inductive theorem.
; Following equation
;    div(0, y) == 0  [user, 68]
;    is an inductive theorem in the current system.
prove
rem(0, y) == 0

; All subgoals are proved so 
 ; rem(0, y) == 0

;  is an inductive theorem.
; Following equation
;    rem(0, y) == 0  [user, 69]
;    is an inductive theorem in the current system.
prove
(y * div((y + x), y)) == (y * succ(div(x, y)))

; All subgoals are proved so 
 ; (succ(x) < x) == false

;  is an inductive theorem.

; All subgoals are proved so 
 ; (succ(succ((x + y))) < y) == false if 
        { ((x + y) < y),
          (x < y) } 

;  is an inductive theorem.
y

; All subgoals are proved so 
 ; (y * div((x + y), y)) == (y + (y * div(x, y)))

;  is an inductive theorem.
; Following equation
;    (y * div((x + y), y)) == (y * succ(div(x, y)))  [user, 70]
;    is an inductive theorem in the current system.
prove
(rem(x, y) + (y * div(x, y))) == x

; All subgoals are proved so 
 ; ((y * div(x, y)) + rem(x, y)) == x

;  is an inductive theorem.
; Following equation
;    ((y * div(x, y)) + rem(x, y)) == x  [user, 71]
;    is an inductive theorem in the current system.
prove
(y * div(x, y)) == x if divides(y, x)
; Following equation
;    (y * div(x, y)) == x  if  divides(y, x)  [user, 72]
;    is an inductive theorem in the current system.
prove
(x * y) == (y * x)

; All subgoals are proved so 
 ; (0 * x) == 0

;  is an inductive theorem.

; All subgoals are proved so 
 ; (succ(y) * x) == (x + (y * x))

;  is an inductive theorem.

; All subgoals are proved so 
 ; (x * y) == (y * x)

;  is an inductive theorem.
; Following equation
;    (x * y) == (y * x)  [user, 73]
;    is an inductive theorem in the current system.
prove
(x * (y * z)) == ((x * y) * z)

; All subgoals are proved so 
 ; (x * (y * z)) == (z * (x * y))

;  is an inductive theorem.
; Following equation
;    (x * (y * z)) == (z * (x * y))  [user, 74]
;    is an inductive theorem in the current system.
prove
div((x * y), x) == y if not((x = 0))

; All subgoals are proved so 
 ; div((x * y), x) == y if  { (0 = x) <=> false } 

;  is an inductive theorem.
; Following equation
;    div((x * y), x) == y  if  not((x = 0))  [user, 75]
;    is an inductive theorem in the current system.
prove
rem((y * x), x) == 0

; All subgoals are proved so 
 ; rem((x * y), x) == 0

;  is an inductive theorem.
; Following equation
;    rem((x * y), x) == 0  [user, 76]
;    is an inductive theorem in the current system.
prove
rem((y * z), x) == 0 if ((rem(z, x) = 0) and not((x = 0)))
; Following equation
;    rem((y * z), x) == 0  if  not((x = 0)) & (rem(z, x) = 0)  [user, 77]
;    is an inductive theorem in the current system.
prove
rem((x + y), z) == rem(x, z) if (rem(y, z) = 0)

; All subgoals are proved so 
 ; rem((x + (z * z1)), z) == rem(x, z)

;  is an inductive theorem.
; Following equation
;    rem((x + y), z) == rem(x, z)  if  (rem(y, z) = 0)  [user, 78]
;    is an inductive theorem in the current system.
prove
(div(x, y) < x) == true if (not((x = 0)) and (not((y = 0)) and not((y = succ(0)))))
n

; All subgoals are proved so 
 ; (succ(z) < (x + y)) == true if 
        { (0 = y) <=> false,
          (succ(0) = y) <=> false,
          (z < x) } 

;  is an inductive theorem.

; All subgoals are proved so 
 ; (div(x, y) < x) == true if 
        { (0 = x) <=> false,
          (0 = y) <=> false,
          (succ(0) = y) <=> false } 

;  is an inductive theorem.
; Following equation
;    (div(x, y) < x) == true  if  not((x = 0)) & not((y = 0)) & not((y = succ(0)))  [user, 79]
;    is an inductive theorem in the current system.
prove
div((z + y), x) == (div(z, x) + div(y, x)) if (divides(x, z) and not((x = 0)))

; All subgoals are proved so 
 ; div((y + (x * z)), x) == (z + div(y, x)) if  { (0 = x) <=> false } 

;  is an inductive theorem.
1 
; Following equation
;    div((y + z), x) == (div(y, x) + div(z, x))  if  not((x = 0)) & divides(x, z)  [user, 80]
;    is an inductive theorem in the current system.
prove
div((z * y), x) == (y * div(z, x)) if (divides(x, z) and not((x = 0)))
; Following equation
;    div((y * z), x) == (y * div(z, x))  if  not((x = 0)) & divides(x, z)  [user, 81]
;    is an inductive theorem in the current system.
1 
prove
rem(succ(0), x) == succ(0) if not((x = succ(0)))

; All subgoals are proved so 
 ; rem(succ(0), x) == succ(0) if  { (succ(0) = x) <=> false } 

;  is an inductive theorem.
; Following equation
;    rem(succ(0), x) == succ(0)  if  not((x = succ(0)))  [user, 82]
;    is an inductive theorem in the current system.
prove
(sub1(x) < y) == (x < succ(y)) if not((x = 0))

; All subgoals are proved so 
 ; (sub1(x) < y) == (x < succ(y)) if  { (0 = x) <=> false } 

;  is an inductive theorem.
; Following equation
;    (sub1(x) < y) == (x < succ(y))  if  not((x = 0))  [user, 83]
;    is an inductive theorem in the current system.
status
<
lr
prove
gcd(x, y) == gcd(y, x)

; All subgoals are proved so 
 ; gcd(x, y) == gcd(y, x)

;  is an inductive theorem.
; Following equation
;    gcd(x, y) == gcd(y, x)  [user, 84]
;    is an inductive theorem in the current system.
prove
gcd((x * z), (y * z)) == (z * gcd(x, y))

; All subgoals are proved so 
 ; gcd((x * z), (y * z)) == (z * gcd(x, y))

;  is an inductive theorem.
; Following equation
;    gcd((x * z), (y * z)) == (z * gcd(x, y))  [user, 85]
;    is an inductive theorem in the current system.
1 
prove
(gcd((x * y), z) = y) == false if ((rem(z, x) = 0) and not((rem(y, x) = 0)))
; Following equation
;    (gcd(z, (x * y)) = y) == false  if  not((rem(y, x) = 0)) & (rem(z, x) = 0)  [user, 86]
;    is an inductive theorem in the current system.
prove
(rem((y * z), x) = 0) == false if ((gcd((x * y), (y * z)) = y) and (not((y = 0)) and not((rem(y, x) = 0))))
Yes, by switching the body and the premises, the following equation
    (rem((y * z), x) = 0) == false  if  
        { (0 = y) <=> false,
          (rem(y, x) = 0) <=> false,
          (gcd(x, z) = succ(0)) }   [user, 87]
    is an equational theorem.

y
prove
gcd(x, succ(0)) == succ(0) if not((x = 0))

; All subgoals are proved so 
 ; gcd(x, succ(0)) == succ(0) if  { (0 = x) <=> false } 

;  is an inductive theorem.
; Following equation
;    gcd(x, succ(0)) == succ(0)  if  not((x = 0))  [user, 88]
;    is an inductive theorem in the current system.
prove
rem(x, gcd(x, y)) == 0

; All subgoals are proved so 
 ; rem(x, gcd(x, y)) == 0

;  is an inductive theorem.
; Following equation
;    rem(x, gcd(x, y)) == 0  [user, 89]
;    is an inductive theorem in the current system.
prove
(gcd(x, y) = x) == false if not((rem(y, x) = 0))
; Following equation
;    (gcd(x, y) = x) == false  if   { (rem(y, x) = 0) <=> false }   [user, 90]
;    is an equational theorem.

y
write
spec-write
/usr/users/eschbach/specs/arithmetic/arithmetic.impl_1/arithmetic.impl_1.spec
y

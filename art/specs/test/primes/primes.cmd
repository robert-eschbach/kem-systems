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
1 
1 
1 
1 
1 
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
write
spec-write
/usr/users/eschbach/specs/primes/primes.spec
y

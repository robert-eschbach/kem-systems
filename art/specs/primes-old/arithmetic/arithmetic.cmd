option
undo
noundo
add

The arities of the operators are:
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
status
*
rl
makerule
1 
option
prove
e
cover
add

The arities of the operators are:
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
]
makerule
write
spec-write
/usr/users/eschbach/specs/arithmetic/arithmetic.spec
y

add

The arities of the operators are:
      [suc : num -> num ]
      [+ : num, num -> num ]
      [* : num, num -> num ]
      [1 : -> num ]
      [0 : -> num ]
      [2 : -> num ]
      [< : num, num -> bool ]
      [sub1 : num -> num ]
      [- : num, num -> num ]
      [div : num, num -> num ]
      [rem : num, num -> num ]
      [divides : num, num -> bool ]
      [nl : -> list ]
      [cons : univ, list -> list ]
      [append : list, list -> list ]
      [delete : univ, list -> list ]
      [prime1 : num, num -> bool ]
      [prime : num -> bool ]
      [primelist : list -> bool ]
      [timelist : list -> num ]
      [primefac : num -> list ]
      [member : univ, list -> bool ]
      [perm : list, list -> bool ]
      [>= : num, num -> bool ]
      [gcd : num, num -> num ]


1 == suc(0)
2 == suc(suc(0))
(x + 0) == x
(x + suc(y)) == suc((x + y))
(x * 0) == 0
(x * suc(y)) == (x + (x * y))
(0 < suc(x))
(x < 0) == false
(suc(x) < suc(y)) == (x < y)
sub1(0) == 0
sub1(suc(x)) == x
(0 - x) == 0
(x - 0) == x
(suc(x) - suc(y)) == (x - y)
div(x, 0) == 0
div(x, y) == 0 if (x < y)
div((y + x), y) == suc(div(x, y)) if not((0 = y))
rem(x, 0) == x
rem(x, y) == x if (x < y)
rem((y + x), y) == rem(x, y)
divides(x, y) == (rem(y, x) = 0)
append(nl, y) == y
append(cons(x, y), z) == cons(x, append(y, z))
delete(x, nl) == nl
delete(x, cons(x, y)) == y
delete(x, cons(y, z)) == cons(y, delete(x, z)) if not((x = y))
prime1(x, 0) == false
prime1(x, suc(0))
prime1(x, suc(y)) == (not(divides(suc(y), x)) and prime1(x, y)) if not((y = 0))
prime(0) == false
prime(suc(x)) == prime1(suc(x), x)
primelist(nl)
primelist(cons(x, y)) == (prime(x) and primelist(y))
timelist(nl) == suc(0)
timelist(cons(x, y)) == (x * timelist(y))
primefac(0) == nl
primefac(suc(0)) == nl
primefac((x * y)) == append(primefac(x), primefac(y)) if (not((x = 0)) and not((y = 0)))
member(x, nl) == false
member(x, cons(x, z))
member(x, cons(y, z)) == member(x, z) if not((x = y))
perm(nl, nl)
perm(nl, cons(x, y)) == false
perm(cons(x, y), nl) == false
perm(cons(x, y), z) == (member(x, z) and perm(y, delete(x, z)))
(x >= x)
(0 >= suc(y)) == false
(suc(x) >= y) == (x >= y) if not((suc(x) = y))
gcd(x, 0) == x
gcd(0, y) == y
gcd((x + y), y) == gcd(x, y)
gcd(x, (x + y)) == gcd(x, y)
rem(y, y) == 0
rem(suc((y + y1)), y) == rem(suc(y1), y)
div(y, y) == suc(0) if not((0 = y))
]
break

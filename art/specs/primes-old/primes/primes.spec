
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


The system has the following constructors:
     Type 'NAT': { 0, succ }
     Type 'NATLIST': { null, cons }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 
   divides > rem 
   div > * + 
   gcd > * + 
   perm > member delete 
   prime > prime1 rem 
   primelist > prime prime1 rem 
   timelist > * + 
   primefac > append 
   prime1 > rem 

Operators with status are:
   perm with left-to-right status.
   < with left-to-right status.

Associative & commutative operator set = { *, + }

Commutative operator set = { gcd }


(x + 0) ---> x
(x + succ(y)) ---> succ((x + y))
(0 - x) ---> 0
(x - 0) ---> x
(succ(x) - succ(y)) ---> (x - y)
(x * 0) ---> 0
(x * succ(y)) ---> (x + (x * y))
(x < 0) ---> false
(0 < succ(x)) ---> true
(succ(x) < succ(y)) ---> (x < y)
(x >= x) ---> true
(0 >= succ(y)) ---> false
(succ(x) >= y) ---> (x >= y) if  { (succ(x) = y) <=> false } 
div(x, 0) ---> 0
div(x, y) ---> 0 if  { (x < y) } 
div((x + y), y) ---> succ(div(x, y)) if  { (0 = y) <=> false } 
rem(x, 0) ---> x
rem(x, y) ---> x if  { (x < y) } 
rem((x + y), y) ---> rem(x, y)
divides(x, y) ---> (rem(y, x) = 0)
gcd(x, 0) ---> x
gcd(y, (x + y)) ---> gcd(x, y)
sub1(0) ---> 0
sub1(succ(x)) ---> x
append(null, xnl1) ---> xnl1
append(cons(x, xnl1), xnl2) ---> cons(x, append(xnl1, xnl2))
delete(x, null) ---> null
delete(x, cons(x, xnl1)) ---> xnl1
delete(x, cons(y, xnl1)) ---> cons(y, delete(x, xnl1)) if  { (y = x) <=> false } 
member(x, null) ---> false
member(x, cons(x, xnl1)) ---> true
member(x, cons(y, xnl1)) ---> member(x, xnl1) if  { (y = x) <=> false } 
perm(null, null) ---> true
perm(null, cons(x, xnl1)) ---> false
perm(cons(x, xnl1), null) ---> false
perm(cons(x, xnl1), xnl2) ---> (member(x, xnl2) and perm(xnl1, delete(x, xnl2)))
prime(0) ---> false
prime(succ(x)) ---> prime1(succ(x), x)
primelist(null) ---> true
primelist(cons(x, xnl)) ---> (prime(x) and primelist(xnl))
timelist(null) ---> succ(0)
timelist(cons(x, xnl)) ---> (x * timelist(xnl))
primefac(0) ---> null
primefac(succ(0)) ---> null
primefac((x * y)) ---> append(primefac(x), primefac(y)) if 
        { (0 = x) <=> false,
          (0 = y) <=> false } 
prime1(x, 0) ---> false
prime1(x, succ(0)) ---> true
prime1(x, succ(y)) ---> (prime1(x, y) xor ((rem(x, succ(y)) = 0) and prime1(x, y))) if  { (0 = y) <=> false } 
((u * y) < succ(y)) ---> false if 
        { (0 = u) <=> false,
          (succ(0) = u) <=> false,
          (0 = y) <=> false } 
((u + z) < succ(succ(y))) ---> false if 
        { (0 = u) <=> false,
          (z < succ(y)) <=> false } 
((u + x) < succ(y)) ---> false if 
        { ((u + x) < succ(succ(y))) <=> false,
          (x < y) <=> false,
          (0 = u) <=> false } 
((u + x) < succ(y)) ---> false if 
        { (x < succ(y)),
          (x < y) <=> false,
          (0 = u) <=> false } 
(u < succ(succ(0))) ---> false if 
        { (succ(0) = u) <=> false,
          (0 = u) <=> false } 
(u >= z) ---> (true xor (u < z))
(succ(x) < z) ---> (x < z) if  { (succ(x) = z) <=> false } 
(u < u) ---> false
(0 < u) ---> (true xor (0 = u))
((x + z) = succ(0)) ---> false if 
        { (succ(0) = x) <=> false,
          (succ(0) = z) <=> false } 
((x * y) = x) ---> ((0 = x) xor (succ(0) = y) xor ((0 = x) and (succ(0) = y)))
((x * y) = 0) ---> ((0 = x) xor (0 = y) xor ((0 = x) and (0 = y)))
((y + z) = (x + z)) ---> (y = x)
((x + y) = y) ---> (0 = x)
(x < succ(0)) ---> (0 = x)
(y < succ(y)) ---> true
((x * y) = succ(0)) ---> ((succ(0) = x) and (succ(0) = y))
((x + y) = 0) ---> ((0 = x) and (0 = y))
(x * (y + z)) ---> ((x * y) + (x * z))
rem(y, y) ---> 0
rem(succ((x + y)), y) ---> rem(succ(x), y)
div(y, y) ---> succ(0) if  { (0 = y) <=> false } 
gcd(x, succ(0)) ---> succ(0)
(sub1(x) < y) ---> (x < succ(y)) if  { (0 = x) <=> false } 
rem(succ(0), x) ---> succ(0) if  { (succ(0) = x) <=> false } 
(div(x, y) < x) ---> true if 
        { (0 = x) <=> false,
          (succ(0) = y) <=> false } 
(succ(z) < (x + y)) ---> true if 
        { (0 = y) <=> false,
          (z < x) } 
rem((x + (z * z1)), z) ---> rem(x, z)
rem((x * y), x) ---> 0
((y * div(x, y)) + rem(x, y)) ---> x
(y * div((x + y), y)) ---> (y + (y * div(x, y)))
(succ(succ((x + y))) < y) ---> false if 
        { ((x + y) < y),
          (x < y) } 
(succ(x) < x) ---> false
(gcd(x, y) = x) ---> false if  { (rem(y, x) = 0) <=> false } 
rem(x, gcd(x, y)) ---> 0
(rem((y * z), x) = 0) ---> false if 
        { (gcd((x * y), (y * z)) = y),
          (rem(y, x) = 0) <=> false } 
(gcd(z, (x * y)) = y) ---> false if 
        { (rem(z, x) = 0),
          (rem(y, x) = 0) <=> false } 
gcd((x * z), (y * z)) ---> (z * gcd(x, y))
div((y * z), x) ---> (y * div(z, x)) if  { (rem(z, x) = 0) } 
div((y + z), x) ---> (div(y, x) + div(z, x)) if  { (rem(z, x) = 0) } 
rem((x + y), z) ---> rem(x, z) if  { (rem(y, z) = 0) } 
rem((y * z), x) ---> 0 if  { (rem(z, x) = 0) } 
(y * div(x, y)) ---> x if  { (rem(x, y) = 0) } 
rem(0, y) ---> 0
div(0, y) ---> 0
delete(x, xnl1) ---> xnl1 if  { member(x, xnl1) <=> false } 

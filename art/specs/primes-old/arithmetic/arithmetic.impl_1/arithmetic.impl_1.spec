
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


The system has the following constructors:
     Type 'NAT': { 0, succ }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 
   divides > rem 
   div > + * 
   gcd > * + 

Operators with status are:
   < with left-to-right status.
   * with right-to-left status.

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
((y + z) = (x + z)) ---> (y = x)
((x + y) = y) ---> (0 = x)
(x < succ(0)) ---> (0 = x)
(y < succ(y)) ---> true
((x + y) = 0) ---> ((0 = x) and (0 = y))
rem(y, y) ---> 0
rem(succ((x + y)), y) ---> rem(succ(x), y)
div(y, y) ---> succ(0) if  { (0 = y) <=> false } 
div(0, y) ---> 0
rem(0, y) ---> 0
(succ(x) < x) ---> false
(succ(succ((x + y))) < y) ---> false if 
        { ((x + y) < y),
          (x < y) } 
((u * y) < succ(y)) ---> false if 
        { (0 = u) <=> false,
          (succ(0) = u) <=> false,
          (0 = y) <=> false } 
((x * y) = x) ---> ((0 = x) xor (succ(0) = y) xor ((0 = x) and (succ(0) = y)))
((x * y) = 0) ---> ((0 = x) xor (0 = y) xor ((0 = x) and (0 = y)))
((x * y) = succ(0)) ---> ((succ(0) = x) and (succ(0) = y))
(x * (y + z)) ---> ((x * y) + (x * z))
(y * div((x + y), y)) ---> (y + (y * div(x, y)))
((y * div(x, y)) + rem(x, y)) ---> x
(y * div(x, y)) ---> x if  { (rem(x, y) = 0) } 
rem((x * y), x) ---> 0
rem((y * z), x) ---> 0 if  { (rem(z, x) = 0) } 
rem((x + (z * z1)), z) ---> rem(x, z)
rem((x + y), z) ---> rem(x, z) if  { (rem(y, z) = 0) } 
(succ(z) < (x + y)) ---> true if 
        { (0 = y) <=> false,
          (z < x) } 
(div(x, y) < x) ---> true if 
        { (0 = x) <=> false,
          (succ(0) = y) <=> false } 
div((y + z), x) ---> (div(y, x) + div(z, x)) if  { (rem(z, x) = 0) } 
div((y * z), x) ---> (y * div(z, x)) if  { (rem(z, x) = 0) } 
rem(succ(0), x) ---> succ(0) if  { (succ(0) = x) <=> false } 
(sub1(x) < y) ---> (x < succ(y)) if  { (0 = x) <=> false } 
gcd((x * z), (y * z)) ---> (z * gcd(x, y))
(gcd(z, (x * y)) = y) ---> false if 
        { (rem(y, x) = 0) <=> false,
          (rem(z, x) = 0) } 
(rem((y * z), x) = 0) ---> false if 
        { (rem(y, x) = 0) <=> false,
          (gcd(x, z) = succ(0)) } 
gcd(x, succ(0)) ---> succ(0)
rem(x, gcd(x, y)) ---> 0
(gcd(x, y) = x) ---> false if  { (rem(y, x) = 0) <=> false } 

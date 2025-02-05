
The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [0 : -> NAT ]


The system has the following constructors:
     Type 'NAT': { 0, succ }

There are no equivalent operators.

Precedence relation now is: 
   * > + 
   >= > < 

Operators with status are:
   * with right-to-left status.

Associative & commutative operator set = { + }


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
((un * yn) < succ(yn)) ---> false if 
        { (0 = un) <=> false,
          (succ(0) = un) <=> false,
          (0 = yn) <=> false } 
((un + zn) < succ(succ(yn))) ---> false if 
        { (0 = un) <=> false,
          (zn < succ(yn)) <=> false } 
((un + xn) < succ(yn)) ---> false if 
        { ((un + xn) < succ(succ(yn))) <=> false,
          (xn < yn) <=> false,
          (0 = un) <=> false } 
((un + xn) < succ(yn)) ---> false if 
        { (xn < succ(yn)),
          (xn < yn) <=> false,
          (0 = un) <=> false } 
(un < succ(succ(0))) ---> false if 
        { (succ(0) = un) <=> false,
          (0 = un) <=> false } 
(un >= zn) ---> (true xor (un < zn))
(succ(xn) < zn) ---> (xn < zn) if  { (succ(xn) = zn) <=> false } 
(un < un) ---> false
(0 < un) ---> (true xor (0 = un))
((xn + zn) = succ(0)) ---> false if 
        { (succ(0) = xn) <=> false,
          (succ(0) = zn) <=> false } 
((xn * yn) = xn) ---> ((0 = xn) xor (succ(0) = yn) xor ((0 = xn) and (succ(0) = yn)))
((xn * yn) = 0) ---> ((0 = xn) xor (0 = yn) xor ((0 = xn) and (0 = yn)))
((yn + zn) = (xn + zn)) ---> (yn = xn)
((xn + yn) = yn) ---> (0 = xn)
(xn < succ(0)) ---> (0 = xn)
(yn < succ(yn)) ---> true
((xn * yn) = succ(0)) ---> ((succ(0) = xn) and (succ(0) = yn))
((xn + yn) = 0) ---> ((0 = xn) and (0 = yn))
(xn * (yn + zn)) ---> ((xn * yn) + (xn * zn))

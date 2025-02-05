
The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [^= : NAT, NAT -> bool ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [if.n : bool, NAT, NAT -> NAT ]
      [0 : -> NAT ]


The system has the following constructors:
     Type 'NAT': { 0, succ }

There are no equivalent operators.

Precedence relation now is: 
   * > + 

There are no operators with status.


(x + 0) ---> x
(x + succ(y)) ---> succ((x + y))
(0 - x) ---> 0
(x - 0) ---> x
(succ(x) - succ(y)) ---> (x - y)
(x * 0) ---> 0
(x * succ(y)) ---> (x + (x * y))
(0 ^= 0) ---> true
(0 ^= succ(x)) ---> false
(succ(x) ^= 0) ---> false
(succ(x) ^= succ(y)) ---> (x ^= y)
(x < 0) ---> false
(0 < succ(x)) ---> true
(succ(x) < succ(y)) ---> (x < y)
(x >= x) ---> true
(0 >= succ(y)) ---> false
(succ(x) >= y) ---> (x >= y) if  { (succ(x) ^= y) <=> false } 
if.n(true, x, y) ---> x
if.n(false, x, y) ---> y
if.n(xb, succ(x), succ(y)) ---> succ(if.n(xb, x, y))


The arities of the operators are:
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [0 : -> NAT ]


The system has the following constructors:
     Type 'NAT': { 0, succ }

There are no equivalent operators.

Precedence relation now is: 
   * > + 

Operators with status are:
   * with left-to-right status.

Associative & commutative operator set = { + }


(x + 0) ---> x
(x + succ(y)) ---> succ((x + y))
(x * 0) ---> 0
(x * succ(y)) ---> (x + (x * y))
(x * (y + z)) ---> ((x * y) + (x * z))
((x * y) * z) ---> (x * (y * z))

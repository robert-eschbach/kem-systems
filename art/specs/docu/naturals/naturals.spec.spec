
The arities of the operators are:
      [SUCC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [0 : -> NAT ]



There are no equivalent operators.

Precedence relation now is: 
   * > + 

Operators with status are:
   * with left-to-right status.

Associative & commutative operator set = { + }

The arities of the operators are:
      [SUCC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [0 : -> NAT ]



(X + 0) ---> X
(X + SUCC(Y)) ---> SUCC((X + Y))
(X * 0) ---> 0
(X * SUCC(Y)) ---> (X + (X * Y))
((X * Y) * Z) ---> (X * (Y * Z))
(X * (Y + Z)) ---> ((X * Y) + (X * Z))

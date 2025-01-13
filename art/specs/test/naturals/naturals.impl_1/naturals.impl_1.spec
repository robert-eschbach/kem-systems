
The arities of the operators are:
      [SUCC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
      [0 : -> NAT ]



The system has the following constructors:
     Type 'NAT': { 0, SUCC }

There are no equivalent operators.

Precedence relation now is: 
   * > + 

There are no operators with status.

The arities of the operators are:
      [SUCC : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> BOOL ]
      [>= : NAT, NAT -> BOOL ]
      [0 : -> NAT ]



(X + 0) ---> X
(X + SUCC(Y)) ---> SUCC((X + Y))
(0 - X) ---> 0
(X - 0) ---> X
(SUCC(X) - SUCC(Y)) ---> (X - Y)
(X * 0) ---> 0
(X * SUCC(Y)) ---> (X + (X * Y))
(X < 0) ---> FALSE
(0 < SUCC(X)) ---> TRUE
(SUCC(X) < SUCC(Y)) ---> (X < Y)
(X >= X) ---> TRUE
(0 >= SUCC(Y)) ---> FALSE
(SUCC(X) >= Y) ---> (X >= Y) if  { not((SUCC(X) = Y)) } 

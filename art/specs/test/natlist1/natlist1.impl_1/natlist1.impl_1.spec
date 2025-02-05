
The arities of the operators are:
      [0 : -> NAT ]
      [SUCC : NAT -> NAT ]
      [NULL : -> NATLIST ]
      [CONS : NAT, NATLIST -> NATLIST ]
      [APPEND : NATLIST, NATLIST -> NATLIST ]
      [DELETE : NAT, NATLIST -> NATLIST ]
      [MEMBER : NAT, NATLIST -> BOOL ]
      [PERM : NATLIST, NATLIST -> BOOL ]



The system has the following constructors:
     Type 'NAT': { 0, SUCC }
     Type 'NATLIST': { NULL, CONS }

There are no equivalent operators.

Precedence relation now is: 
   PERM > MEMBER DELETE 

Operators with status are:
   PERM with left-to-right status.

The arities of the operators are:
      [0 : -> NAT ]
      [SUCC : NAT -> NAT ]
      [NULL : -> NATLIST ]
      [CONS : NAT, NATLIST -> NATLIST ]
      [APPEND : NATLIST, NATLIST -> NATLIST ]
      [DELETE : NAT, NATLIST -> NATLIST ]
      [MEMBER : NAT, NATLIST -> BOOL ]
      [PERM : NATLIST, NATLIST -> BOOL ]



APPEND(NULL, XNL1) ---> XNL1
APPEND(CONS(X, XNL1), XNL2) ---> CONS(X, APPEND(XNL1, XNL2))
DELETE(X, NULL) ---> NULL
DELETE(X, CONS(X, XNL1)) ---> XNL1
DELETE(X, CONS(Y, XNL1)) ---> CONS(Y, DELETE(X, XNL1)) if  { not((Y = X)) } 
MEMBER(X, NULL) ---> FALSE
MEMBER(X, CONS(X, XNL1)) ---> TRUE
MEMBER(X, CONS(Y, XNL1)) ---> MEMBER(X, XNL1) if  { not((Y = X)) } 
PERM(NULL, NULL) ---> TRUE
PERM(NULL, CONS(X, XNL1)) ---> FALSE
PERM(CONS(X, XNL1), XNL2) ---> (MEMBER(X, XNL2) AND PERM(XNL1, DELETE(X, XNL2)))
DELETE(X, XNL1) ---> XNL1 if  { not(MEMBER(X, XNL1)) } 

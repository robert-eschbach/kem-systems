
The arities of the operators are:
      [0 : -> NAT ]
      [succ : NAT -> NAT ]
      [null : -> NATLIST ]
      [cons : NAT, NATLIST -> NATLIST ]
      [append : NATLIST, NATLIST -> NATLIST ]
      [delete : NAT, NATLIST -> NATLIST ]
      [member : NAT, NATLIST -> bool ]
      [perm : NATLIST, NATLIST -> bool ]


The system has the following constructors:
     Type 'NAT': { 0, succ }
     Type 'NATLIST': { null, cons }

There are no equivalent operators.

Precedence relation now is: 
   perm > member delete 

Operators with status are:
   perm with left-to-right status.


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
perm(cons(x, xnl1), xnl2) ---> (member(x, xnl1) and perm(xnl1, delete(x, xnl2)))
delete(x, xnl1) ---> xnl1 if  { member(x, xnl1) <=> false } 

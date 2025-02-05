
The arities of the operators are:
      [null : -> NATLIST ]
      [cons : NAT, NATLIST -> NATLIST ]
      [append : NATLIST, NATLIST -> NATLIST ]
      [delete : NAT, NATLIST -> NATLIST ]
      [member : NAT, NATLIST -> bool ]
      [perm : NATLIST, NATLIST -> bool ]
      [succ : NAT -> NAT ]
      [+ : NAT, NAT -> NAT ]
      [* : NAT, NAT -> NAT ]
      [- : NAT, NAT -> NAT ]
      [< : NAT, NAT -> bool ]
      [>= : NAT, NAT -> bool ]
      [rev : NATLIST -> NATLIST ]
      [rev2 : NATLIST -> NATLIST ]
      [length : NATLIST -> NAT ]
      [pair : NATLIST, NATLIST -> LISTPAIR ]
      [right : LISTPAIR -> NATLIST ]
      [left : LISTPAIR -> NATLIST ]
      [n_elem : NAT, NATLIST, NATLIST -> LISTPAIR ]
      [is_equal_set : NATLIST, NATLIST -> bool ]
      [is_equal_multiset : NATLIST, NATLIST -> bool ]
      [is_element : NAT, NATLIST -> bool ]
      [is_subset : NATLIST, NATLIST -> bool ]
      [0 : -> NAT ]
      [2 : -> NAT ]


The system has the following constructors:
     Type 'NATLIST': { null, cons }
     Type 'NAT': { 0, succ }

There are no equivalent operators.

Precedence relation now is: 
   perm > member delete 
   * > + 
   rev > append 
   is_subset > member 
   is_equal_set > is_subset member 
   n_elem > pair append 
   is_equal_multiset > delete 

Operators with status are:
   is_equal_multiset with left-to-right status.
   n_elem with left-to-right status.
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
perm(cons(x, xnl1), xnl2) ---> (member(x, xnl2) and perm(xnl1, delete(x, xnl2)))
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
left(pair(u, v)) ---> u
right(pair(u, v)) ---> v
2 ---> succ(succ(0))
rev(null) ---> null
rev(cons(x, u)) ---> append(rev(u), cons(x, null))
length(null) ---> 0
length(cons(x, u)) ---> succ(length(u))
n_elem(0, u, v) ---> pair(u, v)
n_elem(succ(x), u, null) ---> pair(u, null)
n_elem(succ(x), u, cons(y, v)) ---> n_elem(x, append(u, cons(y, null)), v)
is_element(x, null) ---> false
is_element(x, cons(y, u)) ---> ((y = x) xor is_element(x, u) xor ((y = x) and is_element(x, u)))
is_subset(null, u) ---> true
is_subset(cons(x, u), v) ---> (is_subset(u, v) and member(x, v))
is_equal_set(u, v) ---> (is_subset(u, v) and is_subset(v, u))
is_equal_multiset(null, null) ---> true
is_equal_multiset(null, cons(x, u)) ---> false
is_equal_multiset(cons(x, u), v) ---> is_equal_multiset(u, delete(x, v)) if  { is_element(x, v) } 
is_equal_multiset(cons(x, u), v) ---> false if  { is_element(x, v) <=> false } 
member(x, cons(y, u)) ---> true if  { member(x, u) } 
rev(append(z, cons(x, null))) ---> cons(x, rev(z))
rev(rev(u)) ---> u
member(x, append(u, v)) ---> true if  { member(x, u) } 
is_subset(u, append(z, cons(x, null))) ---> true if  { is_subset(u, z) } 
member(x, append(z, cons(x, null))) ---> true
(is_subset(u, append(rev(u), cons(x, null))) and member(x, append(rev(u), cons(x, null)))) ---> true if  { is_subset(u, rev(u)) } 
is_subset(v, rev(v)) ---> true
is_subset(append(z, cons(x, null)), cons(x, u)) ---> true if  { is_subset(z, u) } 
is_subset(rev(v), v) ---> true

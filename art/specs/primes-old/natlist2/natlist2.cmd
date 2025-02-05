option
undo
noundo
add

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


append(null, xnl1) == xnl1
append(cons(x, xnl1), xnl2) == cons(x, append(xnl1, xnl2))
delete(x, null) == null
delete(x, cons(x, xnl1)) == xnl1
delete(x, cons(y, xnl1)) == cons(y, delete(x, xnl1)) if not((y = x))
member(x, null) == false
member(x, cons(x, xnl1))
member(x, cons(y, xnl1)) == member(x, xnl1) if not((x = y))
perm(null, null)
perm(null, cons(x, xnl1)) == false
perm(cons(x, xnl1), null) == false
perm(cons(x, xnl1), xnl2) == (member(x, xnl2) and perm(xnl1, delete(x, xnl2)))
(x + 0) == x
(x + succ(y)) == succ((x + y))
(0 - x) == 0
(x - 0) == x
(succ(x) - succ(y)) == (x - y)
(x * 0) == 0
(x * succ(y)) == (x + (x * y))
(x < 0) == false
(0 < succ(x))
(succ(x) < succ(y)) == (x < y)
(x >= x)
(0 >= succ(y)) == false
(succ(x) >= y) == (x >= y) if not((succ(x) = y))
left(pair(u, v)) == u
right(pair(u, v)) == v
2 == succ(succ(0))
rev(null) == null
rev(cons(x, u)) == append(rev(u), cons(x, null))
length(null) == 0
length(cons(x, u)) == succ(length(u))
n_elem(0, u, v) == pair(u, v)
n_elem(succ(x), u, null) == pair(u, null)
n_elem(succ(x), u, cons(y, v)) == n_elem(x, append(u, cons(y, null)), v)
is_element(x, null) == false
is_element(x, cons(y, u)) == ((x = y) or is_element(x, u))
is_subset(null, u)
is_subset(cons(x, u), v) == (member(x, v) and is_subset(u, v))
is_equal_set(u, v) == (is_subset(u, v) and is_subset(v, u))
is_equal_multiset(null, null)
is_equal_multiset(null, cons(x, u)) == false
is_equal_multiset(cons(x, u), v) == is_equal_multiset(u, delete(x, v)) if is_element(x, v)
is_equal_multiset(cons(x, u), v) == false if not(is_element(x, v))
]
operator
constructor
null 
operator
constructor
cons 
yes
operator
constructor
0 
operator
constructor
succ 
yes
operator
order
l
operator
precedence
perm member 
operator
precedence
perm delete 
operator
precedence
* + 
operator
precedence
rev append 
operator
precedence
is_subset member 
operator
precedence
is_equal_set is_subset 
operator
status
perm
lr
operator
status
n_elem
lr
operator
status
is_equal_multiset
lr
makerule
1 
1 
1 
option
prove
e
cover
add

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


member(x, cons(y, u)) == true if member(x, u)
]
makerule
prove
rev(rev(u)) == u

; All subgoals are proved so 
 ; rev(append(z, cons(x, null))) == cons(x, rev(z))

;  is an inductive theorem.

; All subgoals are proved so 
 ; rev(rev(u)) == u

;  is an inductive theorem.
; Following equation
;    rev(rev(u)) == u  [user, 46]
;    is an inductive theorem in the current system.
prove
member(x, append(u, v)) == true if member(x, u)

; All subgoals are proved so 
 ; member(x, append(u, v)) == true if  { member(x, u) } 

;  is an inductive theorem.
; Following equation
;    member(x, append(u, v)) == true  if  member(x, u)  [user, 47]
;    is an inductive theorem in the current system.
prove
member(x, append(u, v)) == true if member(x, u)
Yes, it is equational theorem.
prove
member(x, cons(y, u)) == true if member(x, u)
Yes, it is equational theorem.
prove
is_subset(cons(x, u), rev(cons(x, u))) == true if is_subset(u, rev(u))
n

; All subgoals are proved so 
 ; is_subset(u, append(z, cons(x, null))) == true if  { is_subset(u, z) } 

;  is an inductive theorem.
n

; All subgoals are proved so 
 ; member(x, append(z, cons(x, null)))

;  is an inductive theorem.

; All subgoals are proved so 
 ; member(x, append(z, cons(x, null))) == true if  { is_subset(u, z) } 

;  is an inductive theorem.
; Following equation
;    is_subset(cons(x, u), rev(cons(x, u))) == true  if  is_subset(u, rev(u))  [user, 50]
;    is an inductive theorem in the current system.
prove
is_subset(u, rev(v)) == true if (u = v)
n

; All subgoals are proved so 
 ; is_subset(v, rev(v))

;  is an inductive theorem.
; Following equation
;    is_subset(u, rev(v)) == true  if  (u = v)  [user, 51]
;    is an inductive theorem in the current system.
prove
is_subset(rev(v), u) == true if (u = v)
n

; All subgoals are proved so 
 ; is_subset(append(z, cons(x, null)), cons(x, u)) == true if  { is_subset(z, u) } 

;  is an inductive theorem.

; All subgoals are proved so 
 ; is_subset(rev(v), v)

;  is an inductive theorem.
; Following equation
;    is_subset(rev(v), u) == true  if  (u = v)  [user, 52]
;    is an inductive theorem in the current system.
prove
is_equal_set(u, rev(u))
Yes, it is equational theorem.
write
spec-write
/usr/users/eschbach/specs/natlist2/natlist2.spec
y

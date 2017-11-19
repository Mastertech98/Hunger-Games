valid(A,B) :- !, A >= 1, A =< 20, B >= 1, B =< 20.

get_newPositon(Direction, A, B, C, D) :- Direction == n, !, C is A-1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == s, !, C is A+1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == e, !, C is A, D is B+1.
get_newPositon(Direction, A, B, C, D) :- Direction == w, !, C is A, D is B-1.

go(Direction) :- currentPosition(A,B),
                 get_newPositon(Direction,A,B,C,D),
                 valid(C,D),
                 retract(currentPosition(_,_)),
                 asserta(currentPosition(C,D)),!.

go(_) :- write('Tidak bisa kesana gan'), nl.

n :- go(n).
s :- go(s).
w :- go(w).
e :- go(e).
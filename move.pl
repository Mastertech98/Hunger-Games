%% valid(A,B) :- !, A >= 1, A =< 20, B >= 1, B =< 20.

get_newPositon(Direction, A, B, C, D) :- Direction == n, !, C is A-1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == s, !, C is A+1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == e, !, C is A, D is B+1.
get_newPositon(Direction, A, B, C, D) :- Direction == w, !, C is A, D is B-1.

go(Direction) :- current_position(A,B),
                 get_newPositon(Direction,A,B,C,D),
                 valid(C,D),
                 retract(current_position(_,_)),
                 asserta(current_position(C,D)),!.

go(_) :- write('Can not move there'), nl.

n :- go(n), print_current_grid_situation, print_current_grid_neighbours.
s :- go(s), print_current_grid_situation, print_current_grid_neighbours.
w :- go(w), print_current_grid_situation, print_current_grid_neighbours.
e :- go(e), print_current_grid_situation, print_current_grid_neighbours.
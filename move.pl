%% valid(A,B) :- !, A >= 1, A =< 20, B >= 1, B =< 20.

get_newPositon(Direction, A, B, C, D) :- Direction == n, !, C is A-1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == s, !, C is A+1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == e, !, C is A, D is B+1.
get_newPositon(Direction, A, B, C, D) :- Direction == w, !, C is A, D is B-1.

go(Direction) :- current_position(A,B),
                 get_newPositon(Direction,A,B,C,D),
                 valid(C,D),
                 retract(current_position(_,_)),
                 asserta(current_position(C,D)),
                 move_detail, move_cost, check_game_state, !.

go(_) :- write('Can not move there'), nl.

move_detail :- print_current_grid_situation, print_current_grid_neighbours.
move_cost :- decrease_hunger(1), decrease_thirst(1).
%% check_game_state :- check_game_over, check_win.

n :- go(n), !.
s :- go(s), !.
w :- go(w), !.
e :- go(e), !.
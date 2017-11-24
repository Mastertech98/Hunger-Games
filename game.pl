is_game_over :- get_health(X), X =< 0, !.
is_game_over :- get_hunger(X), X =< 0, !.
is_game_over :- get_thirst(X), X =< 0, !.

is_win :- findall(X,enemy_at(_,_,_,X),L), length(L,A), !, A == 0, !.

check_game_over :- is_game_over, !, write('You can not finish your mission ,let your soul be at peace:(('), nl, halt, !.
check_game_over :- !.

check_win :- is_win, !, write('You defeat all enemy . Glorious triumph await for you :))'), nl, halt, !.
check_win :- !.

check_game_state :- check_game_over, check_win.
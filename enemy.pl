:- dynamic(enemy_at/4).

number_of_enemies(10).

%% enemy_at(1, 1, 12, 12).
%% enemy_at(1, 1, 12, 12).
%% enemy_at(1, 1, 12, 12).

seede :- asserta(enemy_at(1, 1, 12, 12)), asserta(enemy_at(1, 1, 12, 12)), asserta(enemy_at(1, 1, 12, 12)).

generate_random_enemies(0) :- !.
generate_random_enemies(X) :- random(1, 10, Row), random(1, 20, Col), random(30, 100, Power),
	                          asserta(enemy_at(Row,Col,Power,X)),
	                          NextX is X-1,
	                          generate_random_enemies(NextX), !.

init_enemy :- number_of_enemies(X), generate_random_enemies(X).

movv(X, N) :- N == 1, !, enemy_at(Row, Col, _, X), NewRow is Row+1, write('1 - '), write(Row), write(' '), write(Col), write(' to '), write(NewRow), write(' '), write(Col), nl, update_enemy_position(NewRow, Col, X).
movv(X, N) :- N == 2, !, enemy_at(Row, Col, _, X), NewRow is Row-1, write('2 - '), write(Row), write(' '), write(Col), write(' to '), write(NewRow), write(' '), write(Col), nl, update_enemy_position(NewRow, Col, X).
movv(X, N) :- N == 3, !, enemy_at(Row, Col, _, X), NewCol is Col+1, write('3 - '), write(Row), write(' '), write(Col), write(' to '), write(Row), write(' '), write(NewCol), nl,update_enemy_position(Row, NewCol, X).
movv(X, N) :- N == 4, !, enemy_at(Row, Col, _, X), NewCol is Col-1, write('4 - '), write(Row), write(' '), write(Col), write(' to '), write(Row), write(' '), write(NewCol), nl,update_enemy_position(Row, NewCol, X).

move_enemy(0) :- !.
move_enemy(X) :- random(1,4,N), movv(X, N), NextX is X-1, move_enemy(NextX).

update_enemy_position(Row, Col, X) :- enemy_at(_, _, Power, X), !,
                                    retract(enemy_at(_, _, _, X)),
                                    asserta(enemy_at(Row, Col, Power, X)).

% Call this command to automatically move all enemy in random direction
% TODO : validate enemy movement so that they will never: collide, reach gate ('#')
% TODO : when will enemy attack player? decide and implement
random_move_all_enemies :- number_of_enemies(X), move_enemy(X).
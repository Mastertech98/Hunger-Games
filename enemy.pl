:- dynamic(enemy_at/4).

number_of_enemies(10).

%% enemy_at(1, 1, 12, 12).
%% enemy_at(1, 1, 12, 12).
%% enemy_at(1, 1, 12, 12).

generate_random_enemies(0) :- !.
generate_random_enemies(X) :- random(1, 10, Row), random(1, 20, Col), random(5, 20, Power),
	                          asserta(enemy_at(Row,Col,Power,X)),
	                          NextX is X-1,
	                          generate_random_enemies(NextX), !.

init_enemy :- number_of_enemies(X), generate_random_enemies(X).

movv(X, N) :- N == 1, !, enemy_at(Row, Col, _, X), current_position(A,B), (Row \== A;Col \== B), !, NewRow is Row+1, valid(NewRow, Col), update_enemy_position(NewRow, Col, X).
movv(X, N) :- N == 2, !, enemy_at(Row, Col, _, X), current_position(A,B), (Row \== A;Col \== B), !, NewRow is Row-1, valid(NewRow, Col), update_enemy_position(NewRow, Col, X).
movv(X, N) :- N == 3, !, enemy_at(Row, Col, _, X), current_position(A,B), (Row \== A;Col \== B), !, NewCol is Col+1, valid(Row, NewCol), update_enemy_position(Row, NewCol, X).
movv(X, N) :- N == 4, !, enemy_at(Row, Col, _, X), current_position(A,B), (Row \== A;Col \== B), !, NewCol is Col-1, valid(Row, NewCol), update_enemy_position(Row, NewCol, X).

move_enemy([]) :- !.
move_enemy([A|B]) :- random(1,4,N), movv(A, N), move_enemy(B).

update_enemy_position(Row, Col, X) :- enemy_at(_, _, Power, X), !,
                                    retract(enemy_at(_, _, _, X)),
                                    asserta(enemy_at(Row, Col, Power, X)).

% Call this command to automatically move all enemy in random direction
% TODO : validate enemy movement so that they will never: collide, reach gate ('#')
% TODO : when will enemy attack player? decide and implement

get_all_alive_enemy_id(L) :- findall(X, enemy_at(_,_,_,X), L).

random_move_all_enemies :- get_all_alive_enemy_id(X), move_enemy(X).
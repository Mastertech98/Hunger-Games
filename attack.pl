%% kurang2an health
get_damage(D, []) :- D, !.
get_damage(D, [H|T]) :- Tot is D+H, get_damage(Tot, T), !.

get_all_nearby_damage(L) :- current_position(X,Y), findall(A,enemy_at(X,Y,A,_), L).

get_total_damage(Damage) :- get_all_nearby_damage(L), sum_list(L, Damage).

calculate_damage(X) :- get_total_damage(X), decrease_health(X).

%% mati2in enemy
get_all_nearby_enemy_length(Length) :- current_position(X,Y), findall(A,enemy_at(X,Y,_,A), L), length(L, Length).

kill_all_enemies(Length) :- current_position(X,Y),
							get_all_nearby_enemy_length(Length),
							retractall(enemy_at(X,Y,_,_)).

is_enemy_nearby :- current_position(X,Y), enemy_at(X,Y,_,_), !.
is_enemy_nearby :- write('Theres no enemy nearby...'), fail.

has_weapon :- get_weapon(Weapon), Weapon \== none, !.
has_weapon :- write('You got no weapon tho'), nl, fail.

take_damage :- calculate_damage(X), X \== 0, !, write('You took '), write(X), write(' damage...'),check_game_state.
take_damage :- !.

attack :- is_enemy_nearby,
		  has_weapon,
		  !,
		  write('attacking enemy nearby '), nl,
		  take_damage, !, nl, kill_all_enemies(R),
		  write('You kill '), write(R), write(' enemy'), nl,
		  random_move_all_enemies,
		  check_game_over, check_win.
attack :- take_damage, !.



%% ATTACK SCRIPT
seed_enemy :- asserta(enemy_at(1, 1, 12, 12)), asserta(enemy_at(1, 1, 12, 12)), asserta(enemy_at(1, 1, 12, 12)).



qq :- seed_enemy, set_weapon(axe).
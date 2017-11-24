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

attack :- is_enemy_nearby,
		  has_weapon,
		  write('attacking enemy nearby '), nl,
		  calculate_damage(X), kill_all_enemies(R),
		  write('You kill '), write(R), write(' enemy'), nl,
		  write('But unfortunately , your HP decrease '), write(X), write(' :('), nl, !,
		  check_game_over, check_win.
attack :- write('no enemy nearby...'), nl.
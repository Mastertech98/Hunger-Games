:- include('map.pl').
:- include('enemy.pl').
:- include('move.pl').
:- include('player.pl').
:- include('attack.pl').
:- include('game.pl').

start :- initGame.

z :- start, seede.

initGame :- init_map, init_enemy, init_player, generate_random_obj, print_map.

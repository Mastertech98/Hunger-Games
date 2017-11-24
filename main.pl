:- include('map.pl').
:- include('enemy.pl').
:- include('move.pl').

start :- initGame.


initGame :- init_map, init_enemy, print_map.

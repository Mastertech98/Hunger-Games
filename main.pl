:- include('map.pl').
:- include('enemy.pl').

start :- initGame.


initGame :- init_map, init_enemy, printMap.

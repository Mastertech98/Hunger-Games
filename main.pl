:- include('map.pl').
:- include('enemy.pl').

start :- initGame.


initGame :- initMap, initEnemy, printMap.

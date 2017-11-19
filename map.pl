/*
    All logic regarding map will be put here
 */

:- dynamic(mapAt/3).
:- dynamic(currentPosition/2).

currentPosition(1,1).

valid(A,B) :- !, A >= 1, A =< 20, B >= 1, B =< 20.

% MAP INITIALIZATION - START
makeMapFromList(_, _, []) :- !.
makeMapFromList(Row, Col, [H|T]) :- asserta(mapAt(Row,Col,H)), NextCol is Col+1, makeMapFromList(Row,NextCol,T), !.

makeMapRow0  :- makeMapFromList(0,0,  ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']).
makeMapRow1  :- makeMapFromList(1,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow2  :- makeMapFromList(2,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow3  :- makeMapFromList(3,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow4  :- makeMapFromList(4,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow5  :- makeMapFromList(5,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow6  :- makeMapFromList(6,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow7  :- makeMapFromList(7,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow8  :- makeMapFromList(8,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow9  :- makeMapFromList(9,0,  ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow10 :- makeMapFromList(10,0, ['#', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', 'B', 'A', '#']).
makeMapRow11 :- makeMapFromList(11,0, ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']).

initMap :- makeMapRow0,
           makeMapRow1,
           makeMapRow2,
           makeMapRow3,
           makeMapRow4,
           makeMapRow5,
           makeMapRow6,
           makeMapRow7,
           makeMapRow8,
           makeMapRow9,
           makeMapRow10,
           makeMapRow11.
% MAP INITIALIZATION - END

% MAP PRINT - START
printMapInner(11,22) :- !.
printMapInner(X,22) :- !, nl, Xi is X+1, printMapInner(Xi,0).
printMapInner(X,Y) :- write(' '), printGrid(X,Y), write(' '), Yi is Y+1, printMapInner(X,Yi).
printMap :- printMapInner(0,0).

printGrid(Row,Col) :- currentPosition(Row,Col), !, write('P').
printGrid(Row,Col) :- enemyAt(Row,Col,_), !, write('E').
printGrid(Row,Col) :- mapAt(Row,Col,X), X == '#', !, write('#').
printGrid(Row,Col) :- mapAt(Row,Col,X), X == 'A', !, write('H').
printGrid(Row,Col) :- mapAt(Row,Col,X), X == 'B', !, write('L').
printGrid(_,_) :- !, write('?').
% MAP PRINT - END

% MAP LOOK - Still unfinished (masih blom kepikiran)
look :- currentPosition(X,Y), !,
        Xi is X-1, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X-1, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X-1, Yi is Y+1, printGrid(Xi,Yi), write(' '), nl,
        Xi is X+1, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X+1, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X+1, Yi is Y+1, printGrid(Xi,Yi), write(' '), nl,
        Xi is X, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X, Yi is Y+1, printGrid(Xi,Yi), write(' '), nl.
% MAP LOOK - END
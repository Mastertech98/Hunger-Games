:- dynamic(mapAt/3)

printItemAtLocation(X,Y) :- location(A,X,Y), write(A), write(' ').

makeMapFromList(_, _, []) :- !.
makeMapFromList(Row, Col, [H|T]) :- asserta(mapAt(Row,Col,H)), NextCol is Col+1, makeMapFromList(Row,NextCol,T), !.

makeMapRow0(Row, Col) :- makeMapFromList(0,0, []).
makeMapRow1(Row, Col) :- makeMapFromList(1,0, []).
makeMapRow2(Row, Col) :- makeMapFromList(2,0, []).
makeMapRow3(Row, Col) :- makeMapFromList(3,0, []).
makeMapRow4(Row, Col) :- makeMapFromList(4,0, []).
makeMapRow5(Row, Col) :- makeMapFromList(5,0, []).
makeMapRow6(Row, Col) :- makeMapFromList(6,0, []).
makeMapRow7(Row, Col) :- makeMapFromList(7,0, []).
makeMapRow8(Row, Col) :- makeMapFromList(8,0, []).
makeMapRow9(Row, Col) :- makeMapFromList(9,0, []).

% initialize map location (currently hardcoded)
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

printMap(11,21) :- !.
printMap(X,21) :- !, nl, Xi is X+1, printMap(Xi,0).
printMap(X,Y) :- write(' '), printGrid(X,Y), write(' '), Yi is Y+1, printMap(X,Yi).

printGrid(X,Y) :- not(valid(X,Y)), !, write('#').
printGrid(X,Y) :- currentPosition(X,Y), !, write('P').
printGrid(X,Y) :- location(Item,X,Y), Item == hutan, !, write('H').
printGrid(X,Y) :- location(Item,X,Y), Item == lapangan, !, write('L').
printGrid(X,Y) :- location(Item,X,Y), Item == danau, !, write('D').
printGrid(X,Y) :- !, write('?').

look :- currentPosition(X,Y), !,
        Xi is X-1, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X-1, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X-1, Yi is Y+1, printGrid(Xi,Yi), write(' '), nl,
        Xi is X+1, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X+1, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X+1, Yi is Y+1, printGrid(Xi,Yi), write(' '), nl,
        Xi is X, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X, Yi is Y+1, printGrid(Xi,Yi). write(' '), nl.
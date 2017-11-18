:- dynamic(currentPosition/2).

/* fakta lokasi */
location(beruang,1,1).
location(kucing,1,1).
location(anjing,1,1).
location(bebek,1,1).

currentPosition(1, 1).

printItemAtLocation(X,Y) :- location(A,X,Y), write(A), write(' ').

valid(A,B) :- !, A >= 1, A =< 20, B >= 1, B =< 20.

get_newPositon(Direction, A, B, C, D) :- Direction == n, !, C is A-1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == s, !, C is A+1, D is B.
get_newPositon(Direction, A, B, C, D) :- Direction == e, !, C is A, D is B+1.
get_newPositon(Direction, A, B, C, D) :- Direction == w, !, C is A, D is B-1.

go(Direction) :- currentPosition(A,B),
                 get_newPositon(Direction,A,B,C,D),
                 valid(C,D),
                 retract(currentPosition(_,_)),
                 asserta(currentPosition(C,D)),!.

go(_) :- write('Tidak bisa kesana gan'), nl.

n :- go(n).
s :- go(s).
w :- go(w).
e :- go(e).

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
        Xi is X+1, Yi is Y+1, printGrid(Xi,Yi), write(' '), nl
        Xi is X, Yi is Y-1, printGrid(Xi,Yi), write(' '),
        Xi is X, Yi is Y, printGrid(Xi,Yi), write(' '),
        Xi is X, Yi is Y+1, printGrid(Xi,Yi). write(' '), nl.
/*
    All logic regarding map will be put here
 */


:- dynamic(mapAt/3).
:- dynamic(currentPosition/2).

currentPosition(1,1).

valid(A,B) :- !, A >= 1, A =< 20, B >= 1, B =< 20.

% MAP INITIALIZATION - START
make_map_from_list(_, _, []) :- !.
make_map_from_list(Row, Col, [H|T]) :- asserta(mapAt(Row,Col,H)), NextCol is Col+1, make_map_from_list(Row,NextCol,T), !.

make_map_row_0  :- make_map_from_list(0,0,  ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']).
make_map_row_1  :- make_map_from_list(1,0,  ['#', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', '#']).
make_map_row_2  :- make_map_from_list(2,0,  ['#', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', '#']).
make_map_row_3  :- make_map_from_list(3,0,  ['#', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', 'F', 'O', '#']).
make_map_row_4  :- make_map_from_list(4,0,  ['#', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', '#']).
make_map_row_5  :- make_map_from_list(5,0,  ['#', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', '#']).
make_map_row_6  :- make_map_from_list(6,0,  ['#', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', '#']).
make_map_row_7  :- make_map_from_list(7,0,  ['#', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', '#']).
make_map_row_8  :- make_map_from_list(8,0,  ['#', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', 'F', 'L', '#']).
make_map_row_9  :- make_map_from_list(9,0,  ['#', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', '#']).
make_map_row_10 :- make_map_from_list(10,0, ['#', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', 'F', '#']).
make_map_row_11 :- make_map_from_list(11,0, ['#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#', '#']).

init_map :- make_map_row_0,
           make_map_row_1,
           make_map_row_2,
           make_map_row_3,
           make_map_row_4,
           make_map_row_5,
           make_map_row_6,
           make_map_row_7,
           make_map_row_8,
           make_map_row_9,
           make_map_row_10,
           make_map_row_11.
% MAP INITIALIZATION - END

% MAP PRINT - START
printMapInner(11,22) :- !.
printMapInner(X,22) :- !, nl, Xi is X+1, printMapInner(Xi,0).
printMapInner(X,Y) :- write(' '), printGrid(X,Y), write(' '), Yi is Y+1, printMapInner(X,Yi).
printMap :- printMapInner(0,0).

printGrid(Row,Col) :- currentPosition(Row,Col), !, write('P').
printGrid(Row,Col) :- enemy_at(Row,Col,_, _), !, write('E').
printGrid(Row,Col) :- mapAt(Row,Col,X), X == '#', !, write('#').
%% printGrid(Row,Col) :- mapAt(Row,Col,X), X == 'A', !, write('-').
%% printGrid(Row,Col) :- mapAt(Row,Col,X), X == 'F', !, write('L').
printGrid(_,_) :- !, write('<').
% MAP PRINT - END

print_grid_detail(Row, Col) :- currentPosition(Row, Col), !, write('your current position').
print_grid_detail(Row, Col) :- enemy_at(Row, Col, _, _), !, write('enemy').
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, medicine), !, write('medicine').
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, food), !, write('food').
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, water), !, write('water').
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, weapon), !, write('weapon').
print_grid_detail(Row,Col) :- mapAt(Row,Col,X), X == '#', !, write('fence').
print_grid_detail(Row,Col) :- mapAt(Row,Col,X), X == 'O', !, write('open field').
print_grid_detail(Row,Col) :- mapAt(Row,Col,X), X == 'L', !, write('lake').
print_grid_detail(Row,Col) :- mapAt(Row,Col,X), X == 'F', !, write('forest').
print_grid_detail(_,_) :- !, write('something unknown (BUG)').

% MAP LOOK - Still unfinished (masih blom kepikiran)
look :- currentPosition(X,Y), !,
        A is X-1, write('on your north there\'s '), print_grid_detail(A, Y), nl,
        B is Y-1, write('on your west there\'s '), print_grid_detail(X, B), nl,
        C is X+1, write('on your south there\'s '), print_grid_detail(C, Y), nl,
        D is Y+1, write('on your east there\'s '), print_grid_detail(X, D), nl,
        !.
% MAP LOOK - END
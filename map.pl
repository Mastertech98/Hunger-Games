/*
    All logic regarding map will be put here
 */


:- dynamic(map_at/3).
:- dynamic(current_position/2).

current_position(1,1).

valid(A,B) :- map_at(A,B,X), X \== '#'.

% MAP INITIALIZATION - START
make_map_from_list(_, _, []) :- !.
make_map_from_list(Row, Col, [H|T]) :- asserta(map_at(Row,Col,H)), NextCol is Col+1, make_map_from_list(Row,NextCol,T), !.

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
print_map_inner(11,22) :- !.
print_map_inner(X,22) :- !, nl, Xi is X+1, print_map_inner(Xi,0).
print_map_inner(X,Y) :- write(' '), print_grid_code(X,Y), write(' '), Yi is Y+1, print_map_inner(X,Yi).
print_map :- print_map_inner(0,0).

print_grid_code(Row,Col) :- current_position(Row,Col), !, write('P').
print_grid_code(Row,Col) :- enemy_at(Row,Col,_, _), !, write('E').
print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,medicine), !, write('m').
print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,food), !, write('f').
print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,water), !, write('w').
print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,weapon), !, write('s').
print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,bag), !, write('b').
print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,map), !, write('r').
%% print_grid_code(Row,Col) :- object_at(Name,Row,Col), object_type(Name,radar), !, write('r').
print_grid_code(Row,Col) :- map_at(Row,Col,X), X == '#', !, write('#').
print_grid_code(Row,Col) :- map_at(Row,Col,X), X == 'O', !, write('-').
print_grid_code(Row,Col) :- map_at(Row,Col,X), X == 'F', !, write('^').
print_grid_code(Row,Col) :- map_at(Row,Col,X), X == 'L', !, write('~').
print_grid_code(_,_) :- !, write('<').
% MAP PRINT - END

print_grid_map(Row,Col) :- map_at(Row,Col,X), X == '#', !, write('fence').
print_grid_map(Row,Col) :- map_at(Row,Col,X), X == 'O', !, write('open field').
print_grid_map(Row,Col) :- map_at(Row,Col,X), X == 'L', !, write('lake').
print_grid_map(Row,Col) :- map_at(Row,Col,X), X == 'F', !, write('forest').
print_grid_map(_,_) :- !, write('unknown grid map').

print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, medicine), !, write('theres '), write(X), write(', cure yourself with it!'), nl.
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, food), !, write('theres '),write(X), write(', it seems like it\'s edible'), nl.
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, water), !, write('theres '),write(X), write(', could definitely cure yout thrist'), nl.
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, weapon), !, write('theres '),write(X), write(', attack your enemy with it!'), nl.
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, bag), !, write('theres '),write('backpack, extra storage for your inventory!'), nl.
print_grid_detail(Row, Col) :- object_at(X, Row, Col), object_type(X, map), !, write('theres '),write('radar, will be useful to see the map'), nl.
print_grid_detail(Row,Col) :- !.

% MAP LOOK - Still unfinished (masih blom kepikiran)

print_neighbours_code :- current_position(Row, Col),
                         A is Row-1, B is Row+1, C is Col-1, D is Col+1,
                         print_grid_code(A, C), write(' '), print_grid_code(A, Col), write(' '), print_grid_code(A, D), nl,
                         print_grid_code(Row, C), write(' '), print_grid_code(Row, Col), write(' '), print_grid_code(Row, D), nl,
                         print_grid_code(B, C), write(' '), print_grid_code(B, Col), write(' '), print_grid_code(B, D), nl.

%% look :- current_position(Row, Col),
%%          write('You\'re in '), print_grid_map(Row, Col), nl,
%%          A is Row-1, B is Row+1, C is Col-1, D is Col+1,
%%          print_grid_code(A, C), write(' '), print_grid_code(A, Col), write(' '), print_grid_code(A, D), nl,
%%          print_grid_code(Row, C), write(' '), print_grid_code(Row, Col), write(' '), print_grid_code(Row, D), nl,
%%          print_grid_code(B, C), write(' '), print_grid_code(B, Col), write(' '), print_grid_code(B, D), nl.

print_current_grid_neighbours :- current_position(X,Y), !,
        A is X-1, write('on your north there\'s '), print_grid_map(A, Y), nl,
        B is Y-1, write('on your west there\'s '), print_grid_map(X, B), nl,
        C is X+1, write('on your south there\'s '), print_grid_map(C, Y), nl,
        D is Y+1, write('on your east there\'s '), print_grid_map(X, D), nl,
        !.

print_current_grid_map_message :- current_position(X,Y), write('You\'re in '), print_grid_map(X,Y), nl.

print_current_grid_enemies :- current_position(X,Y), enemy_at(X,Y,_,_), write('You see enemy nearby!'), nl.
print_current_grid_enemies :- !.

%% print_current_grid_object(Type) :- current_position(X,Y), print_grid_detail(X,Y).
print_current_grid_object(Type) :- current_position(X,Y), object_at(Name,X,Y),  object_type(Name, Type), write('You got '), write(Type), write(' nearby'), nl.
print_current_grid_object(_) :- !.

print_current_grid_situation :- print_current_grid_map_message,
                                print_current_grid_enemies,
                                current_position(X,Y),
                                print_grid_detail(X,Y).
                                %% print_current_grid_object(medicine),
                                %% print_current_grid_object(food),
                                %% print_current_grid_object(water),
                                %% print_current_grid_object(weapon).

look :- print_current_grid_situation, print_neighbours_code.

print_current_location_detail :- current_position(Row, Col), write('You enter '), print_grid_map(Row, Col), nl.
print_current_location_detail :- write('yihaaaaaaa').

% MAP LOOK - END

map :- is_exist(radar), !, print_map.
map :- write('You need radar to see the map!'), !.
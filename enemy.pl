:- dynamic(enemyAt/4).

numberOfEnemies(10).

generateRandomEnemy(0) :- !.
generateRandomEnemy(X) :- random(1, 10, Row), random(1, 20, Col), random(30, 100, Power),
                          asserta(enemyAt(Row,Col,Power,X)),
                          NextX is X-1,
                          generateRandomEnemy(NextX), !.

initEnemy :- numberOfEnemies(X), generateRandomEnemy(X).

moveEnemy(0) :- !.
moveEnemy(X) :- random(1,4,N), movv(X, N), NextX is X-1, moveEnemy(NextX).

movv(X, N) :- N == 1, !, enemyAt(Row, Col, _, X), NewRow is Row+1, write('1 - '), write(Row), write(' '), write(Col), write(' to '), write(NewRow), write(' '), write(Col), nl, updateEnemyPosition(NewRow, Col, X).
movv(X, N) :- N == 2, !, enemyAt(Row, Col, _, X), NewRow is Row-1, write('2 - '), write(Row), write(' '), write(Col), write(' to '), write(NewRow), write(' '), write(Col), nl, updateEnemyPosition(NewRow, Col, X).
movv(X, N) :- N == 3, !, enemyAt(Row, Col, _, X), NewCol is Col+1, write('3 - '), write(Row), write(' '), write(Col), write(' to '), write(Row), write(' '), write(NewCol), nl,updateEnemyPosition(Row, NewCol, X).
movv(X, N) :- N == 4, !, enemyAt(Row, Col, _, X), NewCol is Col-1, write('4 - '), write(Row), write(' '), write(Col), write(' to '), write(Row), write(' '), write(NewCol), nl,updateEnemyPosition(Row, NewCol, X).

updateEnemyPosition(Row, Col, X) :- enemyAt(_, _, Power, X), !,
                                    retract(enemyAt(_, _, _, X)),
                                    asserta(enemyAt(Row, Col, Power, X)).

% Call this command to automatically move all enemy in random direction
% TODO : validate enemy movement so that they will never: collide, reach gate ('#')
% TODO : when will enemy attack player? decide and implement
randomMoveAllEnemies :- numberOfEnemies(X), moveEnemy(X).
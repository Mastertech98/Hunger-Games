:- dynamic(enemyAt/3).

generateRandomEnemy(0) :- !.
generateRandomEnemy(X) :- random(1, 10, Row), random(1, 20, Col), random(30, 100, Power),
                          asserta(enemyAt(Row,Col,Power)),
                          NextX is X-1,
                          generateRandomEnemy(NextX).

initEnemy :- generateRandomEnemy(10).
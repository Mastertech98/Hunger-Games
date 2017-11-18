:- dynamic(player/7).

/* Rules for printlist */
printlist([]).
printlist([A|B]) :- write(' '),write(A),nl,printlist(B).

/* Default attribute for player */
default_health(100).
default_hunger(100).
default_thirst(100).
default_position(0,0).
default_weapon('none').
default_inventory([]).

/* Initialize Player */
init_player:-
  default_health(Health),
  default_hunger(Hunger),
  default_thirst(Thirst),
  default_weapon(Weapon),
  default_inventory(Inventory),
  default_position(X,Y),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).

/* Health */
increase_health(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrHealth is Health + Amount,
  asserta(player(X,Y,CurrHealth,Hunger,Thirst,Weapon,Inventory)).

decrease_health(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrHealth is Health - Amount,
  asserta(player(X,Y,CurrHealth,Hunger,Thirst,Weapon,Inventory)).

get_health(Health):-
  player(_,_,Health,_,_,_,_).

set_health(Health):-
  retract(player(X,Y,CurrHealth,Hunger,Thirst,Weapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).

/* Hunger */
increase_hunger(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  ResultHunger is Hunger+Amount,
  asserta(player(X,Y,Health,ResultHunger,Thirst,Weapon,Inventory)).

decrease_hunger(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  ResultHunger is Hunger-Amount,
  asserta(player(X,Y,Health,ResultHunger,Thirst,Weapon,Inventory)).

get_hunger(Hunger):-
  player(_,_,_,Hunger,_,_,_).

set_hunger(Hunger):-
  retract(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).

/* Thirst */
increase_thirst(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  ResultThirst is Thirst+Amount,
  asserta(player(X,Y,Health,Hunger,ResultThirst,Weapon,Inventory)).

decrease_thirst(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  ResultThirst is Thirst-Amount,
  asserta(player(X,Y,Health,Hunger,ResultThirst,Weapon,Inventory)).

get_thirst(Thirst):-
  player(_,_,_,_,Thirst,_,_).

set_thirst(Thirst):-
  retract(player(X,Y,Health,Hunger,CurrThirst,Weapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).

/* Weapon */
set_weapon(Weapon):-
  retract(player(X,Y,Health,Hunger,Thirst,CurrWeapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).

get_weapon(Weapon):-
  player(_,_,_,_,_,Weapon,_).

/* Inventory */
add_item(Item):- /* Use for command Take */
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  append([Item],Inventory,NewInventory),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

get_item_list(Inventory):-
  player(_,_,_,_,_,_,Inventory).

/* Position */
get_position(X,Y):-
  player(X,Y,_,_,_,_,_).

set_position(X,Y):-
  retract(player(CurrX,CurrY,Health,Hunger,Thirst,Weapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

step_up:-
  player(X,CurrY,Health,Hunger,Thirst,Weapon,Inventory),
  CurrY > 0,
  retract(player(X,CurrY,Health,Hunger,Thirst,Weapon,Inventory)),
  Y is CurrY-1,
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

step_down:-
  player(X,CurrY,Health,Hunger,Thirst,Weapon,Inventory),
  CurrY < 20,
  retract(player(X,CurrY,Health,Hunger,Thirst,Weapon,Inventory)),
  Y is CurrY+1,
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

step_left:-
  player(CurrX,Y,Health,Hunger,Thirst,Weapon,Inventory),
  CurrX > 0,
  retract(player(CurrX,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  X is CurrX-1,
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

step_right:-
  player(CurrX,Y,Health,Hunger,Thirst,Weapon,Inventory),
  CurrX < 10,
  retract(player(CurrX,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  X is CurrX+1,
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).
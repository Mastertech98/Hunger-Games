:- dynamic(player/7).

/* Rules for printlist */
printlist([]) :- !.
printlist([A|B]) :- write(' o '),write(A),nl,printlist(B).

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
  CurrHunger is Hunger+Amount,
  asserta(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)).

decrease_hunger(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrHunger is Hunger-Amount,
  asserta(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)).

get_hunger(Hunger):-
  player(_,_,_,Hunger,_,_,_).

set_hunger(Hunger):-
  retract(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).

/* Thirst */
increase_thirst(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrThirst is Thirst+Amount,
  asserta(player(X,Y,Health,Hunger,CurrThirst,Weapon,Inventory)).

decrease_thirst(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrThirst is Thirst-Amount,
  asserta(player(X,Y,Health,Hunger,CurrThirst,Weapon,Inventory)).

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

status :-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  write('Health : '), write(Health), nl,
  write('Hunger : '), write(Hunger), nl,
  write('Thirst : '), write(Thirst), nl,
  write('Weapon : '), write(Weapon), nl, 
  Inventory \== default_inventory, write('Inventory : '), nl,  printlist(Inventory).

status :-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  write('Health : '), write(Health), nl,
  write('Hunger : '), write(Hunger), nl,
  write('Thirst : '), write(Thirst), nl,
  write('Weapon : '), write(Weapon), nl,
  Inventory == [], write('Crap,take something already dude.Or do you want to die here? '), nl.


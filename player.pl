:- dynamic(player/7).
:- dynamic(location/3).

/* --------------------------- OBJECT --------------------------- */

/* Weapon and its attack */
weapon(axe,50).
weapon(baton,40).
weapon(blowgun,60).
weapon(crossbow,100).
weapon(knife,30).
weapon(mace,50).
weapon(machete,60).
weapon(scythe,70).

/* Food and its power */
food(burger,30).
food(rice,35).
food(noodle,30).
food(bread,20).
food(salad,10).

/* Drink and its power */
drink(water,20).
drink(tea,30).
drink(coffee,25).
drink(cola,30).
drink(wine,35).

/* Medical kit and its power */
medical(medicalkit,30).
medical(lotus,50).

/* Special */
special(backpack).


/* --------------------------- PLAYER --------------------------- */

/* Rules for printlist */
printlist([]) :- !.
printlist([A|B]) :- write(' o '),write(A),nl,printlist(B).

/* Rules for determining length of list */
len([], LenResult):-
    LenResult is 0.

len([X|Y], LenResult):-
    len(Y, L),
    LenResult is L + 1.

/* Default attribute for player */
default_health(100).
default_hunger(100).
default_thirst(100).
default_position(0,0).
default_weapon('none').
default_inventory([]).

/* Maximum amount of inventory */
standard_size(10).
upgraded_size(20).


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
  CurrHunger is Hunger + Amount,
  asserta(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)).

decrease_hunger(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrHunger is Hunger - Amount,
  asserta(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)).

get_hunger(Hunger):-
  player(_,_,_,Hunger,_,_,_).

set_hunger(Hunger):-
  retract(player(X,Y,Health,CurrHunger,Thirst,Weapon,Inventory)),
  asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).


/* Thirst */
increase_thirst(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrThirst is Thirst + Amount,
  asserta(player(X,Y,Health,Hunger,CurrThirst,Weapon,Inventory)).

decrease_thirst(Amount):-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  CurrThirst is Thirst - Amount,
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


/* Status command */
status :-
  retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
  write('Health : '), write(Health), nl,
  write('Hunger : '), write(Hunger), nl,
  write('Thirst : '), write(Thirst), nl,
  write('Weapon : '), write(Weapon), nl, 
  /* If-else in Prolog */
  ( Inventory == [] -> write('Crap,take something already dude.Or do you want to die here? '), nl,!
  ; write('Inventory : '), nl,  printlist(Inventory),!
  ).


/* Take command */
take(Object) :- 
                ( can_take(Object), format('You took ~w !',[Object]),nl,!
                ; format('~w does not exist here or your inventory is full',[Object]),nl,fail
                ).

/* location define object's location.Synced later with map */
can_take(Object) :- 
                    ( weapon(Object,_) /*, player(X,Y,_,_,_,_,_)   , location(X,Y,Object)*/ , get_item_list(Inventory), len(Inventory,X) , X < 10 -> add_item(Object)
                    ; food(Object,_)/* , player(X,Y,_,_,_,_,_)  , location(X,Y,Object)*/ , get_item_list(Inventory), len(Inventory,X) , X < 10 -> add_item(Object)
                    ; drink(Object,_)/* , player(X,Y,_,_,_,_,_)  , location(X,Y,Object)*/ , get_item_list(Inventory), len(Inventory,X) , X  < 10 -> add_item(Object)
                    ; medical(Object,_) /*, player(X,Y,_,_,_,_,_)   , location(X,Y,Object)*/ , get_item_list(Inventory),len(Inventory,X) , X < 10 -> add_item(Object)
                    ; special(Object) /*, player(X,Y,_,_,_,_,_)   , location(X,Y,Object)*/ , get_item_list(Inventory),len(Inventory,X) , X < 10 -> add_item(Object)
                    ).

/* Drop command */
drop(Object) :- 
                ( is_exist(Object) -> delete_item(Object) /* drop should return item to map,not yet made*/, format('You drop ~w !',[Object]),nl,!
                ; format('~w does not exist in your inventory',[Object]),nl,fail
                ).

/* Still not have connection with location */
is_exist(Object) :- get_item_list(Inventory), member(Object,Inventory).

/* Still not have connection with location */
delete_item(Object) :- retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
                       delete_once(Object,Inventory,NewInventory),
                       asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

/* Rules for deleting just one element in list */
delete_once(X,[X|Xs],Xs) :- !.
delete_once(X,[Y|Xs],[Y|Ys]) :- dif(X,Y) , delete_once(X,Xs,Ys).  

/* Use command */
use(Object) :-  
                ( is_exist(Object) ->
                    ( weapon(Object,_) -> set_weapon(Object) , format('You have successfully use ~w',[Object]),nl, delete_item(Object) 
                    ; food(Object,Plus) -> increase_hunger(Plus) , format('You have successfully use ~w',[Object]),nl, delete_item(Object)
                    ; drink(Object,Plus) -> increase_thirst(Plus) , format('You have successfully use ~w',[Object]),nl, delete_item(Object)
                    ; medical(Object,Plus)  -> increase_health(Plus) , format('You have successfully use ~w',[Object]),nl, delete_item(Object)
                    )
                ; format('~w does not exist in your inventory',[Object]),nl,fail
                ).
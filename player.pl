:- dynamic(player/7).
/* newwww */
:- dynamic(object_at/2).

:- dynamic(has_upgraded/1).

/* --------------------------- OBJECT --------------------------- */

/*
    NEW OBJECT:
    object_type(NAME, TYPE)
    object_at(NAME, X, Y)
    object_val(NAME, VAL)

    contoh:
    object_type(seblak, food).
    object_at(seblak, 1, 2).
    object_val(seblak, 20) - dimana val dari food itu adalah jumlah hp yg naik kalo dikonsumsi
*/

/* end */

/* Object type and it's name */
object_type(axe,weapon).
object_type(baton,weapon).
object_type(blowgun,weapon).
object_type(crossbow,weapon).
object_type(knife,weapon).
object_type(mace,weapon).
object_type(machete,weapon).
object_type(scythe,weapon).
object_type(burger,food).
object_type(rice,food).
object_type(noodle,food).
object_type(bread,food).
object_type(salad,food).
object_type(water,drink).
object_type(tea,drink).
object_type(coffee,drink).
object_type(cola,drink).
object_type(wine,drink).
object_type(medicalkit,medical).
object_type(lotus,medical).
object_type(backpack,bag).
object_type(radars,map).

/* Object val and it's name */
object_val(axe,50).
object_val(baton,40).
object_val(blowgun,60).
object_val(crossbow,100).
object_val(knife,30).
object_val(mace,50).
object_val(machete,60).
object_val(scythe,70).
object_val(burger,30).
object_val(rice,35).
object_val(noodle,30).
object_val(bread,20).
object_val(salad,10).
object_val(water,20).
object_val(tea,30).
object_val(coffee,25).
object_val(cola,30).
object_val(wine,35).
object_val(medicalkit,30).
object_val(lotus,50).
object_val(backpack,0).
object_val(radar,0).

has_upgraded(0).
/* --------------------------- PLAYER --------------------------- */

/* Rules for printlist */
printlist([]) :- !.
printlist([A|B]) :- write(' o '),write(A),nl,printlist(B).

/* Rules for determining length of list */
len([], LenResult):-
    LenResult is 0.

len([_|Y], LenResult):-
    len(Y, L), LenResult is L + 1.

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
    retract(player(X,Y,_,Hunger,Thirst,Weapon,Inventory)),
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
    retract(player(X,Y,Health,_,Thirst,Weapon,Inventory)),
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
    retract(player(X,Y,Health,Hunger,_,Weapon,Inventory)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).


/* Weapon */
set_weapon(Weapon):-
    retract(player(X,Y,Health,Hunger,Thirst,_,Inventory)),
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
    retract(player(_,_,Health,Hunger,Thirst,Weapon,Inventory)),
    asserta(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)).


/* Status command */
status :-
    get_health(Health),
    get_weapon(Weapon),
    get_thirst(Thirst),
    get_item_list(Inventory),
    get_hunger(Hunger),
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
( object_type(Object,weapon) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(0),len(Inventory,X) , X < 10 -> add_item(Object)
; object_type(Object,weapon) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(1),len(Inventory,X) , X < 20 -> add_item(Object)
; object_type(Object,food)/* , player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(0),len(Inventory,X) , X < 10 -> add_item(Object)
; object_type(Object,food)/* , player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(1),len(Inventory,X) , X < 20 -> add_item(Object)
; object_type(Object,drink)/* , player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(0),len(Inventory,X) , X  < 10 -> add_item(Object)
; object_type(Object,drink)/* , player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(1),len(Inventory,X) , X  < 20 -> add_item(Object)
; object_type(Object,medical) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(0),len(Inventory,X) , X < 10 -> add_item(Object)
; object_type(Object,medical) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(1),len(Inventory,X) , X < 20 -> add_item(Object)
; object_type(Object,bag) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(0),len(Inventory,X) , X < 10 -> add_item(Object)
; object_type(Object,bag) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(1),len(Inventory,X) , X < 20 -> add_item(Object)
; object_type(Object,map) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(0),len(Inventory,X) , X < 10 -> add_item(Object)
; object_type(Object,map) /*, player(X,Y,_,_,_,_,_),object_at(Object,X,Y)*/,get_item_list(Inventory),has_upgraded(1),len(Inventory,X) , X < 20 -> add_item(Object)
).

/* Drop command */
drop(Object) :- 
                ( is_exist(Object) -> delete_item(Object) /* drop should return item to map,not yet made*/, format('You drop ~w !',[Object]),nl,!
                ; format('~w does not exist in your inventory',[Object]),nl,fail
                ).

is_exist(Object) :- get_item_list(Inventory), member(Object,Inventory).

delete_item(Object) :- retract(player(X,Y,Health,Hunger,Thirst,Weapon,Inventory)),
                       delete_once(Object,Inventory,NewInventory),
                       asserta(player(X,Y,Health,Hunger,Thirst,Weapon,NewInventory)).

/* Rules for deleting just one element in list */
delete_once(X,[X|Xs],Xs) :- !.
delete_once(X,[Y|Xs],[Y|Ys]) :- dif(X,Y) , delete_once(X,Xs,Ys).  

/* Use command */
use(Object) :-  
( is_exist(Object) ->
  ( object_type(Object,weapon) -> set_weapon(Object) , format('You held ~w in your hand .',[Object]),nl, delete_item(Object) 
  ; object_type(Object,food)-> object_val(Object,Plus),increase_hunger(Plus) , format('Yummy.. I love ~w.Food is important to survive. ',[Object]),nl, delete_item(Object)
  ; object_type(Object,drink) -> object_val(Object,Plus),increase_thirst(Plus) , format('Glad to have ~w.Water is important to survive.',[Object]),nl, delete_item(Object)
  ; object_type(Object,medical) -> object_val(Object,Plus),increase_health(Plus) , format('You treated your wounds with ~w.',[Object]),nl, delete_item(Object)
  ; bag(Object) -> set_max_inventory,format('Whoa, you upgrade your bag with ~w.',[Object]),delete_item(Object) 
  ; map(Object) -> look_all_map ,format('Whoa, you upgrade your bag with ~w.',[Object]) 
  )
; format('~w does not exist in your inventory',[Object]),nl,fail
).

set_max_inventory :- retract(has_upgraded(_)) , asserta(has_upgraded(1)).

/* Expand command */
expand(Object) :- bag(Object) , use(Object).

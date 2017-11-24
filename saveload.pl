
saveGame(FileName) :-  
		open(FileName,write,Out), 
		current_position(XP,YP),write(Out,XP),write(Out,'. '),write(Out,YP),write(Out,'.'),nl(Out),
		
		findall(Row,enemy_at(Row,_,_,_),ListRow),findall(Col,enemy_at(_,Col,_,_),ListCol),findall(Pow,enemy_at(_,_,Pow,_),ListPow),findall(ID,enemy_at(_,_,_,ID),ListID),
		write(Out,ListRow),write(Out,'. '),write(Out,ListCol),write(Out,'. '),write(Out,ListPow),write(Out,'. '),write(Out,ListID),write(Out,'.'),nl(Out),
		
		player(X,Y,Health,Hunger,Thirst,Weapon,Inventory),write(Out,X),write(Out,'. '),write(Out,Y),write(Out,'. '),write(Out,Health),write(Out,'. '),
			write(Out,Hunger),write(Out,'. '),write(Out,Thirst),write(Out,'. '),write(Out,Weapon),write(Out,'. '),write(Out,Inventory),write(Out,'.'),nl(Out),
		
		findall(Obj1,object_at(Obj1,_,_),ListObj1),findall(Obj2,object_at(_,Obj2,_),ListObj2),findall(Obj3,object_at(_,_,Obj3),ListObj3),
		write(Out,ListObj1),write(Out,'. '),
		write(Out,ListObj2),write(Out,'. '),
		write(Out,ListObj3),write(Out,'.'),nl(Out),
		
		has_upgraded(ValUp),write(Out,ValUp),write(Out,'. '),nl(Out), 
		close(Out),write('File has been saved!!'),!.

saveGame(_) :- write('Save is Failed. Please try again'),!.
		
loadGame(FileName) :- open(FileName,read,In),
		read(In,PlayerPosiX),read(In,PlayerPosiY),retract(current_position(_,_)),asserta(current_position(PlayerPosiX,PlayerPosiY)),

		
		read(In,Row),
		read(In,Col),
		read(In,Pow),
		read(In,ID),
		makeAssertEnemy(Row,Col,Pow,ID),
	
		read(In,PlayerX),read(In,PlayerY),read(In,PlayerHealth),
		read(In,PlayerHunger),read(In,PlayerThirst),read(In,PlayerWeapon),read(In,PlayerInvent),
		
		retract(player(_,_,_,_,_,_,_)),asserta(player(PlayerX,PlayerY,PlayerHealth,PlayerHunger,PlayerThirst,PlayerWeapon,PlayerInvent)),
		
		read(In,Obj1),
		read(In,Obj2),
		read(In,Obj3),
		makeAssertObj(Obj1,Obj2,Obj3),
		
		read(In,ValUp),retract(has_upgraded(_)),asserta(has_upgraded(ValUp)), 
		
		close(In),write('Load is success'),!.
		
loadGame(FileName) :- open(FileName,read,In),
		read(In,PlayerPosiX),read(In,PlayerPosiY),retract(current_position(_,_)),asserta(current_position(PlayerPosiX,PlayerPosiY)),

		
		read(In,Row),
		read(In,Col),
		read(In,Pow),
		read(In,ID),
		makeAssertEnemy(Row,Col,Pow,ID),
	
		read(In,PlayerX),read(In,PlayerY),read(In,PlayerHealth),
		read(In,PlayerHunger),read(In,PlayerThirst),read(In,PlayerWeapon),read(In,PlayerInvent),
		
		asserta(player(PlayerX,PlayerY,PlayerHealth,PlayerHunger,PlayerThirst,PlayerWeapon,PlayerInvent)),
		
		read(In,Obj1),
		read(In,Obj2),
		read(In,Obj3),
		makeAssertObj(Obj1,Obj2,Obj3),
		
		read(In,ValUp),retract(has_upgraded(_)),asserta(has_upgraded(ValUp)), 
		
		close(In),write('Load is success'),!.
		
loadGame(_) :- write('Load is Failed. Please try again'),!. 
		
retractAll :- retractall(current_position(_,_)),retract(player(_,_,_,_,_,_,_)),retractall(enemy_at(_,_,_,_)),retractall(object_at(_,_,_)),retractall(has_upgraded(_)).
all_retract :- retractAll.

makeAssertObj([],[],[]) :- !.
makeAssertObj([A|B],[C|D],[E|F]) :- asserta(object_at(A,C,E)), makeAssertObj(B,D,F). 

makeAssertEnemy([],[],[],[]) :- !.
makeAssertEnemy([A|B],[C|D],[E|F],[G|H]) :- asserta(enemy_at(A,C,E,G)), makeAssertEnemy(B,D,F,H). 
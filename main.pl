:- include('map.pl').
:- include('enemy.pl').
:- include('move.pl').
:- include('player.pl').
:- include('attack.pl').
:- include('game.pl').
:- include('saveload.pl').

quit2:-write('are you sure to quit [yes/no]'),nl, 
		read(Y), 
		(
			Y=='yes' -> halt
			;Y == 'no' -> command
		).
help:-  write('Available commands:\n'),
        write('start              --- start the game!\n'),
        write('help               --- show available commands\n'),
        write('quit               --- quit the game\n'),
        write('look               --- look around you\n'),
        write('n. s. e. w.        --- move\n'),
        write('map                --- look at the map and detect enemies (need radar to use)\n'),
        write('take(Object)       --- pick up an object\n'),
        write('drop(Object)       --- drop an object\n'),
        write('use(Object)        --- use an object\n'),
        write('expand(Object)     --- expand inventory if you have item backpack\n'),
        write('attack             --- attack enemy that crosses your path\n'),
        write('status             --- show your status\n'),
        write('nap                --- take a nap to renew health but decrease hunger and thirst\n'),
        write('saveGame(Filename) --- save your game\n'),
        write('Legends:\n'),
        write('m = medicine\n'),
        write('f = food\n'),
        write('w = water\n'),
        write('s = weapon\n'),
        write('P = player\n'),
        write('E = enemy\n'),
        write('~,^,f,- = accessible\n'),
        write('# = fence(not accessible)\n'),
        write('r = radar\n'),
        write('b = backpack\n').

z :- start, seede.

title:- write('___________________________________________________________________________________________________________________'),nl,
        write('__00___00__00___00__0000000__0000000__0000000__0000000_________0000000___0000000___00_______00__0000000__0000000___'),nl,
        write('__00___00__00___00__00___00__00_______00_______00____00________00_______00_____00__0000___0000__00_______00________'),nl,
        write('__00___00__00___00__00___00__00_______00_______00____00________00_______00_____00__00_00_00_00__00_______00________'),nl,
        write('__0000000__00___00__00___00__00_0000__0000000__0000000_________00_0000__000000000__00___0___00__0000000__0000000___'),nl,
        write('__00___00__00___00__00___00__00___00__00_______00_00___________00___00__00_____00__00_______00__00____________00___'),nl,
        write('__00___00__00___00__00___00__00___00__00_______00__00__________00___00__00_____00__00_______00__00____________00___'),nl,
        write('__00___00___00000___00___00__0000000__0000000__00___00_________0000000__00_____00__00_______00__0000000__0000000___'),nl,
        write('___________________________________________________________________________________________________________________'),nl,nl,nl,
		command.
command :-  write('Do you want to load,have a new game or quit from the game [load/new/quit] ?\n'),
			read(X),
			(
				X == 'load' -> write('Input the name of the file with the format (ex : \'save\')'),nl ,init_map,read(Y) , loadGame(Y), nl, nl, help
			   ;X == 'new' -> initGame, nl, nl, help
			   ;X == 'quit' -> quit2
			).


start :- title.

initGame :- 
   %%          write('\n\n\nI heard you volunteer yourself into this so-called game eh?\n'),sleep(3),
			%% write('I don\'t know what\'s wrong with your head \n'),sleep(3),
			%% write('But since you start this game , you need to finish it by your own hand \n'),sleep(3),
			%% write('You need to defeat all enemies to gain victories over your faction \n'),sleep(3),
			%% write('I know it will be hard ,but good luck \n'),sleep(3),
			%% write('Happy Hunger Games,may the force be with you \n'),sleep(3),
			%% write('.... Wrong movie .... \n'),sleep(2),
			%% write('Happy Hunger Games! And may the odds be ever in your favor.\n\n\n'),sleep(3),
            init_map, init_enemy, init_player, generate_random_obj.

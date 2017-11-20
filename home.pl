:-include('player.pl').
:-include('main.pl').

quit:-halt.
help:-	write('Available commands:\n'),
		write('start.'),          
		write('--'),
		write('start the game!\n'),
		write('help.'),           
		write('--'),
		write('show available commands\n'),
		write('quit.'),          
		write('--'),
		write('quit the game\n'),
		write('look.'),           
		write('--'),
		write('look around you\n'),
		write('n. s. e. w.'),     
		write('--'),
		write('move\n'),
		write('map.'),            
		write('--'),
		write('look at the map and detect enemies (need radar to use)\n'),
		write('take(Object).'),   
		write('--'),
		write('pick up an object\n'),
		write('drop(Object).'),   
		write('--'),
		write('drop an object\n'),
		write('use(Object).'),   
		write('--\n'),
		write('use an object\n'),
		write('attack.'),         
		write('--'),
		write('attack enemy that crosses your path\n'),
		write('status.'),         
		write('--'),
		write('show your status\n'),
		write('save(Filename).'), 
		write('--'),
		write('save your game\n'),
		write('load(Filename).'), 
		write('--'),
		write('load previously saved game\n'),
		write('Legends:\n'),
		write('M = medicine\n'),
		write('F = food\n'),
		write('W = water\n'),
		write('# = weapon\n'),
		write('P = player\n'),
		write('E = enemy\n'),
		write('- = accessible\n'),
		write('X = inaccessible\n').
look:-  write('E - -\n'),
		write('- P X\n'),
		write('- - X\n').
start:- write('___________________________________________________________________________________________________________________'),nl,
		write('__00___00__00___00__0000000__0000000__0000000__0000000_________0000000___0000000___00_______00__0000000__0000000___'),nl,
		write('__00___00__00___00__00___00__00_______00_______00____00________00_______00_____00__0000___0000__00_______00________'),nl,
		write('__00___00__00___00__00___00__00_______00_______00____00________00_______00_____00__00_00_00_00__00_______00________'),nl,
		write('__0000000__00___00__00___00__00_0000__0000000__0000000_________00_0000__000000000__00___0___00__0000000__0000000___'),nl,
		write('__00___00__00___00__00___00__00___00__00_______00_00___________00___00__00_____00__00_______00__00____________00___'),nl,
		write('__00___00__00___00__00___00__00___00__00_______00__00__________00___00__00_____00__00_______00__00____________00___'),nl,
		write('__00___00___00000___00___00__0000000__0000000__00___00_________0000000__00_____00__00_______00__0000000__0000000___'),nl,
		write('___________________________________________________________________________________________________________________'),nl,
		write('Welcome to the 77th Hunger Games!\n'), 
		write('You have been chosen as one of the lucky contestants. Be the last man standing and you will be remembered as\n'), 
		write('one of the victors.\n'),
		write('type help to see all command in this game.\n'),
		command.

		
command:-write('> '),
		  read(X),(
			  X=='quit' -> quit
			  ;X=='save' -> save
			  ;X=='load' -> load
			  ;X=='help' -> help
			  ;X=='look' -> look
			  ;X=='status' -> status),command,!.
		  
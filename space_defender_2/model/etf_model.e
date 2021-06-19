note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			create {WEAPON_STANDARD}weapon.make
			weapon_q:=5
			create {ARMOUR_NONE}armour.make
			armour_q:=4
			create {ENGINE_STANDARD}engine.make
			engine_q:=3
			create {POWER_RECALL}power.make
			power_q:=5
			create board.make (10, 30, 1, 1, 1, 1, 1, create{STARFIGHTER}.make (1, 1, weapon, armour, engine, power))
			setup_state:=0
			set_up_state:=False
			i := 0
			error_message:=""
			abort_message:="ok%N"+"  Exited from game."
			not_in_game_message:="Command can only be used in game."
			not_enough_resources_message:="Not enough resources to fire."
			not_in_setup_message:="ommand can only be used in setup mode."
			already_in_message:="Already in setup mode"
			select_range_message:="Menu option selected out of range"
			move_error_message:=""
			play_error_message:=""
		end

feature -- model attributes
	s : STRING
	i : INTEGER
	error_i : INTEGER
	correct_i : INTEGER

feature -- attributes
    board : BOARD
    weapon : WEAPON
    weapon_q:INTEGER
    armour : ARMOUR
    armour_q:INTEGER
    engine : ENGINE
    engine_q:INTEGER
    power : POWER
    power_q:INTEGER
    row : INTEGER
    column : INTEGER
    number1 : INTEGER
	number2 : INTEGER
	number3 : INTEGER
	number4 : INTEGER
	number5 : INTEGER
	setup_state : INTEGER
	set_abort : BOOLEAN
	debug_mode:BOOLEAN
	error_message:STRING
	abort_message:STRING
	not_in_game_message:STRING
	not_in_game_state:BOOLEAN
    not_enough_resources_message:STRING
    not_enough_resources_state:BOOLEAN
    set_up_state:BOOLEAN
    not_in_setup_message:STRING
    not_in_setup_state:BOOLEAN
    already_in_message:STRING
    already_in_state:BOOLEAN
    select_range_message:STRING
    select_range_state:BOOLEAN
    move_error_state:BOOLEAN
    move_error_message:STRING
    play_error_state:BOOLEAN
    play_error_message:STRING


feature
	play(board_row: INTEGER ; board_column: INTEGER ; n1: INTEGER ; n2: INTEGER ; n3: INTEGER ; n4: INTEGER ; n5: INTEGER)
      do
      	row:=board_row
      	column:=board_column
      	number1:=n1
      	number2:=n2
      	number3:=n3
      	number4:=n4
      	number5:=n5
      	setup_state:=1
      	set_up_state:=True
      end

feature -- select_weapon_type

     select_weapon_type(n:INTEGER)
       do
         if
           n=1
         then
       	   create{WEAPON_STANDARD}weapon.make
         elseif
       	   n=2
         then
       	   create{WEAPON_SPREAD}weapon.make
         elseif
           n=3
         then
       	   create{WEAPON_SNIPE}weapon.make
         elseif
       	   n=4
         then
       	   create{WEAPON_ROCKET}weapon.make
         elseif
       	   n=5
         then
       	   create{WEAPON_SPLITTER}weapon.make
         end
      end

feature -- select_armour_type
     select_armour_type(n:INTEGER)
       do
    	 if
       	   n=1
       	 then
       	   create{ARMOUR_NONE}armour.make
       	 elseif
       	   n=2
       	 then
       	   create{ARMOUR_LIGHT}armour.make
       	 elseif
       	   n=3
       	 then
       	   create{ARMOUR_MEDIUM}armour.make
         elseif
       	   n=4
       	 then
       	   create{ARMOUR_HEAVY}armour.make
       	 end
      end

feature -- set_engine_type
     set_engine_type(n:INTEGER)
       do
         if
       	   n=1
       	 then
       	   create{ENGINE_STANDARD}engine.make
       	 elseif
      	   n=2
       	 then
       	   create{ENGINE_LIGHT}engine.make
       	 elseif
           n=3
       	 then
       	   create{ENGINE_ARMOURED}engine.make
       	end
      end

feature -- set_power_type
     set_power_type(n:INTEGER)
      do
        if
       	  n=1
       	then
       	  create{POWER_RECALL}power.make
       	elseif
       	  n=2
       	then
       	  create{POWER_REPAIR}power.make
       	elseif
       	  n=3
       	then
       	  create{POWER_OVERCHARGE}power.make
       	elseif
       	  n=4
       	then
       	  create{POWER_DEPLOY_DRONES}power.make
       	elseif
       	  n=5
       	then
       	  create{POWER_ORBITAL_STRIKE}power.make
       	end
      end

feature -- setup_select
     setup_select(n:INTEGER)
      do
       	if
          setup_state=1
       	then
       	  select_weapon_type(n)

       	elseif
       	  setup_state=2
       	then
       	  select_armour_type(n)

    	elseif
       	  setup_state=3
       	then
       	  set_engine_type(n)

	    elseif
       	  setup_state=4
       	then
       	  set_power_type(n)
       	end
      end

feature --setup_next
     setup_next(n:INTEGER)
       do
       	setup_state:=setup_state+n
       	if
       		setup_state>5
       	then
       		set_set_up_state(False)
       		create board.make (row, column, number1, number2, number3, number4, number5, create{STARFIGHTER}.make ((row+1)//2, 1, weapon, armour, engine, power))
       	end
       end

feature -- setup_back
     setup_back(n:INTEGER)
       do
      	setup_state:=setup_state-n
       end

feature -- information
    setup_type_information(n:INTEGER):STRING
    do
      Result:=""
      if
		n=1
	  then
	    Result:="weapon setup, "

      elseif
		n=2
	  then
		Result:="armour setup, "

	  elseif
	    n=3
	  then
		Result:="engine setup, "

	  elseif
	    n=4
	  then
	    Result:="power setup, "

	  elseif
		n=5
	  then
		Result:="setup summary, "
      end
    end

feature -- set
    set_abort_status(status:BOOLEAN)
      do
        set_abort:=status
      end

    set_debug_mode(status:BOOLEAN)
	  do
	    debug_mode:=status
	  end

	set_not_in_game_state(status:BOOLEAN)
	  do
	    not_in_game_state:=status
	  end

    set_not_enough_resources_state(status:BOOLEAN)
      do
      	not_enough_resources_state:=status
      end

    set_set_up_state(status:BOOLEAN)
      do
      	set_up_state:=status
      end

    set_not_in_setup_state(status:BOOLEAN)
    do
    	not_in_setup_state:=status
    end

    set_already_in_state(status:BOOLEAN)
    do
    	already_in_state:=status
    end

    set_select_range_state(status:BOOLEAN)
    do
    	select_range_state:=status
    end

    set_move_error_state(status:BOOLEAN)
    do
    	move_error_state:=status
    end

    set_play_error_state(status:BOOLEAN)
    do
        play_error_state:=status
    end

	set_error_message(message:STRING)
	  do
	    error_message:=message
	  end

	set_abort_message(message:STRING)
	  do
	    abort_message:=message
	  end

	set_not_in_game_message(message:STRING)
	  do
		not_in_game_message:=message
	  end

	set_not_enough_resources_message(message:STRING)
	  do
	  	not_enough_resources_message:=message
	  end

	set_not_in_setup_message(message:STRING)
	  do
		not_in_setup_message:=message
	  end

	set_already_in_message(message:STRING)
	  do
	  	already_in_message:=message
	  end

	set_select_range_message(message:STRING)
	do
		select_range_message:=message
	end

    set_move_error_message(message:STRING)
    do
    	move_error_message:=message
    end

    set_play_error_message(message:STRING)
    do
    	play_error_message:=message
    end

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	rest_i
	    do
	        i := 0
	    end

	error_update
	    do
	        error_i := error_i + 1
	    end

    reset_correct
        do
        	correct_i:=0
        end

	correct_update
	    do
	    	correct_i:=correct_i+1
	    end

    reset_error
        do
        	error_i:=0
        end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
		  create Result.make_from_string ("")
		  Result.append("  state:")

		  if
		    setup_state<=0 or set_abort
		  then
			Result.append("not started, ")

		  elseif
			1<=setup_state and setup_state<=5
		  then
			Result.append(setup_type_information(setup_state))

		  elseif
			setup_state>=6 and (not board.game_over)
		  then
			Result.append("in game")
		    Result.append("("+correct_i.out+"."+error_i.out+"), ")

		  else
			Result.append("not started, ")
	      end

		  if
		    debug_mode
		  then
		    Result.append("debug, ")

		  else
	        Result.append("normal, ")
		  end

          if
          	set_abort
          then
          	 Result.append(abort_message)

		  elseif
		    error_i>0 and (not_enough_resources_state=False) and (not_in_game_state=False) and (already_in_state=False) and (not_in_setup_state=False) and (select_range_state=False) and (not_enough_resources_state=False) and (move_error_state=False) and (play_error_state=False)
		  then
		    Result.append(error_message)

		  elseif
		      not_in_game_state
		  then
		  	  Result.append("error%N  ")
		      Result.append(not_in_game_message)

		  elseif
		  	  already_in_state
		  then
		  	  Result.append("error%N  ")
		      Result.append(already_in_message)

          elseif
          	  play_error_state
          then
          	  Result.append("error%N  ")
		      Result.append(play_error_message)

		  elseif
		  	  not_in_setup_state
		  then
              Result.append("error%N  ")
		      Result.append(not_in_setup_message)

          elseif
          	 select_range_state
          then
          	  Result.append("error%N  ")
		      Result.append(select_range_message)

          elseif
          	move_error_state
          then
          	Result.append("error%N  ")
		    Result.append(move_error_message)

		  elseif
		      not_enough_resources_state
		  then
		  	  Result.append("error%N  ")
		      Result.append(not_enough_resources_message)

		  else
		    Result.append("ok%N  ")
	        if
	          setup_state<=0
		    then
	     	  Result.append ("Welcome to Space Defender Version 2.")

		    elseif
		      setup_state=1
		    then
              Result.append (weapon.weapon_initial_information)
              Result.append("Weapon Selected:"+weapon.weapon_type)

	        elseif
		      setup_state=2
		    then
		      Result.append(armour.armour_initial_information)
              Result.append("Armour Selected:"+armour.armour_type)

		    elseif
	          setup_state=3
	        then
		      Result.append(engine.engine_initial_information)
              Result.append("Engine Selected:"+engine.engine_type)

		    elseif
		      setup_state=4
		    then
		      Result.append(power.power_initial_information)
		      Result.append("Power Selected:"+power.power_type)

		    elseif
		      setup_state=5
		    then
		      Result.append("Weapon Selected:"+weapon.weapon_type+"%N")
              Result.append("  Armour Selected:"+armour.armour_type+"%N")
              Result.append("  Engine Selected:"+engine.engine_type+"%N")
       	      Result.append("  Power Selected:"+power.power_type)

		    elseif
		      setup_state>=6 and (not board.game_over)
		    then
		      Result.append(board.out)

		    else
		      Result.append(board.out)
		    end
		end

end

end



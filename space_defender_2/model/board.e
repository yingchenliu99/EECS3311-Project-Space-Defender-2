note
	description: "Summary description for {BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOARD

inherit
	ANY

redefine
	out
	end

create

	make

feature -- make
    make(row:INTEGER; column:INTEGER; n1:INTEGER; n2:INTEGER; n3:INTEGER; n4:INTEGER; n5:INTEGER; star:STARFIGHTER)
    do
    	board_row:=row
    	board_column:=column
    	number1:=n1
    	number2:=n2
    	number3:=n3
    	number4:=n4
    	number5:=n5
    	starfighter:=star
    	create implement.make_filled('_',row,column)
    	row_letter:=<<'A', 'B', 'C', 'D','E', 'F', 'G', 'H', 'I', 'J'>>
    	create bullet_list.make
    	create enemy_list.make
    	create orb_list.make_empty
    	orb_position:=0
    	score:=0
    	friendly_bullet_action:=""
	    enemy_bullet_action:=""
	    starfighter_action:=""
	    enemy_action:=""
	    natural_enemy_spawn:=""
    end

feature -- attribute
	board_row:INTEGER
	board_column:INTEGER
	number1:INTEGER
	number2:INTEGER
	number3:INTEGER
	number4:INTEGER
	number5:INTEGER
	starfighter:STARFIGHTER

	implement:ARRAY2[CHARACTER]
	row_letter:ARRAY[CHARACTER]
	bullet_list:LINKED_LIST[BULLET]
	enemy_list:LINKED_LIST[ENEMY]
	orb_list:ARRAY[STRING]
	orb_position:INTEGER

	friendly_bullet_action:STRING
	enemy_bullet_action:STRING
	starfighter_action:STRING
	enemy_action:STRING
	natural_enemy_spawn:STRING

	score:INTEGER
	game_over:BOOLEAN

feature -- game finished
	set_game_over
	do
		game_over:=True
	end

feature -- turn
    turn(a:COMMAND)
    do
      if
      	starfighter.health_current>0
      then
      	friendly_projectiles_act
      end

      if
      	starfighter.health_current>0
      then
    	enemy_projectiles_act
      end

      if
      	starfighter.health_current>0
      then
    	starfighter_act(a)
      end

    	enemy_vision_update

      if
      	starfighter.health_current>0
      then
    	enemies_act
      end

    	enemy_vision_update

      if
      	starfighter.health_current>0
      then
    	enemy_spawn
      end
    end

feature -- set different action information
    set_friendly_bullet_action(information:STRING)
    do
    	friendly_bullet_action:=information
    end

	set_enemy_bullet_action(information:STRING)
	do
    	enemy_bullet_action:=information
    end

	set_starfighter_action(information:STRING)
	do
    	starfighter_action:=information
    end

	set_enemy_action(information:STRING)
	do
    	enemy_action:=information
    end

	set_natural_enemy_spawn(information:STRING)
	do
    	natural_enemy_spawn:=information
    end

feature -- bullet in board
    bullet_in_board(n:INTEGER):BOOLEAN
    do
      if
      	bullet_list[n].row>=1 and bullet_list[n].row<=board_row and bullet_list[n].column>=1 and bullet_list[n].column<=board_column
      then
      	Result:=True
      else
      	Result:=False
      end
    end

feature -- enemy in board
    enemy_in_board(n:INTEGER):BOOLEAN
    do
      if
      	enemy_list[n].row>=1 and enemy_list[n].row<=board_row and enemy_list[n].column >=1 and enemy_list[n].column<=board_column
      then
      	Result:=True
      else
      	Result:=False
      end
    end

feature{NONE} --action of different game
    friendly_projectiles_act
    do
      friendly_bullet_action:=""
      across 1 |..| bullet_list.count is number loop
        if
          attached {BULLET_SELF} bullet_list[number]
        then
          if
            bullet_in_board(number)
          then
        	friendly_bullet_action:=friendly_bullet_action+"%N    A friendly projectile(id:-"+number.out+") "
        	friendly_bullet_action:=friendly_bullet_action+"moves: ["+row_letter[bullet_list[number].row].out
        	friendly_bullet_action:=friendly_bullet_action+","+bullet_list[number].column.out+"] -> "
        	bullet_list[number].move
        	friendly_bullet_action:=friendly_bullet_action+bullet_list[number].str+bullet_list[number].message
           end
         end
       end
    end

    enemy_projectiles_act
    do
      enemy_bullet_action:=""
    	across 1 |..| bullet_list.count is number loop
        if
          attached {BULLET_ENEMY} bullet_list[number]
        then
          if
            bullet_in_board(number)
          then
        	enemy_bullet_action:=enemy_bullet_action+"%N    A enemy projectile(id:-"+number.out+") "
        	enemy_bullet_action:=enemy_bullet_action+"moves: ["+row_letter[bullet_list[number].row].out
        	enemy_bullet_action:=enemy_bullet_action+","+bullet_list[number].column.out+"] -> "
        	bullet_list[number].move
            enemy_bullet_action:=enemy_bullet_action+bullet_list[number].str+bullet_list[number].message
          end
        end
        end
    end

    starfighter_act(a:COMMAND)
    do
        enemy_action:=""
    	a.action
    end

    enemy_vision_update
    do
      across enemy_list is enemy_n loop
        if
          ((enemy_n.row-starfighter.row).abs+(enemy_n.column-starfighter.column).abs)<=enemy_n.vision
        then
          enemy_n.set_can_see_starfighter(True)
        else
          enemy_n.set_can_see_starfighter(False)
        end

        if
          ((enemy_n.row-starfighter.row).abs+(enemy_n.column-starfighter.column).abs)<=starfighter.vision_value
        then
          enemy_n.set_seen_by_starfighter(True)
        else
          enemy_n.set_seen_by_starfighter(False)
        end
      end
    end

    enemies_act
    do
      across enemy_list is en loop
        if
          en.row>=1 and en.row<=board_row and en.column >=1 and en.column<=board_column
        then
          en.action
        end
      end
    end

    enemy_spawn
    local
      first_number:INTEGER
      second_number:INTEGER
      rg:RANDOM_GENERATOR_ACCESS
      enemy_type:ENEMY
    do
      natural_enemy_spawn:=""
      first_number:=rg.rchoose(1, board_row)
      second_number:=rg.rchoose(1, 100)
    if
      not across enemy_list is enemy_n some
        enemy_n.row=first_number and enemy_n.column=board_column
      end
    then
      if
        second_number>=1 and second_number<number1
      then
        create {ENEMY_GRUNT}enemy_type.make(first_number,board_column)
        enemy_list.extend (enemy_type)
        natural_enemy_spawn:="%N    A Grunt(id:"+enemy_list.count.out+") spawns at location ["+ row_letter[first_number].out+","+board_column.out+"]."

      elseif
        second_number>=number1 and second_number<number2
      then
      	create {ENEMY_FIGHTER}enemy_type.make(first_number,board_column)
      	enemy_list.extend (enemy_type)
      	natural_enemy_spawn:="%N    A Fighter(id:"+enemy_list.count.out+") spawns at location ["+ row_letter[first_number].out+","+board_column.out+"]."

      elseif
        second_number>=number2 and second_number<number3
      then
      	create {ENEMY_CARRIER}enemy_type.make(first_number,board_column)
      	enemy_list.extend (enemy_type)
      	natural_enemy_spawn:="%N    A Carrier(id:"+enemy_list.count.out+") spawns at location ["+ row_letter[first_number].out+","+board_column.out+"]."

      elseif
        second_number>=number3 and second_number<number4
      then
      	create {ENEMY_INTERCEPTOR}enemy_type.make(first_number,board_column)
      	enemy_list.extend (enemy_type)
      	natural_enemy_spawn:="%N    A Interceptor(id:"+enemy_list.count.out+") spawns at location ["+ row_letter[first_number].out+","+board_column.out+"]."

      elseif
        second_number>=number4 and second_number<number5
      then
      	create {ENEMY_PYLON}enemy_type.make(first_number,board_column)
      	enemy_list.extend (enemy_type)
      	natural_enemy_spawn:="%N    A Pylon(id:"+enemy_list.count.out+") spawns at location ["+ row_letter[first_number].out+","+board_column.out+"]."
      end
    end
    end

feature -- enemy_information
    enemy_information(n:INTEGER):STRING
    do
      Result:=""
      Result:=Result+"%N    ["+n.out+","+enemy_list[n].enemy_symbols.out+"]"+"->"
	  Result:=Result+"health:"+enemy_list[n].current_health.out+"/"+enemy_list[n].health.out+", "
	  Result:=Result+"Regen:"+enemy_list[n].regen.out+", "
	  Result:=Result+"Armour:"+enemy_list[n].armour.out+", "
	  Result:=Result+"Vision:"+enemy_list[n].vision.out+", "
	  Result:=Result+"seen_by_Starfighter:"
	  if
		enemy_list[n].seen_by_starfighter
	  then
		Result:=Result+"T, "
	  else
		Result:=Result+"F, "
	  end
	  Result.append("can_see_Starfighter:")
	  if
		enemy_list[n].can_see_starfighter
	  then
		Result:=Result+"T, "
	  else
		Result:=Result+"F, "
	  end
	Result:=Result+"location:["+row_letter[enemy_list[n].row].out+","+enemy_list[n].column.out+"]"
    end

feature -- projectile information
    projectile_information(n:INTEGER):STRING
    do
      Result:=""
      Result:=Result+"%N    [-"+n.out+","+bullet_list[n].bullet_symbols.out+"]"+"->"
	  Result:=Result+"damage:"+bullet_list[n].bullet_damage.out+", move:"
	  Result:=Result+bullet_list[n].bullet_move.out+", location:"
	  Result:=Result+"["+row_letter[bullet_list[n].row].out+","+bullet_list[n].column.out+"]"
    end

feature -- five action information
   five_action_information:STRING
   do
   	  Result:=""
   	  Result:=Result+"%N  Friendly Projectile Action:"
      Result:=Result+friendly_bullet_action
      Result:=Result+"%N  Enemy Projectile Action:"
	  Result:=Result+enemy_bullet_action
	  Result:=Result+"%N  Starfighter Action:"
	  Result:=Result+starfighter_action
	  Result:=Result+"%N  Enemy Action:"
	  Result:=Result+enemy_action
	  Result:=Result+"%N  Natural Enemy Spawn:"
	  Result:=Result+natural_enemy_spawn
   end

feature -- in sight
    in_sight(row:INTEGER;column:INTEGER):BOOLEAN
    do
    if
      starfighter.vision_value>=(starfighter.row-row).abs + (starfighter.column-column).abs
    then
      Result:=True
    else
      Result:=False
    end
    end

feature{NONE} -- score
    set_score
    do
      score:=calculate_score
      orb_position:=1
    end

    calculate_score:INTEGER
    do
      if
      	orb_list.count=0
      then
      	Result:=0
      else
        from
      	  orb_position:=1
        until
      	  orb_position>orb_list.count
        loop
          if
      	    orb_list[orb_position]~"bronze"
          then
            Result:=Result+1
            orb_position:=orb_position+1
          elseif
      	    orb_list[orb_position]~"silver"
          then
            Result:=Result+2
            orb_position:=orb_position+1
          elseif
      	    orb_list[orb_position]~"gold"
          then
            Result:=Result+3
            orb_position:=orb_position+1
          elseif
      	    orb_list[orb_position]~"platinum"
          then
            Result:=Result+platinum_calculate_function
          elseif
      	    orb_list[orb_position]~"diamond"
          then
            Result:=Result+diamond_calculate_function
          end
        end
      end
    end

    platinum_calculate_function:INTEGER
    local
      p_position:INTEGER
    do
      p_position:=0
      Result:=1
      orb_position:=orb_position+1
      from
       	p_position:=1
      until
        p_position>2 or orb_position>orb_list.count
      loop
        if
      	  orb_list[orb_position]~"bronze"
        then
          Result:=Result+1
          orb_position:=orb_position+1
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"silver"
        then
          Result:=Result+2
          orb_position:=orb_position+1
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"gold"
        then
          Result:=Result+3
          orb_position:=orb_position+1
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"platinum"
        then
          Result:=Result+platinum_calculate_function
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"diamond"
        then
          Result:=Result+diamond_calculate_function
          p_position:=p_position+1
        end
      if
      	p_position=3
      then
      	Result:=Result*2
      end
      end
    end

    diamond_calculate_function:INTEGER
    local
      p_position:INTEGER
    do
      p_position:=0
      Result:=3
      orb_position:=orb_position+1
      from
       	p_position:=1
      until
        p_position>3 or orb_position>orb_list.count
      loop
        if
      	  orb_list[orb_position]~"bronze"
        then
          Result:=Result+1
          orb_position:=orb_position+1
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"silver"
        then
          Result:=Result+2
          orb_position:=orb_position+1
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"gold"
        then
          Result:=Result+3
          orb_position:=orb_position+1
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"platinum"
        then
          Result:=Result+platinum_calculate_function
          p_position:=p_position+1
        elseif
      	  orb_list[orb_position]~"diamond"
        then
          Result:=Result+diamond_calculate_function
          p_position:=p_position+1
        end
      if
      	p_position=4
      then
      	Result:=Result*3
      end
      end
    end

feature --print
	out:STRING
	local
	  model:ETF_MODEL_ACCESS
	do
      Result:=""
      set_score
      Result.append(starfighter.starfighter_information)
	  Result.append ("      score:"+score.out)

	if
	  model.m.debug_mode
	then
      Result.append ("%N  Enemy:")

	  across 1 |..| enemy_list.count is  number_e  loop
		if
		  enemy_in_board(number_e)
		then
		  Result.append(enemy_information(number_e))
		end
      end

      Result.append ("%N  Projectile:")
	  across 1 |..| bullet_list.count is  number_b  loop
		if
		  bullet_in_board(number_b)
		then
		   Result.append(projectile_information(number_b))
		end
      end

	  Result.append(five_action_information)
	end

    Result.append ("%N    ")
	across 1 |..| implement.width is column loop
	  if column<10 then
	 	Result.append("  "+column.out)
	  else
		Result.append(" "+column.out)
	  end
	end

	Result.append ("%N")
    across 1 |..| implement.height is row loop
	  Result.append("    "+row_letter[row].out)
		across 1 |..| implement.width is column loop
		   if
		   	 row=starfighter.row and column=starfighter.column
		   then
		     if
		      starfighter.health_current>0
		     then
		   	   if
		   	     starfighter.column<board_column
		   	   then
		   	     Result.append(" S ")
		   	   else
		   	     Result.append(" S")
		   	   end
		   	 else
		   	   if
		   	     starfighter.column<board_column
		   	   then
		   	     Result.append(" X ")
		   	   else
		   	     Result.append(" X")
		   	 end
		   end

		   elseif
		   	  across enemy_list is e_l some e_l.row=row and e_l.column=column and (e_l.seen_by_starfighter or model.m.debug_mode) end
		   then
		   	  across enemy_list is e_l loop
		   	    if
		   	      e_l.row=row and e_l.column=column and (e_l.seen_by_starfighter or model.m.debug_mode)
		   	    then
		   	      if e_l.column<board_column then
		   	      	 Result.append(" "+e_l.enemy_symbols.out+" ")
		   	      else
		   	      	 Result.append(" "+e_l.enemy_symbols.out)
		   	      end
		   	    end
		   	  end

		   elseif
		   	  across bullet_list is b_l some b_l.row=row and b_l.column=column and (in_sight(row,column) or model.m.debug_mode)end
		   then
		   	  across bullet_list is b_l loop
		   	    if
		   	      b_l.row=row and b_l.column=column and (in_sight(row,column) or model.m.debug_mode)
		   	    then
		   	      if b_l.column<board_column then
		   	        Result.append(" "+b_l.bullet_symbols.out+" ")
		   	      else
		   	        Result.append(" "+b_l.bullet_symbols.out)
		   	      end
                end
              end

            elseif
              not (in_sight(row,column) or model.m.debug_mode)
            then
              if
              	column<board_column
		   	  then
                Result.append (" ? ")
              else
		        Result.append(" ?")
		      end

		   	else
		   	  if
		   		column<board_column
		   	  then
		        Result.append(" "+implement[row,column].out+" ")
		      else
		        Result.append(" "+implement[row,column].out)
		      end
		    end
        end

        if
          row<board_row
        then
	      Result.append ("%N")
        end

	end
	if
	  game_over
	then
	  Result.append ("%N  The game is over. Better luck next time!")
	end
    end


end

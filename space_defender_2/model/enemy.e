note
	description: "Summary description for {ENEMY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENEMY

feature
    row : INTEGER
    column : INTEGER
	health : INTEGER
	current_health : INTEGER
	regen : INTEGER
	armour : INTEGER
	vision : INTEGER
	enemy_symbols : CHARACTER
	enemy_name : STRING
	enemy_number : INTEGER
	seen_by_starfighter : BOOLEAN
	can_see_starfighter : BOOLEAN
	message:STRING
	turn_end : BOOLEAN
	enemy_infront : BOOLEAN
	old_column:INTEGER
	orb : STRING


	model:ETF_MODEL_ACCESS

feature -- action
	action
	do
		if
		   (current_health+regen)<health
		then
		   current_health:=current_health+regen
		else
		   current_health:=health
		end

	    if
	      not turn_end
	    then

		if
		  can_see_starfighter
		then
          action_when_starfighter_is_seen
		else
          action_when_starfighter_is_not_seen
		end

		end

		turn_end:=False
	end

feature -- set turn end
	set_turn_end(b:BOOLEAN)
	do
		turn_end:=b
	end

feature-- four action
	preemptive_action_fire
	  deferred
	end

	preemptive_action_pass
	  deferred
	end

	preemptive_action_move
	  deferred
	end

	preemptive_action_special
	  deferred
	end

feature -- starfighter is seen or not
	action_when_starfighter_is_not_seen
	  deferred
	end

	action_when_starfighter_is_seen
	  deferred
	end

feature -- can see starfighter or seen by starfighter state
    can_see_starfighter_state
    do
      if
        ((row-model.m.board.starfighter.row).abs+(column-model.m.board.starfighter.column).abs)<=vision
      then
        set_can_see_starfighter(True)
      else
        set_can_see_starfighter(False)
      end
    end

    seen_by_starfighter_state
    do
      if
        ((row-model.m.board.starfighter.row).abs+(column-model.m.board.starfighter.column).abs)<=model.m.board.starfighter.vision_value
      then
   	    set_seen_by_starfighter(True)
      else
        set_seen_by_starfighter(False)
      end
    end

feature -- set can see starfighter or seen by starfighter
    set_can_see_starfighter(state:BOOLEAN)
    do
    	can_see_starfighter:=state
    end

    set_seen_by_starfighter(state:BOOLEAN)
    do
    	seen_by_starfighter:=state
    end

feature -- change health
	set_current_health(n:INTEGER)
	do
		current_health:=n
	end

feature -- disapper
    disapper
    do
      row:=-999
      column:=-999
    end

feature -- finded id
    finded_id(n:INTEGER;o_row:INTEGER;o_column:INTEGER):BOOLEAN
    do
    	if
    	  model.m.board.enemy_list[n].row=row and model.m.board.enemy_list[n].column=column and o_row>=1 and o_column>=1 and model.m.board.enemy_list[n]=current
    	then
    	  Result:=True
    	end
    end

    return_id(c_row:INTEGER;c_column:INTEGER):INTEGER
    do
      across 1|..| model.m.board.enemy_list.count is enemy_n loop
        if
          model.m.board.enemy_list[enemy_n].row=c_row and model.m.board.enemy_list[enemy_n].column=c_column
        then
    	  Result:=enemy_n
        end
      end
    end

feature -- enemy move information
   enemy_move_information(e_id:INTEGER;e_column:INTEGER;type:INTEGER)
     do
   	  if
        finded_id(e_id,row,e_column)
      then
      	if
      	  type=1
      	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Grunt(id:"+e_id.out+") moves: ")
       	elseif
       	  type=2
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Fighter(id:"+e_id.out+") moves: ")
       	elseif
       	  type=3
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Carrier(id:"+e_id.out+") moves: ")
       	elseif
       	  type=4
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Interceptor(id:"+e_id.out+") moves: ")
       	elseif
       	  type=5
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Pylon(id:"+e_id.out+") moves: ")
       	end
        model.m.board.set_enemy_action(model.m.board.enemy_action+"["+model.m.board.row_letter[row].out+","+(e_column).out+"]")
        if
          column>0
        then
          model.m.board.set_enemy_action(model.m.board.enemy_action+" -> ["+model.m.board.row_letter[row].out+","+column.out+"]")
        else
          model.m.board.set_enemy_action(model.m.board.enemy_action+" -> out of board")
        end
     end
     end

     enemy_stay_information(e_id:INTEGER;e_column:INTEGER;type:INTEGER)
     do
     	if
        finded_id(e_id,row,e_column)
      then
      	if
      	  type=1
      	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Grunt(id:"+e_id.out+") stays at: ")
       	elseif
       	  type=2
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Fighter(id:"+e_id.out+") stays at: ")
       	elseif
       	  type=3
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Carrier(id:"+e_id.out+") stays at: ")
       	elseif
       	  type=4
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Interceptor(id:"+e_id.out+") stays at: ")
       	elseif
       	  type=5
       	then
       	  model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Pylon(id:"+e_id.out+") stays at: ")
       	end
        model.m.board.set_enemy_action(model.m.board.enemy_action+"["+model.m.board.row_letter[row].out+","+(e_column).out+"]")
     end
     end

feature -- bullet collided with bullet
  collided_with_bullet(c_column:INTEGER;name:STRING)
  do
    across model.m.board.bullet_list is b_n  loop
	 if
	  b_n.row=row and b_n.column = c_column and attached{BULLET_SELF} b_n and b_n.row>=1 and b_n.row<=model.m.board.board_row and b_n.column >=1 and b_n.column<=model.m.board.board_column
	 then
	  b_n.disapper
	  message:=enemy_collided_with_bullet_information(b_n,c_column,enemy_number)
	  enemy_collided_with_bullet(b_n)
	 end
   end

	across model.m.board.bullet_list is b_n  loop
	  if
	    b_n.row=row and b_n.column = c_column and attached{BULLET_ENEMY} b_n and b_n.row>=1 and b_n.row<=model.m.board.board_row and b_n.column >=1 and b_n.column<=model.m.board.board_column
	  then
	  	b_n.disapper
	  	message:=enemy_collided_with_enemy_bullet_information(b_n,c_column,enemy_number)
	  	current_health:=current_health+b_n.bullet_damage
	  end
	end
  end

feature -- enemy collided with starfighter
  collided_with_starfighter(c_column:INTEGER)
  do
  	if
	  model.m.board.starfighter.row=row and model.m.board.starfighter.column=c_column
    then
      current_health:=0
	  disapper
	  model.m.board.orb_list.force (orb, model.m.board.orb_list.count+1)
	    if
	  	  model.m.board.starfighter.health_current-current_health>0
	  	then
	  	  model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-current_health)
	  	else
	  	  model.m.board.starfighter.set_health (0)
	  	  model.m.board.set_game_over
	  	end
	 end
  end

feature -- enemy collided with bullet
  enemy_collided_with_bullet_information(bullet_s:BULLET;c_column:INTEGER;type:INTEGER):STRING
  do
  	Result:=""
  	if
  	  type=1
  	then
	  Result:=Result+"%N      The Grunt collides with friendly projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
	elseif
	  type=2
	then
	  Result:=Result+"%N      The Fighter collides with friendly projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
	elseif
      type=3
    then
      Result:=Result+"%N      The Carrier collides with friendly projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
    elseif
      type=4
    then
      Result:=Result+"%N      The Interceptor collides with friendly projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
    elseif
      type=5
    then
      Result:=Result+"%N      The Pylon collides with friendly projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
	end
    Result:=Result+"at location ["+model.m.board.row_letter[row].out+","+c_column.out+"], "
	Result:=Result+"taking "+(bullet_s.bullet_damage-model.m.board.starfighter.value_armour).out+" damage."
  end

  enemy_collided_with_enemy_bullet_information(bullet_s:BULLET;c_column:INTEGER;type:INTEGER):STRING
  do
  	Result:=""
  	if
  	  type=1
  	then
	  Result:=Result+"%N      The Grunt collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
	elseif
	  type=2
	then
	  Result:=Result+"%N      The Fighter collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
	elseif
      type=3
    then
      Result:=Result+"%N      The Carrier collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
    elseif
      type=4
    then
      Result:=Result+"%N      The Interceptor collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
    elseif
      type=5
    then
      Result:=Result+"%N      The Pylon collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
	end
    Result:=Result+"at location ["+model.m.board.row_letter[row].out+","+c_column.out+"], "
	Result:=Result+"healing "+(bullet_s.bullet_damage-model.m.board.starfighter.value_armour).out+" damage."
  end

  enemy_collided_with_bullet(bullet_s:BULLET)
  do
  	if
	  current_health>bullet_s.bullet_damage-armour
	then
	  current_health:=current_health-(bullet_s.bullet_damage-armour)
	else
	  current_health:=0
	  disapper
	end
  end

  enemy_collided_with_enemy_bullet(enemy_bullet:BULLET)
  do
  	across model.m.board.enemy_list is enemy_n loop
      if
        enemy_n.row=enemy_bullet.row and enemy_n.column=enemy_bullet.column
      then
        enemy_bullet.disapper
        message:=message+"%N      The projectile collides with "+enemy_n.enemy_name+"(id:"+model.m.board.enemy_list.index_of(enemy_n,1).out+") "
  	    message:=message+"at location ["+model.m.board.row_letter[enemy_n.row].out+","+enemy_n.column.out+"], "
  	    message:=message+"healing "+enemy_bullet.bullet_damage.out+" damage."
        if
          enemy_n.current_health+enemy_bullet.bullet_damage<=enemy_n.health
        then
          enemy_n.set_current_health(enemy_n.current_health+enemy_bullet.bullet_damage)
        else
          enemy_n.set_current_health(enemy_n.health)
        end
      end
    end
  end

  enemy_bullet_collided_with_enemy(c_row:INTEGER;c_column:INTEGER)
  do
  	across model.m.board.bullet_list is bullet_n loop
      if
        c_row=bullet_n.row and c_column=bullet_n.column
      then
        bullet_n.disapper
        message:=message+"%N      The projectile collides with Interceptor(id:"+return_id(c_row,c_column).out+") "
  	    message:=message+"at location ["+model.m.board.row_letter[c_row].out+","+c_column.out+"], "
  	    message:=message+"healing "+bullet_n.bullet_damage.out+" damage."
        if
          current_health+bullet_n.bullet_damage<=health
        then
          set_current_health(current_health+bullet_n.bullet_damage)
        else
          set_current_health(health)
        end
      end
     end
  end

end

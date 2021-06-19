note
	description: "Summary description for {ENEMY_INTERCEPTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_INTERCEPTOR

inherit
	ENEMY

create

    make

feature
    make(r:INTEGER;c:INTEGER)
    do
    row:=r
    column:=c
	health:=50
	current_health := health
	regen:=0
	armour:=0
	vision:=5
	enemy_symbols:='I'
	enemy_name:="Interceptor"
	enemy_number:=4
	message:=""
	orb:="bronze"
	turn_end:=False
    can_see_starfighter_state
    seen_by_starfighter_state

    end

feature
	preemptive_action_fire
	local
	  current_row:INTEGER
	  old_row:INTEGER
	do
	  message:=""
	  enemy_infront:=False
	from
	  current_row:=row
	  old_row:=row
	until
	  current_row=model.m.board.starfighter.row or current_health<=0 or enemy_infront or current_row>model.m.board.board_row or current_row<0
	loop
	  current_row:=current_row_change(current_row)
	  if
	    not (current_row>model.m.board.board_row or current_row<=0)
	  then
	   interceptor_collided_with_bullet(current_row,enemy_name)
       interceptor_collided_with_starfighter(current_row)

	  end
	end
      row:=current_row
	across 1 |..| model.m.board.enemy_list.count is enemy_n loop

	if
	  row=old_row
	then
      if
        model.m.board.enemy_list[enemy_n].row=row and model.m.board.enemy_list[enemy_n].column=column and old_row>=1 and column>=1 and model.m.board.enemy_list[enemy_n]=current
      then
      	 model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Interceptor(id:"+enemy_n.out+") stays at: ")
      	 model.m.board.set_enemy_action(model.m.board.enemy_action+"["+model.m.board.row_letter[old_row].out+","+column.out+"]")
      	 if
          row>0
         then
          model.m.board.set_enemy_action(model.m.board.enemy_action+" -> ["+model.m.board.row_letter[row].out+","+column.out+"]")
         else
          model.m.board.set_enemy_action(model.m.board.enemy_action+" -> out of board")
         end
       end
    else
        if
          model.m.board.enemy_list[enemy_n].row=row and model.m.board.enemy_list[enemy_n].column=column and old_row>=1 and column>=1 and model.m.board.enemy_list[enemy_n]=current
        then
          model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Interceptor(id:"+enemy_n.out+") moves: ")
          model.m.board.set_enemy_action(model.m.board.enemy_action+"["+model.m.board.row_letter[old_row].out+","+column.out+"]")
          if
            row>0
          then
            model.m.board.set_enemy_action(model.m.board.enemy_action+" -> ["+model.m.board.row_letter[row].out+","+column.out+"]")
          else
            model.m.board.set_enemy_action(model.m.board.enemy_action+" -> out of board")
          end
         end
     end
     end
	model.m.board.set_enemy_action (model.m.board.enemy_action+message)
	set_turn_end(True)

	end


	preemptive_action_pass
	do

	end

	preemptive_action_move
	do

	end

	preemptive_action_special
	do

	end


	action_when_starfighter_is_not_seen
    local
	  current_column:INTEGER
	do
      enemy_infront:=False
      message:=""
      from
	  	current_column:=column
	  	old_column:=column
	  until
	  	current_health<=0 or current_column=column-3 or enemy_infront or current_column>model.m.board.board_column or current_column<=0
	  loop
	  	if
	  	  not across model.m.board.enemy_list is e_n some e_n.row=row and e_n.column=current_column-1 end
	  	then
	  	  current_column:=current_column-1
	  	else
	  	  enemy_infront:=True
	  	end
        collided_with_bullet(current_column,enemy_name)
        collided_with_starfighter(current_column)

	  end
      column:=current_column
      across 1 |..| model.m.board.enemy_list.count is enemy_n loop
      if
      	column=old_column
      then
      	enemy_stay_information(enemy_n,old_column,model.m.board.enemy_list[enemy_n].enemy_number)
      else
        enemy_move_information(enemy_n,old_column,model.m.board.enemy_list[enemy_n].enemy_number)
      end
      end
      model.m.board.set_enemy_action (model.m.board.enemy_action+message)
	end

	action_when_starfighter_is_seen
    local
	  current_column:INTEGER
	do
      enemy_infront:=False
      message:=""
      from
	  	current_column:=column
	  	old_column:=column
	  until
	  	current_health<=0 or current_column=column-3 or enemy_infront or current_column>model.m.board.board_column or current_column<=0
	  loop
	  	if
	  	  not across model.m.board.enemy_list is e_n some e_n.row=row and e_n.column=current_column-1 end
	  	then
	  	  current_column:=current_column-1
	  	else
	  	  enemy_infront:=True
	  	end
        collided_with_bullet(current_column,enemy_name)
        collided_with_starfighter(current_column)

	  end
      column:=current_column
      across 1 |..| model.m.board.enemy_list.count is enemy_n loop
      if
      	column=old_column
      then
      	enemy_stay_information(enemy_n,old_column,model.m.board.enemy_list[enemy_n].enemy_number)
      else
        enemy_move_information(enemy_n,old_column,model.m.board.enemy_list[enemy_n].enemy_number)
      end
      end
      model.m.board.set_enemy_action (model.m.board.enemy_action+message)
	end


feature -- current row change
  current_row_change(n:INTEGER):INTEGER
  do
  	Result:=0
  	if
  	  model.m.board.starfighter.row>row
  	then
  	  if
  	  	not across model.m.board.enemy_list is enemy_n some enemy_n.column=column and enemy_n.row=n+1  end
  	  then
  	  	Result:=n+1
  	  else
  	  	enemy_infront:=True
  	  end

  	elseif
  	  model.m.board.starfighter.row<row
  	then
  	  if
  	  	not across model.m.board.enemy_list is enemy_n some enemy_n.column=column and enemy_n.row=n-1  end
  	  then
  	  	Result:=n-1
  	  else
  	  	enemy_infront:=True
  	  end
  	end
  end

  interceptor_collided_with_bullet(c_row:INTEGER;name:STRING)
  do
    across model.m.board.bullet_list is b_n  loop
	 if
	  b_n.row=c_row and b_n.column = column and attached{BULLET_SELF} b_n and b_n.row>=1 and b_n.row<=model.m.board.board_row and b_n.column >=1 and b_n.column<=model.m.board.board_column
	 then
	  b_n.disapper
	  message:=interceptor_collided_with_bullet_information(b_n,c_row)
	  enemy_collided_with_bullet(b_n)
	 end
   end

	across model.m.board.bullet_list is b_n  loop
	  if
	    b_n.row=c_row and b_n.column = column and attached{BULLET_ENEMY} b_n and b_n.row>=1 and b_n.row<=model.m.board.board_row and b_n.column >=1 and b_n.column<=model.m.board.board_column
	  then
	  	b_n.disapper
	  	message:=interceptor_collided_with_enemy_bullet_information(b_n,c_row)
	  	current_health:=current_health+b_n.bullet_damage
	  end
	end
  end

feature -- enemy collided with starfighter
  interceptor_collided_with_starfighter(c_row:INTEGER)
  do
  	if
	  model.m.board.starfighter.row=c_row and model.m.board.starfighter.column=column
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

  interceptor_collided_with_bullet_information(bullet_s:BULLET;c_row:INTEGER):STRING
  do
  	Result:=""
    Result:=Result+"%N      The Interceptor collides with friendly projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
    Result:=Result+"at location ["+model.m.board.row_letter[c_row].out+","+column.out+"], "
	Result:=Result+"taking "+(bullet_s.bullet_damage-model.m.board.starfighter.value_armour).out+" damage."
  end

  interceptor_collided_with_enemy_bullet_information(bullet_s:BULLET;c_row:INTEGER):STRING
  do
  	Result:=""
    Result:=Result+"%N      The Interceptor collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(bullet_s,1).out+") "
    Result:=Result+"at location ["+model.m.board.row_letter[c_row].out+","+column.out+"], "
	Result:=Result+"healing "+(bullet_s.bullet_damage-model.m.board.starfighter.value_armour).out+" damage."
  end



end


note
	description: "Summary description for {ENEMY_CARRIER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_CARRIER


inherit
	ENEMY

create

    make

feature
    make(r:INTEGER;c:INTEGER)
    do
    row:=r
    column:=c
	health:=200
	current_health := health
	regen:=10
	armour:=15
	vision:=15
	enemy_symbols:='C'
	enemy_name:="Carrier"
	enemy_number:=3
	message:=""
	orb:="diamond"
	turn_end:=False
    can_see_starfighter_state
    seen_by_starfighter_state
    end

feature
	preemptive_action_fire
	do

	end

	preemptive_action_pass
    local
    current_column:INTEGER
    new_enemy1:ENEMY_INTERCEPTOR
    new_enemy2:ENEMY_INTERCEPTOR
	do
	  enemy_infront:=False
	  message:=""
	  from
	  	current_column:=column
	  	old_column:=column
	  until
	  	current_health<=0 or current_column=column-2 or enemy_infront or current_column>model.m.board.board_column or current_column<=0
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
      if
        column>=1
      then
      	if
      	  not across model.m.board.enemy_list is enemy_n  some enemy_n.row=row-1 and enemy_n.column=column end
      	then
          create{ENEMY_INTERCEPTOR}new_enemy1.make(row-1, column)
          model.m.board.enemy_list.extend(new_enemy1)
          model.m.board.set_enemy_action (model.m.board.enemy_action+"%N      A Interceptor(id:"+model.m.board.enemy_list.index_of(new_enemy1,1).out+") ")
          model.m.board.set_enemy_action (model.m.board.enemy_action+"spawns at location ["+model.m.board.row_letter[new_enemy1.row].out+","+new_enemy1.column.out+"].")
          collided_with_bullet(column,new_enemy1.enemy_name)
          enemy_bullet_collided_with_enemy(row+1,column)
          collided_with_starfighter(column)
          new_enemy1.set_turn_end (True)
        end

        if
      	  not across model.m.board.enemy_list is enemy_n  some enemy_n.row=row+1 and enemy_n.column=column end
      	then
          create{ENEMY_INTERCEPTOR}new_enemy2.make(row+1, column)
          model.m.board.enemy_list.extend(new_enemy2)
          model.m.board.set_enemy_action (model.m.board.enemy_action+"%N      A Interceptor(id:"+model.m.board.enemy_list.index_of(new_enemy2,1).out+") ")
          model.m.board.set_enemy_action (model.m.board.enemy_action+"spawns at location ["+model.m.board.row_letter[new_enemy2.row].out+","+new_enemy2.column.out+"].")
          collided_with_bullet(column,new_enemy2.enemy_name)
          enemy_bullet_collided_with_enemy(row+1,column)
          collided_with_starfighter(column)
          new_enemy2.set_turn_end (True)
        end
      end
      set_turn_end (True)
	end

	preemptive_action_move
	do

	end

	preemptive_action_special
	do
      regen:=regen+10
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
	  	current_health<=0 or current_column=column-2 or enemy_infront or current_column>model.m.board.board_column or current_column<=0
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
		new_enemy:ENEMY_INTERCEPTOR
	do
	  enemy_infront:=False
	  message:=""
	  from
	  	current_column:=column
	  	old_column:=column
	  until
	  	current_health<=0 or current_column=column-1 or enemy_infront or current_column>model.m.board.board_column or current_column<=0
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
      if
        column>=1
      then
      	if
      	  not across model.m.board.enemy_list is enemy_n  some enemy_n.row=row-1 and enemy_n.column=column end
      	then
          create{ENEMY_INTERCEPTOR}new_enemy.make(row-1, column)
          model.m.board.enemy_list.extend(new_enemy)
          collided_with_bullet(column,new_enemy.enemy_name)
          enemy_bullet_collided_with_enemy(row+1,column)
          collided_with_starfighter(column)
          new_enemy.set_turn_end (True)
        end
      end
	end

end

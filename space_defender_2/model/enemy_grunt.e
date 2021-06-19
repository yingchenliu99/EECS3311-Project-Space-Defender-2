note
	description: "Summary description for {ENEMY_GRUNT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_GRUNT

inherit
	ENEMY

create

    make

feature
    make(r:INTEGER;c:INTEGER)
    do
    row:=r
    column:=c
	health:=100
	current_health := health
	regen:=1
	armour:=1
	vision:=5
	enemy_symbols:='G'
	enemy_name:="Grunt"
	enemy_number:=1
	message:=""
	orb:="silver"
	turn_end:=False
    can_see_starfighter_state
    seen_by_starfighter_state
    end

feature -- preemptive action
	preemptive_action_fire
	do

	end


	preemptive_action_pass
	do
      health:=health+10
      current_health:=current_health+10
      across 1 |..| model.m.board.enemy_list.count is enemy_n loop
         if
            model.m.board.enemy_list[enemy_n]=current
         then
         	model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Grunt(id:"+enemy_n.out+") gains 10 total health.")
         end
      end
	end

	preemptive_action_move
	do

	end

	preemptive_action_special
	do
      health:=health+20
      current_health:=current_health+20
      across 1 |..| model.m.board.enemy_list.count is enemy_n loop
         if
            model.m.board.enemy_list[enemy_n]=current
         then
         	model.m.board.set_enemy_action(model.m.board.enemy_action+"%N    A Grunt(id:"+enemy_n.out+") gains 20 total health.")
         end
      end
	end

feature -- action
	action_when_starfighter_is_not_seen
	local
		enemy_bullet:BULLET_ENEMY
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
	  	if
	  	  not (current_column>model.m.board.board_column or current_column<=0)
	  	then
          collided_with_bullet(current_column,enemy_name)
          collided_with_starfighter(current_column)
        end
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
        create{BULLET_ENEMY}enemy_bullet.make(row, column-1, 0, -1, 15, 4)
        model.m.board.bullet_list.extend(enemy_bullet)
        model.m.board.set_enemy_action(model.m.board.enemy_action+"%N      A enemy projectile(id:-"+model.m.board.bullet_list.count.out+") ")
        model.m.board.set_enemy_action(model.m.board.enemy_action+"spawns at location ["+model.m.board.row_letter[row].out+","+(column-1).out+"].")
        if
          enemy_bullet.row>=1 and enemy_bullet.row<=model.m.board.board_row and enemy_bullet.column>=1 and enemy_bullet.column<=model.m.board.board_column
        then
          message:=""
          collided_with_bullet(current_column,enemy_name)
          enemy_collided_with_enemy_bullet(enemy_bullet)
          collided_with_starfighter(current_column)
          model.m.board.set_enemy_action (model.m.board.enemy_action+message)
        end
      end
	end

	action_when_starfighter_is_seen
	local
		enemy_bullet:BULLET_ENEMY
		current_column:INTEGER
	do
      enemy_infront:=False
      message:=""
      from
	  	current_column:=column
	  	old_column:=column
	  until
	  	current_health<=0 or current_column=column-4 or enemy_infront or current_column>model.m.board.board_column or current_column<=0
	  loop
	  	if
	  	  not across model.m.board.enemy_list is e_n some e_n.row=row and e_n.column=current_column-1 end
	  	then
	  	  current_column:=current_column-1
	  	else
	  	  enemy_infront:=True
	  	end

	  	if
	  	  not (current_column>model.m.board.board_column or current_column<=0)
	  	then
          collided_with_bullet(current_column,enemy_name)
          collided_with_starfighter(current_column)
        end
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
        create{BULLET_ENEMY}enemy_bullet.make(row, column-1, 0, -1, 15, 4)
        model.m.board.bullet_list.extend (enemy_bullet)
        model.m.board.set_enemy_action (model.m.board.enemy_action+"%N      A Grunt(id:"+model.m.board.bullet_list.count.out+") ")
        model.m.board.set_enemy_action (model.m.board.enemy_action+"spawns at locatin ["+model.m.board.row_letter[row].out+","+(column-1).out+"]")
        if
          enemy_bullet.row>=1 and enemy_bullet.row<=model.m.board.board_row and enemy_bullet.column>=1 and enemy_bullet.column<=model.m.board.board_column
        then
          message:=""
          collided_with_bullet(current_column,enemy_name)
          enemy_collided_with_enemy_bullet(enemy_bullet)
          collided_with_starfighter(current_column)
          model.m.board.set_enemy_action (model.m.board.enemy_action+message)
        end
      end
	end

end


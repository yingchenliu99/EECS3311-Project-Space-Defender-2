note
	description: "Summary description for {ENEMY_PYLON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENEMY_PYLON

inherit
	ENEMY

create

    make

feature
    make(r:INTEGER;c:INTEGER)
    do
    row:=r
    column:=c
	health:=300
	current_health := health
	regen:=0
	armour:=0
	vision:=5
	enemy_symbols:='P'
	enemy_name:="Pylon"
	enemy_number:=5
	message:=""
	orb:="platinum"
    can_see_starfighter_state
    seen_by_starfighter_state

    end

feature
	preemptive_action_fire
	do

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
      	heal_enemy
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
        create{BULLET_ENEMY}enemy_bullet.make (row, column-1, 0, -1, 15, 4)
        model.m.board.bullet_list.extend (enemy_bullet)
        model.m.board.set_enemy_action (model.m.board.enemy_action+"%N      A Pylon(id:"+model.m.board.bullet_list.count.out+") ")
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


feature -- healing
  heal_enemy
  do
  	across model.m.board.enemy_list is enemy_n loop
  	  if
  	    ((enemy_n.row-row).abs+(enemy_n.column-column).abs)<=vision
  	  then
  	  	if
  	  	  enemy_n.current_health+10 > enemy_n.health
  	  	then
          enemy_n.set_current_health(enemy_n.health)
        else
          enemy_n.set_current_health(enemy_n.current_health+10)
  	  	end
  	  	model.m.board.set_enemy_action (model.m.board.enemy_action+"%N      The Pylon heals "+enemy_n.enemy_name+"(id:"+model.m.board.enemy_list.index_of(enemy_n,1).out+") ")
  	  	model.m.board.set_enemy_action (model.m.board.enemy_action+"at location ["+model.m.board.row_letter[enemy_n.row].out+","+enemy_n.column.out+"] for 10 damage.")
  	  end
  	end
  end




end

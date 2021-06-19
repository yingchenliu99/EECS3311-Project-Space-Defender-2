note
	description: "Summary description for {COMMAND_MOVE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_MOVE

inherit
	COMMAND

create

	make

feature
    make(r:INTEGER; c:INTEGER)
    do
      row:=r
      column:=c
    end

feature
	row:INTEGER
	column:INTEGER

feature
	action
	local
	  current_row:INTEGER
	  current_column:INTEGER
	  message:STRING
	do
	  message:=""
	  restoring_health(1)
      restoring_energy(1)

      model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) moves: [")
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.row_letter[model.m.board.starfighter.row].out+",")
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.starfighter.column.out+"] -> ")
      from
      	current_row:=model.m.board.starfighter.row
      	current_column:=model.m.board.starfighter.column
      until
      	model.m.board.starfighter.health_current<=0 or (current_row=row and current_column=column)
      loop
      	if
      	  row=current_row
      	then
      	  current_column:=current_column+(column-current_column)//(column-current_column).abs
      	else
      		current_row:=current_row+(row-current_row)//(row-current_row).abs
      	end

      	across
      		model.m.board.bullet_list is b_n loop
      		if
      		  b_n.row=current_row and b_n.column=current_column
      		then
      		  message:=message+"%N      The Starfighter collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of (b_n,1).out+") "
      		  message:=message+"at location ["+model.m.board.row_letter[b_n.row].out+","+b_n.column.out+"], "
      		  message:=message+"taking "+(b_n.bullet_damage-model.m.board.starfighter.value_armour).out+" damage."
      		  if
      		  	model.m.board.starfighter.health_current-(b_n.bullet_damage-model.m.board.starfighter.value_armour)>0
      		  then
      		    model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-(b_n.bullet_damage-model.m.board.starfighter.value_armour))
      		  else
      		  	message:=message+"%N      The Starfighter at location ["+model.m.board.row_letter[current_row].out+","+current_column.out+"] has been destoryed."
      		  end
      		  b_n.disapper
      		end
      	end

      	across
      		model.m.board.enemy_list is e_n loop
      		if
      		  e_n.row=current_row and e_n.column=current_column
      		then
      		  message:=message+"%N      The Starfighter collides with "+e_n.enemy_name+"(id:"+model.m.board.enemy_list.index_of (e_n,1).out+") "
      		  message:=message+"at location ["+model.m.board.row_letter[e_n.row].out+","+e_n.column.out+"], "
      		  message:=message+"trading "+e_n.current_health.out+" damage."
      		  message:=message+"%N      The "+e_n.enemy_name+" at location ["+model.m.board.row_letter[e_n.row].out+","+e_n.column.out+"] has been destroyed."
      		  if
      		  	model.m.board.starfighter.health_current-e_n.current_health>0
      		  then
      		  	model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-e_n.current_health)
      		  else
      		  	message:=message+"%N      The Starfighter at location ["+model.m.board.row_letter[current_row].out+","+current_column.out+"] has been destroyed."
      		  	model.m.board.starfighter.set_health(0)
      		  end
      		  model.m.board.orb_list.force (e_n.orb, model.m.board.orb_list.count+1)
      		  e_n.disapper
      		end
      	end
      end

        model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-((model.m.board.starfighter.row-current_row).abs+(model.m.board.starfighter.column-current_column).abs)*model.m.board.starfighter.move_cost)

      	if
      	  model.m.board.starfighter.health_current>0
      	then
      	  model.m.board.starfighter.set_move (row, column)
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+"["+model.m.board.row_letter[model.m.board.starfighter.row].out+",")
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.starfighter.column.out+"]")
      	else
      	  model.m.board.starfighter.set_move (current_row, current_column)
      	  model.m.board.set_starfighter_action (model.m.board.starfighter_action+"["+model.m.board.row_letter[model.m.board.starfighter.row].out+",")
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.starfighter.column.out+"]")
          model.m.board.set_game_over
      	end

      model.m.board.set_starfighter_action(model.m.board.starfighter_action+message)
      across model.m.board.enemy_list is enemy_n loop
         enemy_n.preemptive_action_move
      end
	end

end

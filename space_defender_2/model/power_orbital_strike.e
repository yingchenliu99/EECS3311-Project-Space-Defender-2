note
	description: "Summary description for {POWER_ORBITAL_STRIKE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_ORBITAL_STRIKE

inherit
	POWER

create

	make

feature
	make
	do

	end

feature
	power_type:STRING
	do
		Result:="Orbital Strike (100 energy): Deal 100 damage to all enemies, affected by armour."
	end

	power_action
	do
	model.m.set_not_enough_resources_state (False)
		if
		  model.m.board.starfighter.energy_current>=100
	    then
	 	  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-100)
		  model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) uses special, unleashing a wave of energy")
          across 1 |..| model.m.board.enemy_list.count is n_enemy loop
            if
              model.m.board.enemy_in_board(n_enemy)
            then
       	      model.m.board.set_starfighter_action (model.m.board.starfighter_action+"%N      A "+model.m.board.enemy_list[n_enemy].enemy_name+"(id:"+n_enemy.out+") " )
      	      model.m.board.set_starfighter_action (model.m.board.starfighter_action+"at location ["+model.m.board.row_letter[model.m.board.enemy_list[n_enemy].row].out+",")
              model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.enemy_list[n_enemy].column.out+"]")
              model.m.board.set_starfighter_action (model.m.board.starfighter_action+" takes " + (100-model.m.board.enemy_list[n_enemy].armour).out +" damage")
              model.m.board.enemy_list[n_enemy].set_current_health (model.m.board.enemy_list[n_enemy].current_health-(100-model.m.board.enemy_list[n_enemy].armour))
                if
                  model.m.board.enemy_list[n_enemy].current_health<=0
                then
           	      model.m.board.enemy_list[n_enemy].disapper
                end
            end
          end
      else
		  model.m.set_not_enough_resources_state (True)
      end
   end


end

note
	description: "Summary description for {POWER_DEPLOY_DRONES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_DEPLOY_DRONES

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
		Result:="Deploy Drones (100 energy): Clear all projectiles."
	end

	power_action
	do
	model.m.set_not_enough_resources_state (False)
		if
		  model.m.board.starfighter.energy_current>=100
	    then
	      model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-100)
          model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) uses special, clearing projectiles with drones.")
          across 1 |..| model.m.board.bullet_list.count is number loop
      	    if
      	      model.m.board.bullet_list[number].row<=model.m.board.board_row and model.m.board.bullet_list[number].column<=model.m.board.board_column
      	    then
      	      model.m.board.set_starfighter_action (model.m.board.starfighter_action+"%N      A projectile(id:-"+number.out+") " )
      	      model.m.board.set_starfighter_action (model.m.board.starfighter_action+"at location ["+model.m.board.row_letter[model.m.board.bullet_list[number].row].out+",")
              model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.bullet_list[number].column.out+"] has been neutralized.")
              model.m.board.bullet_list[number].disapper
            end
           end
         else
		  model.m.set_not_enough_resources_state (True)
         end
	end

end

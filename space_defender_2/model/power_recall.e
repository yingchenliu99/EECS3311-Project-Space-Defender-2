note
	description: "Summary description for {POWER_RECALL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_RECALL

inherit
	POWER

create

	make

feature
	make
	do

	end

    power_type:STRING
	do
		Result:="Recall (50 energy): Teleport back to spawn."
	end

	power_action
	do
	model.m.set_not_enough_resources_state (False)
		if
		  model.m.board.starfighter.energy_current>=50
	    then
          model.m.board.starfighter.set_move ((model.m.board.board_row+1)//2, 1)
          model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-50)
          model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) uses special, teleporting to: [")
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.row_letter[(model.m.board.board_row+1)//2].out+",")
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.starfighter.column.out+"]")
        else
		  model.m.set_not_enough_resources_state (True)
        end
	end
end

note
	description: "Summary description for {COMMAND_FIRE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_FIRE

inherit
	COMMAND

create

	make

feature
    make
    do

    end

feature
	action
	do
	  restoring_health(1)
	  restoring_energy(1)

      model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) fires at location [")
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.row_letter[model.m.board.starfighter.row].out+",")
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.starfighter.column.out+"].")

      model.m.board.starfighter.weapon.fire_action
      across model.m.board.enemy_list is enemy_n loop
         enemy_n.preemptive_action_fire
      end
	end

end

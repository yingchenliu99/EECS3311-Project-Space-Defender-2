note
	description: "Summary description for {COMMAND_SPECIAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_SPECIAL

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

      model.m.board.starfighter.power.power_action

      across model.m.board.enemy_list is enemy_n loop
         enemy_n.preemptive_action_special
      end

	end


end

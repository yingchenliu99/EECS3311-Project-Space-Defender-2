note
	description: "Summary description for {COMMAND_PASS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND_PASS

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
      restoring_health(2)
      restoring_energy(2)

      model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) passes at location [")
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.row_letter[model.m.board.starfighter.row].out+",")
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.starfighter.column.out+"], doubling regen rate.")

      across model.m.board.enemy_list is enemy_n loop
         if
         	enemy_n.row>=1 and enemy_n.row<=model.m.board.board_row and enemy_n.column>=1 and enemy_n.column<=model.m.board.board_column
         then
         	enemy_n.preemptive_action_pass
         end
      end
	end


end

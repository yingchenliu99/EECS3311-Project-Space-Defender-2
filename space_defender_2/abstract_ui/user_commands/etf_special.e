note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SPECIAL
inherit
	ETF_SPECIAL_INTERFACE
create
	make
feature -- command
	special
	    local
    		action_special:COMMAND_SPECIAL
    	do
		  model.set_already_in_state (False)
		  model.set_abort_status(False)
		  model.set_not_in_game_state (False)
		  model.set_not_in_setup_state(False)
		  model.set_select_range_state (False)
		  model.set_move_error_state (False)
		  model.set_play_error_state (False)
			-- perform some update on the model state
		if
		  model.i=0 or model.set_up_state
		then
		  model.set_not_in_game_state (True)
		  model.set_not_in_game_message ("Command can only be used in game.")
		else
	      create{COMMAND_SPECIAL}action_special.make
		  model.board.turn (action_special)
		  model.set_set_up_state (False)
		if
		  model.not_enough_resources_state=False
		then
		  model.reset_error
		  model.correct_update
		  model.default_update
		else
          model.error_update
          model.set_not_enough_resources_message ("Not enough resources to use special.")
		end
		  etf_cmd_container.on_change.notify ([Current])
		end
    	end

end

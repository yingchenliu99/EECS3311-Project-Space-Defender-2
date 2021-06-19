note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PASS
inherit
	ETF_PASS_INTERFACE
create
	make
feature -- command
	pass
	    local
    		action_pass:COMMAND_PASS
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
			create{COMMAND_PASS}action_pass.make
			model.board.turn (action_pass)
			model.set_set_up_state (False)
			model.reset_error
			model.correct_update
			model.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end
    	end

end

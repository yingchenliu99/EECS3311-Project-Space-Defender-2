note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ABORT
inherit
	ETF_ABORT_INTERFACE
create
	make
feature -- command
	abort
    	do
    	model.set_abort_status(False)
		model.set_already_in_state (False)
		model.set_set_up_state (False)
		model.set_not_in_setup_state(False)
		model.set_select_range_state (False)
		model.set_move_error_state (False)
		model.set_play_error_state (False)
			-- perform some update on the model state
        if
		  model.i=0
		then
		  model.set_not_in_game_state (True)
		  model.set_not_in_game_message ("Command can only be used in setup mode or in game")
		else
			model.set_abort_status(True)
            model.set_abort_message("ok%N"+"  Exited from game.")
            model.reset
			model.reset_correct
			etf_cmd_container.on_change.notify ([Current])
    	end
    	end

end

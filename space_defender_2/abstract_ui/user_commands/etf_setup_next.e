note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_NEXT
inherit
	ETF_SETUP_NEXT_INTERFACE
create
	make
feature -- command
	setup_next(state: INTEGER_32)
		require else
			setup_next_precond(state)
    	do
    	model.set_already_in_state (False)
		model.set_abort_status(False)
		model.set_not_in_game_state (False)
		model.set_select_range_state (False)
		model.set_move_error_state (False)
		model.set_play_error_state (False)
			-- perform some update on the model state
		if
		  model.set_up_state=False
		then
          model.set_not_in_setup_state(True)
          model.set_not_in_setup_message ("Command can only be used in setup mode.")
          model.error_update
        else
	      model.setup_next (state)
		  model.reset_error
		  model.default_update
		  etf_cmd_container.on_change.notify ([Current])
	    end
    	end

end

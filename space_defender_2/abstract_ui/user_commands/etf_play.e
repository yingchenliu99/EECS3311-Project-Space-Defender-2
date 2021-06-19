note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
create
	make
feature -- command
	play(row: INTEGER_32 ; column: INTEGER_32 ; g_threshold: INTEGER_32 ; f_threshold: INTEGER_32 ; c_threshold: INTEGER_32 ; i_threshold: INTEGER_32 ; p_threshold: INTEGER_32)
		require else
			play_precond(row, column, g_threshold, f_threshold, c_threshold, i_threshold, p_threshold)
    	do
			model.set_abort_status(False)
			model.set_not_in_game_state (False)
			model.set_not_in_setup_state(False)
			model.set_select_range_state (False)
			model.set_play_error_state (False)
			model.set_play_error_state (False)
			-- perform some update on the model state
		if
		   model.i=0
		then
		   model.set_set_up_state (True)
		end

		if
		  model.set_up_state=True and model.i>0
		then
		  model.set_already_in_state (True)
		  model.set_already_in_message ("Already in setup mode.")
		else
			if
			  model.i>0
			then
			  model.set_play_error_state (True)
			  model.set_play_error_message ("Already in a game. Please abort to start a new one.")
			  model.error_update
			else
			  if
			  	g_threshold>f_threshold or g_threshold>c_threshold or g_threshold>i_threshold or g_threshold>p_threshold or f_threshold>c_threshold or f_threshold>i_threshold or f_threshold>p_threshold or c_threshold>i_threshold or c_threshold>p_threshold or i_threshold>p_threshold
			  then
			  	model.set_play_error_state (True)
			    model.set_play_error_message ("Threshold values are not non_decreasing.")
			    model.error_update
			  else
			    model.play(row, column, g_threshold, f_threshold, c_threshold, i_threshold, p_threshold)
		  	    model.reset_error
			    model.default_update
			    etf_cmd_container.on_change.notify ([Current])
			  end
			end
		end
    	end

end

note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE
inherit
	ETF_MOVE_INTERFACE
create
	make
feature -- command
	move(row: INTEGER_32 ; column: INTEGER_32)
		require else
			move_precond(row, column)
		local
		    action_move:COMMAND_MOVE
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
			if
			  row>model.board.board_row or column>model.board.board_column
			then
			  model.set_move_error_state (True)
			  model.set_move_error_message ("Cannot move outside of board.")
			  model.error_update
			else
              if
              	row=model.board.starfighter.row and column=model.board.starfighter.column
              then
              	model.set_move_error_state (True)
			    model.set_move_error_message ("Already there.")
			    model.error_update
              else
              	if
              	  ((row-model.board.starfighter.row).abs+(column-model.board.starfighter.column).abs)>model.board.starfighter.move_value
              	then
              	  model.set_move_error_state (True)
			      model.set_move_error_message ("Out of movement range.")
			      model.error_update
              	else
              	  if
              	   (model.board.starfighter.energy_current-((row-model.board.starfighter.row).abs+(column-model.board.starfighter.column).abs)*model.board.starfighter.move_cost)<0
              	  then
              	    model.set_move_error_state (True)
			        model.set_move_error_message ("Not enough resources to move.")
			        model.error_update
              	  else
			        create{COMMAND_MOVE}action_move.make(row,column)
		            model.board.turn (action_move)
			        model.set_set_up_state (False)
		            model.reset_error
			        model.correct_update
			        model.default_update
			        etf_cmd_container.on_change.notify ([Current])
			      end
			    end
			  end
			end
		end
    	end

end

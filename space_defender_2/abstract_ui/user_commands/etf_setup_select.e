note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SETUP_SELECT
inherit
	ETF_SETUP_SELECT_INTERFACE
create
	make
feature -- command
	setup_select(value: INTEGER_32)
		require else
			setup_select_precond(value)
    	do
        model.set_already_in_state (False)
		model.set_abort_status(False)
		model.set_not_in_game_state (False)
		model.set_select_range_state (False)
		model.set_move_error_state (False)
		model.set_play_error_state (False)
			-- perform some update on the model state
		if
          model.setup_state=1
       	then
       	  if
       	    value>model.weapon_q
       	  then
       	    model.set_select_range_state (True)
       	  end

       	  elseif
       	    model.setup_state=2
       	  then
       	    if
       	      value>model.armour_q
       	    then
       	      model.set_select_range_state (True)
       	    end

    	  elseif
       	    model.setup_state=3
       	  then
       	    if
       	      value>model.engine_q
       	    then
       	      model.set_select_range_state (True)
       	    end

	      elseif
       	    model.setup_state=4
       	  then
       	    if
       	      value>model.power_q
       	    then
       	      model.set_select_range_state (True)
       	    end
       	  end


	    if
		  model.set_up_state=False or model.setup_state=5
		then
          model.set_not_in_setup_state(True)
          model.set_not_in_setup_message ("Command can only be used in setup mode (excluding summary in setup). ")
          model.error_update
        else
          if
       	    model.select_range_state
          then
          	model.set_select_range_message ("Menu option selected out of range.")
          else
	       model.setup_select (value)
		   model.reset_error
		   model.default_update
	       etf_cmd_container.on_change.notify ([Current])
	      end
	    end
    	end

end

note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TOGGLE_DEBUG_MODE
inherit
	ETF_TOGGLE_DEBUG_MODE_INTERFACE
create
	make
feature -- command
	toggle_debug_mode
    	do
			-- perform some update on the model state
			if
			  model.debug_mode=False
			then
			  model.set_debug_mode(True)
		    else
			  model.set_debug_mode(False)
			end
			model.error_update
			if model.debug_mode then
              model.set_error_message("ok%N"+"  In debug mode.")
            else
              model.set_error_message ("ok%N"+"  Not in debug mode.")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end

note
	description: "Summary description for {ARMOUR_NONE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARMOUR_NONE

inherit
	ARMOUR

create

	make

feature
	make
	do
     health := 50
 	 energy := 0
	 regen_health := 1
	 regen_energy := 0
	 armour := 0
	 vision := 0
	 move := 1
	 move_cost := 0
	end

feature
	armour_type:STRING
	do
		Result:="None"
	end

end

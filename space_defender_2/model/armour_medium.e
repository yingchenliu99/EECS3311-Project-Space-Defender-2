note
	description: "Summary description for {ARMOUR_MEDIUM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARMOUR_MEDIUM

inherit
	ARMOUR

create

	make

feature
	make
	do
     health := 100
 	 energy := 0
	 regen_health := 3
	 regen_energy := 0
	 armour := 5
	 vision := 0
	 move := 0
	 move_cost := 3
	end

feature
	armour_type:STRING
	do
		Result:="Medium"
	end


end

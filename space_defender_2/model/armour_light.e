note
	description: "Summary description for {ARMOUR_LIGHT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARMOUR_LIGHT

inherit
	ARMOUR

create

	make

feature
	make
	do
     health := 75
 	 energy := 0
	 regen_health := 2
	 regen_energy := 0
	 armour := 3
	 vision := 0
	 move := 0
	 move_cost := 1
	end

feature
	armour_type:STRING
	do
		Result:="Light"
	end

end

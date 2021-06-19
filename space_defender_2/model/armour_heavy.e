note
	description: "Summary description for {ARMOUR_HEAVY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ARMOUR_HEAVY

inherit
	ARMOUR

create

	make

feature
	make
	do
     health := 200
 	 energy := 0
	 regen_health := 4
	 regen_energy := 0
	 armour := 10
	 vision := 0
	 move := -1
	 move_cost := 5
	end

feature
	armour_type:STRING
	do
		Result:="Heavy"
	end

end

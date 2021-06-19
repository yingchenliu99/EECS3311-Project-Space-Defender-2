note
	description: "Summary description for {ENGINE_ARMOURED}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENGINE_ARMOURED

inherit
	ENGINE

create

   make

feature
	make
	do
	 health := 50
 	 energy := 100
	 regen_health := 0
	 regen_energy := 3
	 armour := 3
	 vision := 6
	 move := 4
	 move_cost := 5
	end

feature
	engine_type:STRING
	do
		Result:="Armoured"
	end

end

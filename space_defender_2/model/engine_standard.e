note
	description: "Summary description for {ENGINE_STANDARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENGINE_STANDARD

inherit
	ENGINE

create

   make

feature
	make
	do
	 health := 10
 	 energy := 60
	 regen_health := 0
	 regen_energy := 2
	 armour := 1
	 vision := 12
	 move := 8
	 move_cost := 2
	end

feature
	engine_type:STRING
	do
		Result:="Standard"
	end

end

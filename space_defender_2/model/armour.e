note
	description: "Summary description for {ARMOUR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ARMOUR

feature
	health : INTEGER
	energy : INTEGER
	regen_health : INTEGER
	regen_energy : INTEGER
	armour : INTEGER
	vision : INTEGER
	move : INTEGER
	move_cost : INTEGER

feature
	armour_type:STRING
	deferred
	end

feature
	armour_initial_information:STRING
	do
		Result:="1:None%N  "
        Result:=Result+"  Health:50, Energy:0, Regen:1/0, Armour:0, Vision:0, Move:1, Move Cost:0%N  "
        Result:=Result+"2:Light%N  "
        Result:=Result+"  Health:75, Energy:0, Regen:2/0, Armour:3, Vision:0, Move:0, Move Cost:1%N  "
        Result:=Result+"3:Medium%N  "
        Result:=Result+"  Health:100, Energy:0, Regen:3/0, Armour:5, Vision:0, Move:0, Move Cost:3%N  "
        Result:=Result+"4:Heavy%N  "
        Result:=Result+"  Health:200, Energy:0, Regen:4/0, Armour:10, Vision:0, Move:-1, Move Cost:5%N  "
        
	end

end

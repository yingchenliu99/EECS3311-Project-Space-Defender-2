note
	description: "Summary description for {ENGINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENGINE

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
	engine_type:STRING
	deferred
	end

feature
	engine_initial_information:STRING
	do
		Result:="1:Standard%N  "
        Result:=Result+"  Health:10, Energy:60, Regen:0/2, Armour:1, Vision:12, Move:8, Move Cost:2%N  "
        Result:=Result+"2:Light%N  "
        Result:=Result+"  Health:0, Energy:30, Regen:0/1, Armour:0, Vision:15, Move:10, Move Cost:1%N  "
        Result:=Result+"3:Armoured%N  "
        Result:=Result+"  Health:50, Energy:100, Regen:0/3, Armour:3, Vision:6, Move:4, Move Cost:5%N  "
	end
end

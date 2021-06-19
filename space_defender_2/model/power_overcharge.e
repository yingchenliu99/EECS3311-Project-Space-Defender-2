note
	description: "Summary description for {POWER_OVERCHARGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_OVERCHARGE

inherit
	POWER

create

	make
feature
    n:INTEGER

feature
	make
	do

	end

    power_type:STRING
	do
		Result:="Overcharge (up to 50 health): Gain 2*health spent energy, can go over max energy. Energy regen will not be in effect if over cap."
	end

	power_action
	do
	model.m.set_not_enough_resources_state (False)
		if
		  model.m.board.starfighter.health_current=1
		then
		  model.m.set_not_enough_resources_state (True)
		elseif
		  model.m.board.starfighter.health_current-50>=1
		then
		  model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-50)
		  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current+100)
		  model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) uses special, gaining 100 energy at the expense of 50 health")
		elseif
          0<n and n<50 and model.m.board.starfighter.health_current-n>=1
		then
          model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-n)
		  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current+n*2)
		  model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) uses special, gaining "+(n*2).out+" energy at the expense of "+n.out+" health")
        end
	end

end

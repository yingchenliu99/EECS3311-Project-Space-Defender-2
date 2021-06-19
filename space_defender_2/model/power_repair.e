note
	description: "Summary description for {POWER_REPAIR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	POWER_REPAIR

inherit
	POWER

create

	make

feature
	make
	do

	end

    power_type:STRING
	do
		Result:="Repair (50 energy): Gain 50 health, can go over max health. Health regen will not be in effect if over cap."
	end

	power_action
	do
	model.m.set_not_enough_resources_state (False)
		if
		  model.m.board.starfighter.energy_current>=50
		then
          model.m.board.starfighter.set_health (model.m.board.starfighter.health_current+50)
          model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-50)
          model.m.board.set_starfighter_action ("%N    The Starfighter(id:0) uses special, gaining 50 to health")
        else
		  model.m.set_not_enough_resources_state (True)
        end
	end
end

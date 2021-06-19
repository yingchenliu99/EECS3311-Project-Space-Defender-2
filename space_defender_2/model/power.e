note
	description: "Summary description for {POWER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	POWER

feature
	power_type:STRING
	deferred
	end

feature
	model:ETF_MODEL_ACCESS

feature
    power_initial_information:STRING
    do
    	Result:="1:Recall (50 energy): Teleport back to spawn.%N  "
        Result:=Result+"2:Repair (50 energy): Gain 50 health, can go over max health. Health regen will not be in effect if over cap.%N  "
        Result:=Result+"3:Overcharge (up to 50 health): Gain 2*health spent energy, can go over max energy. Energy regen will not be in effect if over cap.%N  "
        Result:=Result+"4:Deploy Drones (100 energy): Clear all projectiles.%N  "
        Result:=Result+"5:Orbital Strike (100 energy): Deal 100 damage to all enemies, affected by armour.%N  "
    end

feature
	power_action
	deferred
	end
end

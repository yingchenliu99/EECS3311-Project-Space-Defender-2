note
	description: "Summary description for {WEAPON_STANDARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEAPON_STANDARD

inherit
	WEAPON

create

	make

feature
	make
	do
	health :=10
	energy :=10
	regen_health :=0
	regen_energy :=1
	armour :=0
	vision :=1
	move :=1
	move_cost :=1
	bullet_damage:=70
	bullet_cost:=5
	end

feature
    weapon_type:STRING
    do
    	Result:="Standard"
    end

    projectile_damage:INTEGER
    do
    	Result:=70
    end

    projectile_cost:STRING
    do
    	Result:="5 (energy)"
    end


feature
	fire_action
	local
		friendly_bullet:BULLET_SELF
	do
    model.m.set_not_enough_resources_state (False)
	if
	  model.m.board.starfighter.energy_current<5
	then
	  model.m.set_not_enough_resources_state (True)
	else
	  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-5)
      create friendly_bullet.make (model.m.board.starfighter.row, model.m.board.starfighter.column+1, 0, 1, 70, 5)
      model.m.board.bullet_list.extend (friendly_bullet)
      fire_bullet_information(friendly_bullet)
    end

	end

end

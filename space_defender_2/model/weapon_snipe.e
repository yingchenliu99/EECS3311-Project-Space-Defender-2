note
	description: "Summary description for {WEAPON_SNIPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEAPON_SNIPE

inherit
	WEAPON

create

	make

feature
	make
	do
	health :=0
	energy :=100
	regen_health :=0
	regen_energy :=5
	armour :=0
	vision :=10
	move :=3
	move_cost :=0
	bullet_damage:=1000
	bullet_cost:=20
	end

feature
    weapon_type:STRING
    do
    	Result:="Snipe"
    end

    projectile_damage:INTEGER
    do
    	Result:=1000
    end

    projectile_cost:STRING
    do
    	Result:="20 (energy)"
    end

feature
	fire_action
	local
		friendly_bullet:SNIPE_FRIENDLY_BULLET
	do
    model.m.set_not_enough_resources_state (False)
	if
	  model.m.board.starfighter.energy_current<20
	then
	  model.m.set_not_enough_resources_state (True)
	else
		model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-20)
        create friendly_bullet.make_snipe (model.m.board.starfighter.row, model.m.board.starfighter.column+1, 0, 1, 1000, 8)
        model.m.board.bullet_list.extend (friendly_bullet)
        fire_bullet_information(friendly_bullet)
    end

	end


end

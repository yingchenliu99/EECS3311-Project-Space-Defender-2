note
	description: "Summary description for {WEAPON_SPLITTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEAPON_SPLITTER

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
	regen_energy :=10
	armour :=0
	vision :=0
	move :=0
	move_cost :=5
	bullet_damage:=150
	bullet_cost:=70
	end

feature
    weapon_type:STRING
    do
    	Result:="Splitter"
    end

    projectile_damage:INTEGER
    do
    	Result:=150
    end

    projectile_cost:STRING
    do
    	Result:="70 (energy)"
    end

feature
    fire_action
	local
		friendly_bullet:BULLET_SELF
	do
	model.m.set_not_enough_resources_state (False)
	if
	  model.m.board.starfighter.energy_current<70
	then
	  model.m.set_not_enough_resources_state (True)
	else
	  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-70)
      create friendly_bullet.make (model.m.board.starfighter.row, model.m.board.starfighter.column+1, 0, 1, 150, 0)
      model.m.board.bullet_list.extend (friendly_bullet)
      fire_bullet_information(friendly_bullet)
    end

	end

end

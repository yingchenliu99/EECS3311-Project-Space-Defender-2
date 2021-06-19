note
	description: "Summary description for {WEAPON_SPREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEAPON_SPREAD

inherit
	WEAPON

create

	make

feature
	make
	do
    health :=0
	energy :=60
	regen_health :=0
	regen_energy :=2
	armour :=1
	vision :=0
	move :=0
	move_cost :=2
	bullet_damage:=50
	bullet_cost:=10
	end

feature
    weapon_type:STRING
    do
    	Result:="Spread"
    end

    projectile_damage:INTEGER
    do
    	Result:=50
    end

    projectile_cost:STRING
    do
    	Result:="10 (energy)"
    end

feature
	fire_action
	local
		friendly_bullet_1:BULLET_SELF
		friendly_bullet_2:BULLET_SELF
		friendly_bullet_3:BULLET_SELF
	do
    model.m.set_not_enough_resources_state (False)
	if
	  model.m.board.starfighter.energy_current<10
	then
	  model.m.set_not_enough_resources_state (True)
	else
      model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current-10)
      create friendly_bullet_1.make (model.m.board.starfighter.row-1, model.m.board.starfighter.column+1, -1, 1, 50, 1)
      model.m.board.bullet_list.extend (friendly_bullet_1)
      fire_bullet_information(friendly_bullet_1)
      create friendly_bullet_2.make (model.m.board.starfighter.row, model.m.board.starfighter.column+1, 0, 1, 50, 1)
      model.m.board.bullet_list.extend (friendly_bullet_2)
      fire_bullet_information(friendly_bullet_2)
      create friendly_bullet_3.make (model.m.board.starfighter.row+1, model.m.board.starfighter.column+1, 1, 1, 50, 1)
      model.m.board.bullet_list.extend (friendly_bullet_3)
      fire_bullet_information(friendly_bullet_3)
    end

	end


end

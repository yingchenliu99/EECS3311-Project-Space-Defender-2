note
	description: "Summary description for {WEAPON_ROCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEAPON_ROCKET

inherit
	WEAPON

create

	make

feature
	make
	do
	health :=10
	energy :=0
	regen_health :=10
	regen_energy :=0
	armour :=2
	vision :=2
	move :=0
	move_cost :=3
	bullet_damage:=100
	bullet_cost:=10
	end

feature
    weapon_type:STRING
    do
    	Result:="Rocket"
    end

    projectile_damage:INTEGER
    do
    	Result:=100
    end

    projectile_cost:STRING
    do
    	Result:="10 (health)"
    end

feature
	fire_action
	local
		friendly_bullet_1:ROCKET_FRIENDLY_BULLET
		friendly_bullet_2:ROCKET_FRIENDLY_BULLET
	do
	model.m.set_not_enough_resources_state (False)
	if
	  model.m.board.starfighter.health_current<10
	then
	  model.m.set_not_enough_resources_state (True)
	else
	  model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-10)
      create friendly_bullet_1.make_rocket (model.m.board.starfighter.row-1, model.m.board.starfighter.column-1, 0, 1, 100, 1)
      model.m.board.bullet_list.extend (friendly_bullet_1)
      fire_bullet_information(friendly_bullet_1)
      create friendly_bullet_2.make_rocket (model.m.board.starfighter.row+1, model.m.board.starfighter.column-1, 0, 1, 100, 1)
      model.m.board.bullet_list.extend (friendly_bullet_2)
      fire_bullet_information(friendly_bullet_2)
	end
    end


end

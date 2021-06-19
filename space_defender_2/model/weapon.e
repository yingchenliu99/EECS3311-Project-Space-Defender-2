note
	description: "Summary description for {WEAPON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEAPON

feature
	health : INTEGER
	energy : INTEGER
	regen_health : INTEGER
	regen_energy : INTEGER
	armour : INTEGER
	vision : INTEGER
	move : INTEGER
	move_cost : INTEGER
	model: ETF_MODEL_ACCESS
	bullet_damage:INTEGER
	bullet_cost:INTEGER

feature
	weapon_type:STRING
	deferred
	end

	projectile_damage:INTEGER
	deferred
	end

    projectile_cost:STRING
    deferred
    end

feature
	fire_action
	deferred
	end

feature
	weapon_initial_information:STRING
	do
	    Result:="1:Standard (A single projectile is fired in front)%N  "
        Result:= Result+"  Health:10, Energy:10, Regen:0/1, Armour:0, Vision:1, Move:1, Move Cost:1,%N  "
        Result:= Result+"  Projectile Damage:70, Projectile Cost:5 (energy)%N  "
        Result:= Result+"2:Spread (Three projectiles are fired in front, two going diagonal)%N  "
        Result:= Result+"  Health:0, Energy:60, Regen:0/2, Armour:1, Vision:0, Move:0, Move Cost:2,%N  "
        Result:= Result+"  Projectile Damage:50, Projectile Cost:10 (energy)%N  "
        Result:= Result+"3:Snipe (Fast and high damage projectile, but only travels via teleporting)%N  "
        Result:= Result+"  Health:0, Energy:100, Regen:0/5, Armour:0, Vision:10, Move:3, Move Cost:0,%N  "
        Result:= Result+"  Projectile Damage:1000, Projectile Cost:20 (energy)%N  "
        Result:= Result+"4:Rocket (Two projectiles appear behind to the sides of the Starfighter and accelerates)%N  "
        Result:= Result+"  Health:10, Energy:0, Regen:10/0, Armour:2, Vision:2, Move:0, Move Cost:3,%N  "
        Result:= Result+"  Projectile Damage:100, Projectile Cost:10 (health)%N  "
        Result:= Result+"5:Splitter (A single mine projectile is placed in front of the Starfighter)%N  "
        Result:= Result+"  Health:0, Energy:100, Regen:0/10, Armour:0, Vision:0, Move:0, Move Cost:5,%N  "
        Result:= Result+"  Projectile Damage:150, Projectile Cost:70 (energy)%N  "
	end

feature--fire bullet innformation
	fire_bullet_information(n:BULLET_SELF)
	do
		model.m.board.set_starfighter_action (model.m.board.starfighter_action+"%N      A friendly projectile(id:-")
        model.m.board.set_starfighter_action (model.m.board.starfighter_action+model.m.board.bullet_list.count.out)
        model.m.board.set_starfighter_action (model.m.board.starfighter_action+") spawns at location ")
        if
          n.row>=1 and n.row<=model.m.board.board_row and n.column>=1 and n.column<=model.m.board.board_column
        then
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+"["+model.m.board.row_letter[n.row].out+",")
          model.m.board.set_starfighter_action (model.m.board.starfighter_action+n.column.out+"].")
        else
           model.m.board.set_starfighter_action (model.m.board.starfighter_action+"out of board.")
        end
	end

feature -- error message
    error_message
    do
      model.m.board.set_starfighter_action (model.m.board.starfighter_action+"%N"+"Not enough resources to fire")
    end
end

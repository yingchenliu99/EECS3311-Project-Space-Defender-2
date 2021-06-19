note
	description: "Summary description for {STARFIGHTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STARFIGHTER

create

	make

feature
	make(r:INTEGER;c:INTEGER;w:WEAPON;a:ARMOUR;e:ENGINE;p:POWER)
	do
      row:=r
      column:=c
      weapon:=w
      armour:=a
      engine:=e
      power:=p
      health_current:=max_health
      energy_current:=max_energy
      row_letter:=<<'A', 'B', 'C', 'D','E', 'F', 'G', 'H', 'I', 'J'>>
	end

feature
	row : INTEGER
	column : INTEGER
	weapon : WEAPON
    armour : ARMOUR
    engine : ENGINE
    power : POWER
    health_current : INTEGER
    energy_current : INTEGER
    row_letter:ARRAY[CHARACTER]

feature -- health
	max_health:INTEGER
	do
		Result:=armour.health+engine.health+weapon.health
	end

feature -- energy
	max_energy:INTEGER
	do
		Result:=armour.energy+engine.energy+weapon.energy
	end

feature -- armour
    value_armour:INTEGER
    do
    	Result:=armour.armour+engine.armour+weapon.armour
    end

feature -- regen
    regen_health:INTEGER
    do
    	Result:=armour.regen_health+engine.regen_health+weapon.regen_health
    end

    regen_energy:INTEGER
    do
    	Result:=armour.regen_energy+engine.regen_energy+weapon.regen_energy
    end

feature -- vision
	vision_value:INTEGER
	do
		Result:=armour.vision+engine.vision+weapon.vision
	end

feature -- move
   move_value:INTEGER
   do
   	    Result:=armour.move+engine.move+weapon.move
   end

   move_cost:INTEGER
   do
   	    Result:=armour.move_cost+engine.move_cost+weapon.move_cost
   end

feature -- set
	set_health(h:INTEGER)
	do
		health_current:=h
	end

	set_energy(e:INTEGER)
	do
		energy_current:=e
	end

	set_move(n_row:INTEGER; n_column:INTEGER)
	do
		row:=n_row
		column:=n_column
	end

feature
    starfighter_information:STRING
    do
    	Result:=""
		Result.append("Starfighter:%N")
		Result.append("    [0,S]->")
		Result.append("health:"+health_current.out+"/"+max_health.out+", ")
		Result.append("energy:"+energy_current.out+"/"+max_energy.out+", ")
		Result.append("Regen:"+regen_health.out+"/"+regen_energy.out+", ")
		Result.append("Armour:"+value_armour.out+", ")
		Result.append("Vision:"+vision_value.out+", ")
		Result.append("Move:"+move_value.out+", ")
		Result.append("Move Cost:"+move_cost.out+", ")
		Result.append("location:["+row_letter[row].out+","+column.out+"]"+"%N")
		Result.append ("      Projectile Pattern:"+weapon.weapon_type+", ")
		Result.append ("Projectile Damage:"+weapon.projectile_damage.out+", ")
		Result.append ("Projectile Cost:"+weapon.projectile_cost+"%N")
		Result.append ("      Power:"+power.power_type+"%N")
    end
end

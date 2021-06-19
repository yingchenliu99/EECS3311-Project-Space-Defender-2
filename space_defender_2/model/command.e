note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMAND

feature
	action
    	deferred
	end

feature
	model:ETF_MODEL_ACCESS

feature -- restoring health
    restoring_health(type:INTEGER)
    do
      if
      	type=1
      then
      	if
      	  model.m.board.starfighter.health_current >= model.m.board.starfighter.max_health
      	then

        elseif
	      (model.m.board.starfighter.health_current + model.m.board.starfighter.regen_health) > model.m.board.starfighter.max_health
	    then
           model.m.board.starfighter.set_health (model.m.board.starfighter.max_health)
        else
      	 model.m.board.starfighter.set_health (model.m.board.starfighter.health_current + model.m.board.starfighter.regen_health)
        end

      elseif
      	type=2
      then
      	if
      	  model.m.board.starfighter.health_current>=model.m.board.starfighter.max_health
      	then

        elseif
          (model.m.board.starfighter.health_current + (model.m.board.starfighter.regen_health*2)) > model.m.board.starfighter.max_health
        then
           model.m.board.starfighter.set_health (model.m.board.starfighter.max_health)
        else
      	  model.m.board.starfighter.set_health (model.m.board.starfighter.health_current + model.m.board.starfighter.regen_health*2)
        end
      end
    end

feature -- restoring energy
    restoring_energy(type:INTEGER)
    do
      if
        type=1
      then
      	if
      	  model.m.board.starfighter.energy_current>=model.m.board.starfighter.max_energy
      	then

        elseif
          (model.m.board.starfighter.energy_current + model.m.board.starfighter.regen_energy) > model.m.board.starfighter.max_energy
        then
          model.m.board.starfighter.set_energy (model.m.board.starfighter.max_energy)
        else
      	  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current + model.m.board.starfighter.regen_energy)
        end

      elseif
      	type=2
      then
      	if
      	  model.m.board.starfighter.energy_current>=model.m.board.starfighter.max_energy
      	then

        elseif
          (model.m.board.starfighter.energy_current + (model.m.board.starfighter.regen_energy*2)) > model.m.board.starfighter.max_energy
        then
          model.m.board.starfighter.set_energy (model.m.board.starfighter.max_energy)
        else
      	  model.m.board.starfighter.set_energy (model.m.board.starfighter.energy_current + model.m.board.starfighter.regen_energy*2)
        end
      end

    end



end

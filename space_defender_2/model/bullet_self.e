note
	description: "Summary description for {BULLET_SELF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BULLET_SELF

inherit
	BULLET

redefine
	move
end

create

    make

feature
    make(n_row:INTEGER;n_column:INTEGER;movement_row:INTEGER; movement_column:INTEGER; damage:INTEGER; b_move:INTEGER)
    do
      row:=n_row
      column:=n_column
      m_row:=movement_row
      m_column:=movement_column
      bullet_symbols:='*'
      bullet_damage:=damage
      bullet_move:=b_move
      message:=""
      str:=""
    end

feature
	move
	local
	  current_row:INTEGER
	  current_column:INTEGER
	do
	  message:=""
	  str:=""
	  from
	  	current_row:=row
	  	current_column:=column
	  until
	  	bullet_damage<=0 or (current_row=row+m_row*bullet_move and current_column=column+m_column*bullet_move) or current_row<=0 or current_row>model.m.board.board_row or current_column<=0 or current_column>model.m.board.board_column
	  loop
	  		if
	  		  row+m_row*bullet_move=current_row
	  		then
      		  current_column:=current_column+column_move_distance(current_column)
      	    else
      		  current_row:=current_row+row_move_distance(current_row)
      	    end

      	    across model.m.board.bullet_list is b_n loop
      	      if
      	        b_n.row=current_row and b_n.column=current_column and attached {BULLET_ENEMY} b_n and b_n/=current and b_n.row>=1 and b_n.row<=model.m.board.board_row and b_n.column >=1 and b_n.column<=model.m.board.board_column
      	      then
                 enemy_bullet_collided(b_n,current_row,current_column)
      	      end
      	    end

      	    across model.m.board.bullet_list is b_n loop
      	      if
      	        b_n.row=current_row and b_n.column=current_column and attached {BULLET_SELF} b_n
      	      then
      	      	 self_bullet_collided(b_n)
      	      end
      	    end

      	    across model.m.board.enemy_list is e_n loop
      	      if
      	        e_n.row=current_row and e_n.column=current_column
      	      then
      	      	enemy_collided_with_bullet(e_n,current_row,current_column)
      	      end
      	    end

      	    if
      	      model.m.board.starfighter.row=current_row and model.m.board.starfighter.column=current_column
      	    then
      	      starfighter_collided_with_bullet
      	    end
		end

		if
		  row>0
		then
		  row:=current_row
		  column:=current_column
		  if
		    row>=1 and row <=model.m.board.board_row and column>=1 and column<=model.m.board.board_column
		  then
		    str:="["+model.m.board.row_letter[row].out+","+column.out+"]"
		  else
            str:="out of board"
		  end
	    end
	end

feature -- remove enemy bullet
  enemy_bullet_disapper(enemy_b:BULLET)
  do
  	bullet_damage:=bullet_damage-enemy_b.bullet_damage
    enemy_b.disapper
  end

feature -- remove self bullet
  self_bullet_disapper(enemy_b:BULLET;c_row:INTEGER;c_column:INTEGER)
  do
  	 enemy_b.set_bullet_damage(enemy_b.bullet_damage-bullet_damage)
     bullet_damage:=0
     str:="["+model.m.board.row_letter[c_row].out+","+c_column.out+"]"
     disapper
  end

feature -- remove both enemy and self bullet
  both_bullet_disapper(enemy_b:BULLET;c_row:INTEGER;c_column:INTEGER)
  do
  	enemy_b.disapper
  	str:="["+model.m.board.row_letter[c_row].out+","+c_column.out+"]"
    disapper
    bullet_damage:=0
  end

feature -- collided
  enemy_bullet_collided(enemy_b:BULLET;c_row:INTEGER;c_column:INTEGER)
  do
  	if
      enemy_b.bullet_damage>bullet_damage
    then
      self_bullet_disapper(enemy_b,c_row,c_column)
    elseif
      enemy_b.bullet_damage=bullet_damage
    then
      both_bullet_disapper(enemy_b,c_row,c_column)
    else
      enemy_bullet_disapper(enemy_b)
      message:=message+"%N      The projectile collides with enemy projectile(id:-"+model.m.board.bullet_list.index_of(enemy_b,1).out+") "
      message:=message+"at location ["+model.m.board.row_letter[c_row].out+","+c_column.out+"], negating damage."
    end
  end

  self_bullet_collided(self_b:BULLET)
  do
  	self_b.disapper
    bullet_damage:=bullet_damage+self_b.bullet_damage
  end

  enemy_collided_with_bullet(enemy_b:ENEMY;c_row:INTEGER;c_column:INTEGER)
  do
  	 str:="["+model.m.board.row_letter[c_row].out+","+c_column.out+"]"
  	 disapper
  	 message:=message+"%N      The projectile collides with "+enemy_b.enemy_name+"(id:"+model.m.board.enemy_list.index_of(enemy_b,1).out+") "
  	 message:=message+"at location ["+model.m.board.row_letter[enemy_b.row].out+","+enemy_b.column.out+"], "
  	 message:=message+"dealing "+(bullet_damage-enemy_b.armour).out+" damage."
     if
       enemy_b.current_health-(bullet_damage-enemy_b.armour)>0
     then
       enemy_b.set_current_health(enemy_b.current_health-(bullet_damage-enemy_b.armour))
     else
       enemy_b.set_current_health(0)
       message:=message+"%N      The "+enemy_b.enemy_name+" at location ["+model.m.board.row_letter[enemy_b.row].out+","+enemy_b.column.out+"] has been destroyed."
       enemy_b.disapper
       model.m.board.orb_list.force (enemy_b.orb, model.m.board.orb_list.count+1)
     end
  end

  starfighter_collided_with_bullet
  do
  	if
      model.m.board.starfighter.health_current-(bullet_damage-model.m.board.starfighter.value_armour)>0
    then
      model.m.board.starfighter.set_health (model.m.board.starfighter.health_current-(bullet_damage-model.m.board.starfighter.value_armour))
    else
      model.m.board.starfighter.set_health (0)
      model.m.board.set_game_over
     end
  end

end

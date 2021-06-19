note
	description: "Summary description for {ROCKET_FRIENDLY_BULLET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROCKET_FRIENDLY_BULLET

inherit
	BULLET_SELF

redefine
	move
end

create
	make_rocket

feature
    make_rocket(n_row:INTEGER;n_column:INTEGER;move_row:INTEGER; move_column:INTEGER; b_damage:INTEGER; b_move:INTEGER)
    do
      row:=n_row
      column:=n_column
      m_row:=move_row
      m_column:=move_column
      bullet_symbols:='*'
      bullet_damage:=b_damage
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
	  	bullet_damage<=0 or (current_row=row+m_row*bullet_move and current_column=column+m_column*bullet_move)
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
		bullet_move:=bullet_move*2
	end


end

note
	description: "Summary description for {BULLET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BULLET

feature
    row:INTEGER
    column: INTEGER
    bullet_symbols: CHARACTER
    bullet_damage:INTEGER
    bullet_move:INTEGER
    m_row:INTEGER
    m_column:INTEGER
    message:STRING
    str:STRING

    model:ETF_MODEL_ACCESS
feature
	move
	do

	end

feature -- remove bullet
	disapper
	do
	  row:=-999
	end

feature -- change bullet damage
	set_bullet_damage(n:INTEGER)
	do
      bullet_damage:=n
	end

feature -- row and column move distance
    column_move_distance(c_column:INTEGER):INTEGER
    do
      Result:=(column+m_column*bullet_move-c_column)//(column+m_column*bullet_move-c_column).abs
    end

    row_move_distance(c_row:INTEGER):INTEGER
    do
      Result:=(row+m_row*bullet_move-c_row)//(row+m_row*bullet_move-c_row).abs
    end

end

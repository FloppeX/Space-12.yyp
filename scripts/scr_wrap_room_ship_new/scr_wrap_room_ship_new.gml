function scr_wrap_room_ship_new() {
	x_diff = 0
	y_diff = 0

	if phy_position_x < global.wrap_border_left 
		x_diff = global.play_area_width
	if phy_position_x > global.wrap_border_right 
		x_diff = -global.play_area_width
	if phy_position_y < global.wrap_border_top
		y_diff = global.play_area_height
	if phy_position_y > global.wrap_border_bottom
		y_diff = -global.play_area_height
		
	phy_position_x += x_diff
	phy_position_y += y_diff
	
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		if scr_exists(ship_segment[i])
			with(ship_segment[i]){
				x_diff = other.x_diff
				y_diff = other.y_diff
				phy_position_x += other.x_diff
				phy_position_y += other.y_diff
				if module != noone
					with(module){
						phy_position_x += other.x_diff
						phy_position_y += other.y_diff
					}
				}



}


function scr_wrap_room_player_new() {
	var x_diff = 0
	var y_diff = 0

	if phy_position_x < global.wrap_margin_player
		x_diff = global.play_area_width
	if phy_position_x > room_width-global.wrap_margin_player
		x_diff = -global.play_area_width
	if phy_position_y < global.wrap_margin_player
		y_diff = global.play_area_height
	if phy_position_y > room_height - global.wrap_margin_player
		y_diff = -global.play_area_height
		
	phy_position_x += x_diff
	phy_position_y += y_diff
	
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		if scr_exists(ship_segment[i])
			with(ship_segment[i]){
				phy_position_x += x_diff
				phy_position_y += y_diff
				if module != noone
					with(module){
						phy_position_x += x_diff
						phy_position_y += y_diff
					}
				}



}

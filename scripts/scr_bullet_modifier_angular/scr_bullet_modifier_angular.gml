function scr_bullet_modifier_angular() {
	temp_time = timer mod 80
	if temp_time == 0{
		phy_speed_x = lengthdir_x(starting_speed,-starting_direction)
		phy_speed_y = lengthdir_y(starting_speed,-starting_direction)
	}
	if temp_time == 20{
		phy_speed_x = lengthdir_x(starting_speed,-starting_direction+90)
		phy_speed_y = lengthdir_y(starting_speed,-starting_direction+90)
	}
	if temp_time == 40{
		phy_speed_x = lengthdir_x(starting_speed,-starting_direction)
		phy_speed_y = lengthdir_y(starting_speed,-starting_direction)
	}
	if temp_time == 60{
		phy_speed_x = lengthdir_x(starting_speed,-starting_direction-90)
		phy_speed_y = lengthdir_y(starting_speed,-starting_direction-90)
	}
}


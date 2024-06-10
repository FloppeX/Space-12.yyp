function scr_bullet_modifier_wavy() {
	var temp_angle = (timer mod 36) * 10
	var temp_force = min(timer*30,1000)*phy_mass* cos(degtorad(temp_angle))
	var temp_dir = -starting_direction+90 //scr_wrap_direction_to_point(phy_position_x,phy_position_y, phy_position_xprevious,phy_position_yprevious)+90
	physics_apply_force(phy_position_x,phy_position_y,lengthdir_x(temp_force,temp_dir),lengthdir_y(temp_force,temp_dir))	
}


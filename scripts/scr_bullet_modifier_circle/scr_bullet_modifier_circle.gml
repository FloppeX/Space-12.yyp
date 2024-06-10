function scr_bullet_modifier_circle() {
	var current_dir = scr_wrap_direction_to_point(phy_position_xprevious,phy_position_yprevious,phy_position_x,phy_position_y)
	var temp_force = 500*phy_mass
	var owner_dir = scr_wrap_direction_to_point(owner.owner.phy_position_x,owner.owner.phy_position_y,phy_position_x,phy_position_y)
	//if angle_difference(current_dir,owner_dir)>0
		physics_apply_force(phy_position_x,phy_position_y,lengthdir_x(temp_force,current_dir+90),lengthdir_y(temp_force,current_dir+90))	
	}
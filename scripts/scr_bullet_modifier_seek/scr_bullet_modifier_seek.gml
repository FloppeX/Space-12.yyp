function scr_bullet_modifier_seek() {

	var seek_range = 600
	var force = 40 * phy_mass
	
	var target = scr_rocket_find_target_in_arc(obj_enemy_ship,-phy_rotation,120,seek_range)
	if target != noone{
		var target_dir = point_direction(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y)
		var angle_diff = angle_difference(-phy_rotation,target_dir)
		if abs(angle_diff) > 5
			physics_apply_local_force(0,0,0,force*sign(angle_diff))
		}
	color = c_aqua



	// Simpler code below
	/*
	var seek_range = 300
	var force = 200 * phy_mass

	var target = scr_rocket_find_target_in_arc(obj_enemy_ship_new,-phy_rotation,180,seek_range)
	if target != noone{
		var target_dir = point_direction(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y)
		physics_apply_force(phy_com_x,phy_com_y,lengthdir_x(force,target_dir),lengthdir_y(force,target_dir))
		}

	// Code below is for a more advanced and maybe more interesting effect
	/*
	var seek_range = 600
	var force = 15

	var target = scr_rocket_find_target_in_arc(obj_enemy_ship_new,-phy_rotation,180,seek_range)
	if target != noone{
		var target_dir = point_direction(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y)
		var angle_diff = angle_difference(-phy_rotation,target_dir)
		physics_apply_local_force(0,0,0,force*sign(angle_diff))
		}





/* end scr_bullet_modifier_seek */
}

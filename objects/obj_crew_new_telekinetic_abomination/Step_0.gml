with(obj_asteroid){
	var force = 10
	var temp_distance = point_distance(other.owner.phy_position_x,other.owner.phy_position_y,phy_position_x,phy_position_y)
	if temp_distance <= 120{
		var temp_dir = point_direction(other.owner.phy_position_x,other.owner.phy_position_y,phy_position_x,phy_position_y)
		var force_x = lengthdir_x(force*phy_mass,temp_dir)
		var force_y = lengthdir_y(force*phy_mass,temp_dir)
		physics_apply_force(phy_position_x,phy_position_y,force_x,force_y)
	}
}
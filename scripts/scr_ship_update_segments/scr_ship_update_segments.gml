function scr_ship_update_segments(argument0, argument1) {
	var ship = argument0
	var segment_distance = argument1

	// Delete all joints

	for(var i = 0; i < array_length_1d(ship.ship_segment); i+=1;)
		with(ship.ship_segment[i]){
			if joint != noone
				physics_joint_delete(joint)
			if joint_above != noone
				physics_joint_delete(joint_above)
			if joint_right != noone
				physics_joint_delete(joint_right)
			if joint_below != noone
				physics_joint_delete(joint_below)
			if joint_left != noone
				physics_joint_delete(joint_left)
			joint = noone
			joint_above = noone;
			joint_right = noone;
			joint_below = noone;
			joint_left = noone;
		}
	
	// Move the segments 

	for(var i = 0; i < array_length_1d(ship.ship_segment); i+=1;){
		temp_segment = ship.ship_segment[i].ship_segment_left
		if temp_segment != noone{
			temp_segment.phy_position_x = ship.ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation+90)
			temp_segment.phy_position_y = ship.ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation+90)
			}
		temp_segment = ship.ship_segment[i].ship_segment_above
		if temp_segment != noone{
			temp_segment.phy_position_x = ship.ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation)
			temp_segment.phy_position_y = ship.ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation)
			}
		temp_segment = ship.ship_segment[i].ship_segment_right
		if temp_segment != noone{
			temp_segment.phy_position_x = ship.ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation-90)
			temp_segment.phy_position_y = ship.ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation-90)
			}
		temp_segment = ship.ship_segment[i].ship_segment_below
		if temp_segment != noone{
			temp_segment.phy_position_x = ship.ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation+180)
			temp_segment.phy_position_y = ship.ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation+180)
			}
		}
	
	// Update ship position = average of all segment positions

	var x_total = 0
	var y_total = 0;
	for(var i = 0; i < array_length_1d(ship.ship_segment); i+=1;){
		x_total += ship.ship_segment[i].phy_position_x
		y_total += ship.ship_segment[i].phy_position_y
		}
	ship.phy_position_x = x_total / array_length_1d(ship_segment)
	ship.phy_position_y = y_total / array_length_1d(ship_segment)

	// Join segments to ship
	/*

	for(var i = 0; i < array_length_1d(ship.ship_segment); i+=1;){
		if ship.ship_segment[i].ship_segment_above != noone
			if ship.ship_segment[i].ship_segment_above.joint_below == noone
				ship.ship_segment[i].joint_above = physics_joint_weld_create(ship.ship_segment[i], ship.ship_segment[i].ship_segment_above, ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y,0, 1000, 1000,false);
		if ship.ship_segment[i].ship_segment_right != noone
			if ship.ship_segment[i].ship_segment_right.joint_left == noone
				ship.ship_segment[i].joint_right = physics_joint_weld_create(ship.ship_segment[i], ship.ship_segment[i].ship_segment_right, ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y,0, 1000, 1000,false);
		if ship.ship_segment[i].ship_segment_below != noone
			if ship.ship_segment[i].ship_segment_below.joint_above == noone
				ship.ship_segment[i].joint_below = physics_joint_weld_create(ship.ship_segment[i], ship.ship_segment[i].ship_segment_below, ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y,0, 1000, 1000,false);
		if ship.ship_segment[i].ship_segment_left != noone
			if ship.ship_segment[i].ship_segment_left.joint_right == noone
				ship.ship_segment[i].joint_left = physics_joint_weld_create(ship.ship_segment[i], ship.ship_segment[i].ship_segment_left, ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y,0, 1000, 1000,false);
	}
	ship.ship_segment[0].joint = physics_joint_weld_create(ship.ship_segment[0], ship, ship.ship_segment[0].phy_position_x,ship.ship_segment[0].phy_position_y,0, 10000, 10000,false);
	*/
	for(var i = 0; i < array_length_1d(ship.ship_segment); i+=1;)
		ship.ship_segment[i].joint = physics_joint_weld_create(ship.ship_segment[i], ship, ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y,0, 10000, 10000,false);

	// Update placement angle and distance (for creating fake ships when warping)

	for(var i = 0; i < array_length_1d(ship.ship_segment); i+=1;){
			ship.ship_segment[i].placement_angle = ship.phy_rotation + point_direction(ship.phy_position_x,ship.phy_position_y,ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y)
			ship.ship_segment[i].placement_distance = point_distance(ship.phy_position_x,ship.phy_position_y,ship.ship_segment[i].phy_position_x,ship.ship_segment[i].phy_position_y)
		}


}

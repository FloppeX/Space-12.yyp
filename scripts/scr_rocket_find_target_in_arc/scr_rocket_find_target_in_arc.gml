function scr_rocket_find_target_in_arc(argument0, argument1, argument2, argument3) {
	var target_type = argument0
	var angle = argument1
	var angle_arc = argument2
	var range = argument3
	var target = noone
	var temp_distance = range;
	var closest_distance = range;
	var temp_object = noone;
	var temp_direction = angle;
	var closest_direction = angle;
	var temp_x,temp_y,i;


	if target_type == noone
		return noone

	if instance_number(target_type) <= 0
		return noone;

	for (i=0;i<instance_number(target_type);i+=1){
		target = instance_find(target_type,i)
		if target.visible == true{
			temp_x = target.phy_position_x - global.play_area_width
			temp_y = target.phy_position_y - global.play_area_height
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x 
			temp_y = target.phy_position_y - global.play_area_height
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x + global.play_area_width
			temp_y = target.phy_position_y - global.play_area_height
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x - global.play_area_width
			temp_y = target.phy_position_y 
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x 
			temp_y = target.phy_position_y
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x + global.play_area_width
			temp_y = target.phy_position_y 
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x - global.play_area_width
			temp_y = target.phy_position_y + global.play_area_height
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x 
			temp_y = target.phy_position_y + global.play_area_height
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
	
			temp_x = target.phy_position_x + global.play_area_width
			temp_y = target.phy_position_y + global.play_area_height
			temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
			if temp_distance < closest_distance{
				temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
				if abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
					temp_object = target;
					closest_distance = temp_distance
					closest_direction = temp_direction
					}
				}
		}
	}

	// Check if line of sight is blocked

	if temp_object != noone
		if collision_line(phy_position_x,phy_position_y,target.phy_position_x,target.phy_position_y,obj_parent_environment,0,1)
			temp_object = noone
		
	return temp_object;


}

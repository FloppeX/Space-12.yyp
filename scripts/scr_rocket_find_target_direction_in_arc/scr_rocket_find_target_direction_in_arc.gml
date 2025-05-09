function scr_rocket_find_target_direction_in_arc(argument0, argument1, argument2, argument3) {
	target_type = argument0
	angle = argument1
	angle_arc = argument2
	var range = argument3
	var target = noone
	var temp_distance = range;
	var closest_distance = range;
	var temp_direction = angle;
	var closest_direction = angle;
	var temp_x,temp_y,i;

	for (i=0;i<instance_number(target_type);i+=1){
	target = instance_find(target_type,i)
	if target.invisible == false{
	temp_x = target.phy_position_x - global.play_area_width
	temp_y = target.phy_position_y - global.play_area_height
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x 
	temp_y = target.phy_position_y - global.play_area_height
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x + global.play_area_width
	temp_y = target.phy_position_y - global.play_area_height
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x - global.play_area_width
	temp_y = target.phy_position_y 
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x 
	temp_y = target.phy_position_y
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x + global.play_area_width
	temp_y = target.phy_position_y 
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x - global.play_area_width
	temp_y = target.phy_position_y + global.play_area_height
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x 
	temp_y = target.phy_position_y + global.play_area_height
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	
	temp_x = target.phy_position_x + global.play_area_width
	temp_y = target.phy_position_y + global.play_area_height
	temp_distance = point_distance(phy_position_x,phy_position_y,temp_x,temp_y)
	temp_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
	if temp_distance < closest_distance and abs(angle_difference(angle, temp_direction)) < 0.5 * angle_arc{
		closest_distance = temp_distance
		closest_direction = point_direction(phy_position_x,phy_position_y,temp_x,temp_y)
		}
	}
	}

	return closest_direction


}

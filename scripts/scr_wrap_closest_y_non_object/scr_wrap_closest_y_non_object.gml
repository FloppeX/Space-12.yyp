function scr_wrap_closest_y_non_object(argument0, argument1) {
	// Takes: starting y coordinate, destination y coordinate
	// Returns: the closest equivalent destination y coordinate
	var obj;
	var origin_y = argument0
	var destination_y = argument1;
	if origin_y > destination_y
		if abs(origin_y - destination_y) < abs(origin_y - (destination_y + global.play_area_height))
			return destination_y
		else return destination_y + global.play_area_height
	if origin_y < destination_y
		if abs(origin_y - destination_y) < abs(origin_y - (destination_y - global.play_area_height))
			return destination_y
		else return destination_y - global.play_area_height
	return 0;


}

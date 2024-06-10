function scr_ship_modifier_squidface_geologist(argument0) {
	// Description text

	modifier_description = ("Squidface geologist")

	// Modifier script

	var seek_range = argument0; // 300?
	var target = noone;
	pointer = noone;
	
	// Find target
	target = scr_wrap_nearest_instance(obj_asteroid_big_credit)
	if target == noone
	target = scr_wrap_nearest_instance(obj_asteroid_medium_credit)
	if target == noone
	target = scr_wrap_nearest_instance(obj_asteroid_small_credit)
	
	if target != noone
		if pointer == noone
			pointer = instance_create_depth(0,0,-15,obj_crew_squidface_geologist_pointer);
		
	if pointer != noone{
		pointer.x = phy_position_x
		pointer.y = phy_position_y
		pointer.image_angle = scr_wrap_direction_to_point(phy_position_x, phy_position_y, target.phy_position_x,target.phy_position_y)
		if target == noone
			instance_destroy(pointer)
	}


}

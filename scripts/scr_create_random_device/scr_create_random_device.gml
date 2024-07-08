function scr_create_random_device() {
	var temp_module = scr_create_random_module(global.array_player_devices)
	
	if temp_module.fixed_rotation
		temp_module.offset_angle = temp_module.fixed_rotation
	else
		temp_module.offset_angle = irandom(3) * 90;
	/*
	if object_is_ancestor(temp_module.object_index, obj_module_engine)
		temp_module.offset_angle = 0
	
	if object_is_ancestor(temp_module.object_index, obj_module_rotational_thrusters)
		temp_module.offset_angle = 0
	*/
	return temp_module;



}

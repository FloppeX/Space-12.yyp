function scr_create_random_enemy_device() {
	var i = irandom(global.difficulty_level+4);
		i = clamp(i,0,8)
	switch (i){
		case 0: temp_module = instance_create_depth(0,0,-10,obj_module_force_shield_enemy); break;
		case 1: temp_module = instance_create_depth(0,0,-10,obj_module_shield_enemy); break;
		case 2: temp_module = instance_create_depth(0,0,-10,obj_module_reflective_shield_enemy); break;
		case 3: temp_module = instance_create_depth(0,0,-10,obj_module_deaths_head); break;
		case 4: temp_module = instance_create_depth(0,0,-10,obj_module_match_grade_ammo); break;
		case 5: temp_module = instance_create_depth(0,0,-10,obj_module_hyperkinetic_ammo); break;
		case 6: temp_module = instance_create_depth(0,0,-10,obj_module_static_amplifier); break;
		case 7: temp_module = instance_create_depth(0,0,-10,obj_module_autonomus_targeting_array); break;
		case 8: temp_module = instance_create_depth(0,0,-10,obj_module_biomechanical_actuator); break;
		}
	temp_module.persistent = false
	
	temp_module.offset_angle = irandom(3) * 90;
	
	return temp_module;



}

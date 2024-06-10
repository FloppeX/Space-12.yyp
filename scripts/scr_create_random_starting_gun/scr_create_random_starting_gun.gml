function scr_create_random_starting_gun() {
	var temp_module = scr_create_random_module(global.array_player_weapons)
	var i = irandom(2)
	switch (i){
		case 0: temp_module = instance_create_depth(0,0,-10,obj_module_scatter_gun); break;
		case 1: temp_module = instance_create_depth(0,0,-10,obj_module_blaster); break;
		case 2: temp_module = instance_create_depth(0,0,-10,obj_module_shotgun); break;
		//case 3: temp_module = instance_create_depth(0,0,-10,obj_module_teleporter); break;
		}
	temp_module.offset_angle = irandom(3) * 90;

	temp_module.placement_req_above = 1 // any placement allowed
	temp_module.placement_req_right = 1
	temp_module.placement_req_below = 1
	temp_module.placement_req_left = 1

	if temp_module.offset_angle == 0
		temp_module.placement_req_above = noone
	if temp_module.offset_angle == 90
		temp_module.placement_req_left = noone
	if temp_module.offset_angle == 180
		temp_module.placement_req_below = noone
	if temp_module.offset_angle == 270
		temp_module.placement_req_right = noone
	
	// Add modifiers
	//with(temp_module)
	//	scr_add_modifier_new(scr_module_modifier_angular_bullets,0,0,0,0)


	repeat(irandom(1)+1){
		var p = random(100)
		if p < 50
			with (temp_module)
				scr_add_random_modifier_common();
			
		if p >= 50 and p < 75
			with (temp_module)
				scr_add_random_modifier_uncommon();
				
		if p >= 75 and p < 90
			with (temp_module)
				scr_add_random_modifier_rare();
			
				
		if p >= 90
			with (temp_module)
				scr_add_random_modifier_exotic();

	repeat(irandom(2))
			with (temp_module)
				scr_add_random_modifier_negative();

		}	
	
	
	return temp_module;



}

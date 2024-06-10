function scr_create_random_enemy_2_weapon() {
	var h = irandom(global.difficulty_level+2)
	h = clamp(h,0,8)
		switch (h){
			case 0: temp_module = instance_create_depth(0,0,-10,obj_module_scatter_gun_enemy_2); break;
			case 1: temp_module = instance_create_depth(0,0,-10,obj_module_scatter_gun_enemy_2); break;
			case 2: temp_module = instance_create_depth(0,0,-10,obj_module_blaster_enemy_2); break;
			case 3: temp_module = instance_create_depth(0,0,-10,obj_module_blaster_enemy_2); break;
			case 4: temp_module = instance_create_depth(0,0,-10,obj_module_shotgun_enemy_2); break;
			case 5: temp_module = instance_create_depth(0,0,-10,obj_module_shotgun_enemy_2); break;
			case 6: temp_module = instance_create_depth(0,0,-10,obj_module_zapper_enemy_2); break;
			case 7: temp_module = instance_create_depth(0,0,-10,obj_module_cannon_enemy_2); break;
			case 8: temp_module = instance_create_depth(0,0,-10,obj_module_rocket_launcher_enemy_2); break;
			}
		temp_module.persistent = false
	
		temp_module.placement_req_above = 1 // any placement allowed
		temp_module.placement_req_right = 1
		temp_module.placement_req_below = 1
		temp_module.placement_req_left = 1
	
		temp_module.offset_angle = irandom(3) * 90;

		if temp_module.offset_angle == 0
			temp_module.placement_req_above = noone
		if temp_module.offset_angle == 90
			temp_module.placement_req_left = noone
		if temp_module.offset_angle == 180
			temp_module.placement_req_below = noone
		if temp_module.offset_angle == 270
			temp_module.placement_req_right = noone
		
		repeat(irandom(global.difficulty_level)){
			var p = irandom(99)
			if p <= 59 and p >= 40
				with (temp_module)
					scr_add_random_modifier_common()
			if p <= 39 and p >= 25
				with (temp_module)
					scr_add_random_modifier_uncommon();
			var p = irandom(99)
			if p <= 24 and p >= 10
				with (temp_module)
					scr_add_random_modifier_rare();
			var p = irandom(99)
			if p <= 9 and p >= 0
				with (temp_module)
					scr_add_random_modifier_exotic();
				
		// Chance for negative modifier
		repeat(irandom(3)){
			var p = irandom(99)
			if p <= 29 and p >= 0
				with (temp_module)
					scr_add_random_modifier_negative();
			}
		}

	return temp_module;



}


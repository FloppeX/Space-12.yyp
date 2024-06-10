function scr_ship_modifier_ratling_gunner(argument0) {
	// Description text
	value = argument0
	modifier_description = ("Ratling gunner")

	// Modifier script
/*
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		if scr_exists(ship_segment[i].module){
			ship_segment[i].module.bullet_spread_bonus += 5
			ship_segment[i].module.recoil_force_multiplier += 0.1
			ship_segment[i].module.bullet_spread_multiplier += 0.4
			ship_segment[i].module.bullet_interval_multiplier -= 0.2
			}
			
	*/
	with(obj_module_gun)
	//if scr_module_is_neighbor(other,id)
			//scr_module_modifier_aim_towards_enemy(90)
				if owner == other and offset_angle == 180{
					scr_module_modifier_aim_towards_enemy(45)
					scr_autoshoot(obj_enemy_ship,obj_asteroid)
	}

}

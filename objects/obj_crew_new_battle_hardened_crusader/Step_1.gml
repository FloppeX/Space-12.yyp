with(owner)
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
			if scr_exists(ship_segment[i].module){
				ship_segment[i].module.bullet_damage_multiplier += 0.1
				ship_segment[i].module.bullet_push_force_multiplier += 1
				}
event_inherited();

with(owner)
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
			if scr_exists(ship_segment[i].module)
				if scr_chance_percent(20 + luck)
					ship_segment[i].module.bullet_damage_multiplier +=1
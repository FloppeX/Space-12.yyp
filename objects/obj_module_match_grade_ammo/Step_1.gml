event_inherited();
	
with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		bullet_range_bonus += 50
		bullet_spread_multiplier *= 0.4
		bullet_interval_multiplier *= 1.2
	}
		
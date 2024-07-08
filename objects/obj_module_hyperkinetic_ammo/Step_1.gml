event_inherited();

will_affect_neighbor = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		other.will_affect_neighbor = true
		bullet_speed_multiplier *= 1.5
	}

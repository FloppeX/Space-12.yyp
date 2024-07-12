event_inherited();

will_affect_neighbor = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		bullet_push_force_bonus += 2
		bullet_push_force_multiplier *= -2
		other.will_affect_neighbor = true
	}
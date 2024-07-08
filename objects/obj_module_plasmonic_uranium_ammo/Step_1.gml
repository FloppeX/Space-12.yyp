event_inherited();

will_affect_neighbor = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		other.will_affect_neighbor = true
		bullet_damage_multiplier *= 1.2
		bullet_push_force_multiplier *= 1.2
		particle_cost_bonus += 0.3
	}
		
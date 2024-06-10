event_inherited();

will_affect_neighbor = false

with(obj_module_engine)
	if scr_module_is_neighbor(other,id){
		owner.max_speed_bonus += 0.8;
		other.will_affect_neighbor = true
	}

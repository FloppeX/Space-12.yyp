event_inherited();
	
offset_angle = 0

will_affect_neighbor = false

with(obj_module_engine)
	if scr_module_is_neighbor(other,id){
		owner.max_speed_bonus += 0.5
		thrust_bonus += 10
		other.will_affect_neighbor = true
	}
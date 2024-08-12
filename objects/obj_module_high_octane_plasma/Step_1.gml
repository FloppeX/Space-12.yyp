event_inherited();

connected = false

with(obj_module_engine)
	if scr_module_is_neighbor(other,id){
		owner.max_speed_bonus += 0.8;
		other.connected = true
	}

event_inherited();
	
offset_angle = 0

connected = false

with(obj_module_engine)
	if scr_module_is_neighbor(other,id){
		owner.max_speed_bonus += 0.5
		thrust_bonus += 10
		other.connected = true
	}
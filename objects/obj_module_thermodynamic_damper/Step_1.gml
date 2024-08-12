event_inherited();

connected = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		other.connected = true
		recoil_force_multiplier *= 0.4
	}
	
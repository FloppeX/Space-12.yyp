event_inherited();

connected = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		bullet_damage_bonus += 1
		other.connected = true
	}
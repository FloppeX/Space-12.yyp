event_inherited();

connected = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
			scr_module_modifier_aim_towards_enemy(90)
			other.connected = true
	}
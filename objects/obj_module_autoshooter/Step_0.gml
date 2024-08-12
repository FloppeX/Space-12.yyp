event_inherited();

connected = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		scr_autoshoot(obj_enemy_ship,obj_asteroid)
		other.connected = true
	}
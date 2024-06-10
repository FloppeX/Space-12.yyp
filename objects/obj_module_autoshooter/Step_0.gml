event_inherited();

will_affect_neighbor = false

with(obj_module_gun)
	//if scr_module_is_neighbor(other,id)
			//scr_module_modifier_aim_towards_enemy(90)
				if owner == other.owner and offset_angle == 270{
					scr_module_modifier_aim_towards_enemy(45)
					scr_autoshoot(obj_enemy_ship,obj_asteroid)
					other.will_affect_neighbor = true
	}
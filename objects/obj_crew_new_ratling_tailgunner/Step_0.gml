with(obj_module_gun)
	if owner == other.owner and offset_angle == 180{
		scr_module_modifier_aim_towards_enemy(45)
		scr_autoshoot(obj_enemy_ship,obj_asteroid)
	}
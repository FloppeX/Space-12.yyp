function scr_ship_modifier_ratling_gunner(argument0) {
	// Description text
	value = argument0
	modifier_description = ("Ratling gunner")

	// Modifier script

	with(obj_module_gun)
	//if scr_module_is_neighbor(other,id)
			//scr_module_modifier_aim_towards_enemy(90)
				if owner == other and offset_angle == 180{
					scr_module_modifier_aim_towards_enemy(45)
					scr_autoshoot(obj_enemy_ship,obj_asteroid)
	}

}

event_inherited();

will_affect_neighbor = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id)
			other.will_affect_neighbor = true

with(obj_bullet)
	if scr_exists(id.owner)
		if scr_module_is_neighbor(other,id.owner){
			var temp_time = global.game_timer mod 1200
			if temp_time < 400
				scr_bullet_modifier_angular()
			if temp_time >= 400 and temp_time < 800
				scr_bullet_modifier_circle()
			if temp_time >= 800
				scr_bullet_modifier_wavy()
			}
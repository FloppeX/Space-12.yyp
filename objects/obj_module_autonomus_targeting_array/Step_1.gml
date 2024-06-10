event_inherited();

will_affect_neighbor = false

with(obj_module_gun)
	if scr_module_is_neighbor(other,id){
		other.will_affect_neighbor = true
		if bullets[0] != noone
		for(var i = 0; i < array_length_1d(bullets); i+=1;)
				with(bullets[i])
					scr_add_modifier(scr_bullet_modifier_seek)
	}
			
			

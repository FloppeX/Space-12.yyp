function scr_module_modifier_remote_control() {
	// Description text

	modifier_description = "Remote control"

	// Modifier actions

	bullet_range_multiplier *=2

	if bullets[0] != noone
		for(var i = 0; i < array_length_1d(bullets); i+=1;)
			with(bullets[i]){
				scr_add_modifier(scr_bullet_modifier_remote_control)
				sprite_index = spr_laser_glow
			}


}

function scr_module_modifier_heavy_bullets() {
	// Description text

	// Modifier actions

	if bullets[0] != noone
		for(var i = 0; i < array_length_1d(bullets); i+=1;)
			with(bullets[i])
				scr_add_modifier(scr_bullet_modifier_heavy_bullets)


}

function scr_module_modifier_homing_bullets() {
	// Description text

	// Modifier actions

	if bullets[0] != noone
		for(var i = 0; i < array_length_1d(bullets); i+=1;)
			if scr_chance_percent(20*owner.luck) // 20% chance
				with(bullets[i]){
					scr_add_modifier(scr_bullet_modifier_seek)
					
				}


}

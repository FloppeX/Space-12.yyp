function scr_module_modifier_exploding_bullets() {
	// Description text

	// Modifier actions

	var chance_for_exploding_bullet = 20

	if bullets[0] != noone
		for(var i = 0; i < array_length_1d(bullets); i+=1;)
			if scr_chance_percent(chance_for_exploding_bullet*owner.luck)
				with(bullets[i])
					scr_add_modifier(scr_bullet_modifier_exploding)



}

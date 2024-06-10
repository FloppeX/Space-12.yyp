function scr_module_modifier_bullet_speed_mult_30() {
	// Description text

	modifier_description = "Bullet speed +30%"
	/*
	if array_length_1d(description_lines) < array_length_1d(modifiers)
		description_lines[array_length_1d(description_lines)] = modifier_description
	*/
	// Modifier script

	bullet_speed_multiplier += 0.3


}

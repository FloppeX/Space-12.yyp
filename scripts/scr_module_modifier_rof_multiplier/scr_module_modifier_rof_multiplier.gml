function scr_module_modifier_rof_multiplier(argument0) {
	// Description text
	value = argument0
	//modifier_description = ("Rate of fire +"+ string(abs(round(value*100)))+"%")

	// Modifier script

	bullet_interval_multiplier *= value


}

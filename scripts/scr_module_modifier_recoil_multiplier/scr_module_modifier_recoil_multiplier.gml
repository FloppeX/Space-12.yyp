function scr_module_modifier_recoil_multiplier(argument0) {
	// Description text
	value = argument0
	//modifier_description = ("Recoil -"+ string(abs(round(value*100)))+"%")

	// Modifier script

	recoil_force_multiplier += value


}

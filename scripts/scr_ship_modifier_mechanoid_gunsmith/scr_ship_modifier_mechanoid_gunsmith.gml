function scr_ship_modifier_mechanoid_gunsmith(argument0) {
	// Description text
	value = argument0
	modifier_description = ("Mechanoid gunsmith")

	// Modifier script


	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		if scr_exists(ship_segment[i].module){
			ship_segment[i].module.bullet_range_multiplier *= 1.5
			ship_segment[i].module.recoil_force_multiplier *= 1.5
			}


}

function scr_ship_modifier_bloodsucker(argument0) {
	// Description text
	value = argument0
	modifier_description = ("Bloodsucker")

	// Modifier script

	if room == rm_space or room == rm_boss
		repeat(global.enemies_killed_this_step){
				obj_health += 5
				audio_play_sound_on(ship_audio_emitter,snd_slurp_blood,0,1)
				}
	


}

event_inherited();

if room == rm_space or room == rm_boss
	repeat(global.enemies_killed_this_step){
			owner.obj_health += 5
			audio_play_sound_on(owner.ship_audio_emitter,snd_slurp_blood,0,1)
			}
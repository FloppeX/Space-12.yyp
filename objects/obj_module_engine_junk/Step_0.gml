event_inherited();

shutdown_timer -= 1

if owner.add_thrust > 0.98
	if irandom (1000) == 0{
		shutdown_timer = shutdown_timer_start
		audio_play_sound_on(module_audio_emitter,snd_explosion_small_01,0,1)
	}
	
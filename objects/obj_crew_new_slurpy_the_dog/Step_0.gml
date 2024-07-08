event_inherited();

with(obj_crew_token)
	if timer == 300{
		credit_cost -= 2
		audio_play_sound_on(other.owner.ship_audio_emitter,snd_dog_bark,0,1)
	}

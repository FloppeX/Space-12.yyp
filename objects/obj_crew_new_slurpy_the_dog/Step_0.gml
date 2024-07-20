event_inherited();

with(obj_module)
	if timer == 300{
		credit_cost = floor(credit_cost * 0.8)
		audio_play_sound_on(other.owner.ship_audio_emitter,snd_dog_bark,0,1)
	}

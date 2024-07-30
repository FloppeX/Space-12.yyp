delay -= 1

if open == true
	close = false
else 
	close = true
		
if open and delay <= 0 and !fully_open{
	fully_closed = false
	door_travel_x += door_speed
	if !fully_open and !audio_is_playing(door_noise){
		door_noise = audio_play_sound_on(audio_emitter,snd_door_loop,1,1)
		audio_sound_pitch(door_noise,door_sound_pitch)
	}
	if door_travel_x >= 23 and !fully_open{
		door_travel_x = 23
		fully_open = true
		audio_stop_sound(door_noise)
		door_noise = audio_play_sound_on(audio_emitter,snd_door_end_2,0,1)
		audio_sound_pitch(door_noise,door_sound_pitch)
	}
}

if close and delay <= 0 and !fully_closed{
	fully_open = false
	door_travel_x -= door_speed
	if !fully_closed and !audio_is_playing(door_noise){
		door_noise = audio_play_sound_on(audio_emitter,snd_door_loop,1,1)
		audio_sound_pitch(door_noise,door_sound_pitch)
	}
	if door_travel_x < door_closed_offset and !fully_closed{
		door_travel_x = door_closed_offset
		fully_closed = true
		audio_stop_sound(door_noise)
		door_noise = audio_play_sound_on(audio_emitter,snd_door_end_2,0,1)
		audio_sound_pitch(door_noise,door_sound_pitch)
	}
}
		
if keyboard_check_pressed(vk_delete)
	if close{
		delay = delay_start
		close = false
		open = true
	}
	else{
		delay = delay_start
		close = true
		open = false
	}
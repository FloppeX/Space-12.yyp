open = false
close = true
fully_closed = true
fully_open = false
door_speed = 0.2 //+ random(0.4)
door_sound_pitch = random(0.8)+0.6
door_closed_offset = 0.8
door_travel_x = door_closed_offset
delay_start = irandom(60)
delay = delay_start

//Sounds
door_noise = noone
audio_emitter = audio_emitter_create()
audio_emitter_falloff(audio_emitter, 180,600, 1);
audio_emitter_position(audio_emitter,x,y,0)


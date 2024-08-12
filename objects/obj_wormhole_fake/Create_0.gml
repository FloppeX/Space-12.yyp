timer = 0

effect_sprite = spr_wormhole
rotation = 0
rotation_speed = 1
rotation_dir_shifter = 1
hue_min = 70
hue_max = 140
hue = hue_min
color = 0;

depth = 0

wormhole_segments = 10
wormhole_size = 0
particle_speed = 0//random(2)-1// 0.9
particle_speed_change = 0//random(0.02) * -sign(particle_speed)// -0.015

life_timer = 0

draw_position_x = 0
draw_position_y = 0

//Sounds

sound = snd_wormhole_loop
audio_emitter = audio_emitter_create()
audio_emitter_falloff(audio_emitter, 100, 1200, 1);

audio_play_sound_on(audio_emitter,sound,1,0.8)
event_inherited();

module_name = "Engine"

cost = 6

placement_req_below = noone

fixed_rotation = 360

//

thrust_base = 60
thrust_bonus = 0 
thrust_multiplier = 1

energy_cost_base = 0.5

// Particles

part_engine_flame = part_type_create();
part_engine_flame = global.part_rocket_smoke_2

part_engine_smoke = part_type_create();
part_engine_smoke = global.smoke_particle
/*
part_type_shape(part_engine_flame,pt_shape_disk);
part_type_size(part_engine_flame,0.08,0.12,0,0);
part_type_scale(part_engine_flame,1,1);
part_type_color3(part_engine_flame,c_white,c_yellow,c_red);
part_type_alpha3(part_engine_flame,1,0.5,0);
part_type_speed(part_engine_flame,0,10,0,0);
part_type_life(part_engine_flame,1,5);
*/

sound_priority = 1

sound = snd_engine_2b

engine_noise = audio_play_sound_on(module_audio_emitter,sound,1,sound_priority)
audio_sound_set_track_position(engine_noise,random(audio_sound_length(sound)));



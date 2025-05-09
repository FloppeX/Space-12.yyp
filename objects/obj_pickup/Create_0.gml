event_inherited();
timer = 0
max_age = 900
scale = 1
alpha = 1

max_speed = 10
phy_rotation = random(360)

pickup_glow_particle = part_type_create();
part_type_sprite(pickup_glow_particle,sprite_index,false,false,false);            
part_type_size(pickup_glow_particle,1.5,2,0,0.1);                   
part_type_scale(pickup_glow_particle,1,1);                     
part_type_alpha3(pickup_glow_particle,0.1,0.2,0);
part_type_speed(pickup_glow_particle,0,0,0,0);         
part_type_direction(pickup_glow_particle,0,0,0,1);            
part_type_orientation(pickup_glow_particle,0,0,0,0,1);      
part_type_blend(pickup_glow_particle,true);                      
part_type_life(pickup_glow_particle,5,10);


//Sound
audio_emitter = audio_emitter_create()
audio_emitter_falloff(audio_emitter, 100, 600, 1);
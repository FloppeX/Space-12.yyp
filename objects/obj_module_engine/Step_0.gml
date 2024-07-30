event_inherited();

if !scr_exists(owner)
	exit

if !audio_is_playing(engine_noise)
	engine_noise = audio_play_sound_on(module_audio_emitter,sound,1,sound_priority)

thrust = (thrust_base + thrust_bonus) * thrust_multiplier

var add_thrust = owner.add_thrust
thrust = thrust * add_thrust

if  thrust > 0 and visible and (owner.energy >= energy_cost){
	if owner.phy_speed < owner.max_speed
		owner.energy -= energy_cost*add_thrust
	var temp_dist = point_distance(phy_position_x,phy_position_y,owner.phy_position_x,owner.phy_position_y)
	var temp_dir = point_direction(phy_position_x,phy_position_y,owner.phy_position_x,owner.phy_position_y)
	var thrust_point_offset = 0.5
	var thrust_point_x = phy_position_x + lengthdir_x(temp_dist * thrust_point_offset,temp_dir)
	var thrust_point_y = phy_position_y + lengthdir_y(temp_dist * thrust_point_offset,temp_dir)
	
	physics_apply_force(thrust_point_x,thrust_point_y,lengthdir_x(thrust,-phy_rotation),lengthdir_y(thrust,-phy_rotation))	
		
	flame_offset_distance = 10
	flame_offset_angle = 180
	
	tmp_size = 0.2 + random(0.1)
	part_type_size(part_engine_smoke,tmp_size,tmp_size,0,0);
	part_type_speed(part_engine_smoke,2*add_thrust+2,4*add_thrust+2,-0.3,0.1);
	temp_dir = point_direction(phy_position_xprevious,phy_position_yprevious,phy_position_x,phy_position_y)
	part_type_direction(part_engine_smoke,180-phy_rotation,180-phy_rotation,0,2);
	part_type_orientation(part_engine_smoke,-phy_rotation,-phy_rotation,0,0,0)
	part_type_alpha2(part_engine_smoke,0.5*owner.alpha,0);
	tmp_life = 30+random(10)
	part_type_life(part_engine_smoke,tmp_life,tmp_life);
	part_particles_create(global.part_system_below,phy_position_x+lengthdir_x(flame_offset_distance,-phy_rotation+flame_offset_angle), phy_position_y+ lengthdir_y(flame_offset_distance,-phy_rotation+flame_offset_angle), part_engine_smoke, 1);
	part_particles_create(global.part_system_below,mirror_x, phy_position_y, part_engine_smoke, 1);
	part_particles_create(global.part_system_below,phy_position_x, mirror_y, part_engine_smoke, 1);
	part_particles_create(global.part_system_below,mirror_x, mirror_y, part_engine_smoke, 1);
	
	tmp_life = 10+random(10)
	part_type_life(part_engine_flame,tmp_life,tmp_life);
	part_type_speed(part_engine_flame,2*add_thrust+2,4*add_thrust+2,-0.3,2);
	temp_dir = point_direction(phy_position_xprevious,phy_position_yprevious,phy_position_x,phy_position_y)
	part_type_direction(part_engine_flame,180-phy_rotation,180-phy_rotation,0,2);
	part_type_orientation(part_engine_flame,-phy_rotation,-phy_rotation,0,0,0)
	part_type_alpha2(part_engine_flame,0.6*owner.alpha,0);
	part_particles_create(global.part_system_below , phy_position_x+lengthdir_x(flame_offset_distance,-phy_rotation+flame_offset_angle), phy_position_y+ lengthdir_y(flame_offset_distance,-phy_rotation+flame_offset_angle), part_engine_flame, 6);
	}

audio_emitter_gain(module_audio_emitter, add_thrust);

// TEST

event_inherited()

// Fire effects
	
tmp_size = 0.2 + random(0.1)
part_type_size(part_engine_smoke,tmp_size,tmp_size,0,0);
part_type_speed(part_engine_smoke,0.4,0.6,-0.3,0.1);
part_type_direction(part_engine_smoke,180-phy_rotation,180-phy_rotation,0,1);
part_type_orientation(part_engine_smoke,-phy_rotation,-phy_rotation,0,0,0)
part_type_alpha2(part_engine_smoke,0.4,0);
tmp_life = 10+random(6)
part_type_life(part_engine_smoke,tmp_life,tmp_life);
part_particles_create(global.part_system_above,phy_position_x, phy_position_y, part_engine_smoke, 1);
part_particles_create(global.part_system_above,mirror_x, phy_position_y, part_engine_smoke, 1);
part_particles_create(global.part_system_above,phy_position_x, mirror_y, part_engine_smoke, 1);
part_particles_create(global.part_system_above,mirror_x, mirror_y, part_engine_smoke, 1);
	
tmp_life = 20+random(6)
part_type_life(part_engine_flame,tmp_life,tmp_life);
part_type_speed(part_engine_flame,0.1,0.2,-0.3,0.1);
part_type_direction(part_engine_flame,180-phy_rotation,180-phy_rotation,0,4);
part_type_orientation(part_engine_flame,-phy_rotation,-phy_rotation,0,0,0)
part_type_alpha2(part_engine_flame,0.6,0);
part_particles_create(global.part_system_above , phy_position_x, phy_position_y, part_engine_flame, 1);

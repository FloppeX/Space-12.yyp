function scr_engine_smoke_particles(argument0) {
	var number_of_particles = argument0

	var tmp_size,tmp_speed,tmp_direction,tmp_life;
	repeat(number_of_particles){
		tmp_size = 0.1 + random(0.1)
		part_type_size(global.smoke_particle,tmp_size,tmp_size,0,0);
		tmp_speed = 0 + random(0.1)
		part_type_speed(global.smoke_particle,tmp_speed,tmp_speed,-0.03,0);
		tmp_direction = random(359)
		part_type_direction(global.smoke_particle,tmp_direction,tmp_direction,0,0);
		tmp_life = 40+random(40)
		part_type_life(global.smoke_particle,tmp_life,tmp_life);
	
		part_particles_create(global.part_system_below,phy_position_x, phy_position_y, global.smoke_particle, 1);
		part_particles_create(global.part_system_below,mirror_x, phy_position_y, global.smoke_particle, 1);
		part_particles_create(global.part_system_below,phy_position_x, mirror_y, global.smoke_particle, 1);
		part_particles_create(global.part_system_below,mirror_x, mirror_y, global.smoke_particle, 1);
	}


}

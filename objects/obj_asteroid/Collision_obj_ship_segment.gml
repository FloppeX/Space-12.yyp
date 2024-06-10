if age >= 40
	if other.owner.hit_invulnerable_timer <= 0{
		collision_victim = other
		collided = true
		collision_timer = collision_timer_length
		with (other)
			if owner.hit_invulnerable_timer == 0
				{
				//audio_play_sound_on(owner.ship_audio_emitter,snd_,0,1)
				//obj_health -= other.damage
				//disabled_timer += 30
				owner.hit_invulnerable_timer = 10
				temp_dir = point_direction(other.phy_position_x,other.phy_position_y,phy_position_x,phy_position_y)
				var x_force = lengthdir_x(other.push_force,temp_dir)
				var y_force = lengthdir_y(other.push_force,temp_dir)
				physics_apply_impulse(phy_position_x,phy_position_y,x_force,y_force)
				}
		for(var i = 0; i < phy_collision_points; i += 1;)
			scr_create_smoke_particles(phy_collision_x[i], phy_collision_y[i])
	}
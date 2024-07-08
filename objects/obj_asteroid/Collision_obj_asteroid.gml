if timer >= 40 and other.timer > 40{
collision_victim = other
collided = true
collision_timer = collision_timer_length
for(var i = 0; i < phy_collision_points; i += 1;){
	scr_create_smoke_particles(phy_collision_x[i], phy_collision_y[i])
	}

}

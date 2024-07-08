// Set variables that may have been changed by modifiers

bullet_damage = (bullet_damage_base + bullet_damage_bonus) * bullet_damage_multiplier
bullet_range = (bullet_range_base + bullet_range_bonus) * bullet_range_multiplier
bullet_speed = (bullet_speed_base + bullet_speed_bonus) * bullet_speed_multiplier
bullet_speed_randomness = (bullet_speed_randomness_base + bullet_speed_randomness_bonus) * bullet_speed_randomness_multiplier
bullet_interval = (bullet_interval_base + bullet_interval_bonus) * bullet_interval_multiplier
bullet_push_force = (bullet_push_force_base + bullet_push_force_bonus) * bullet_push_force_multiplier
recoil_force = (recoil_force_base + recoil_force_bonus) * recoil_force_multiplier
bullet_spread = (bullet_spread_base + bullet_spread_bonus) * bullet_spread_multiplier
bullet_number = round((bullet_number_base + bullet_number_bonus) * bullet_number_multiplier)
energy_cost = (energy_cost_base + energy_cost_bonus) * energy_cost_multiplier
particle_cost = (particle_cost_base + particle_cost_bonus) * particle_cost_multiplier

// Timer

timer += 1

//	Check if already activated by activation timer
	
if activation_timer > 0{
	activated = true
	activation_timer -= 1
	}

// orient to correct angle

angle_diff = angle_difference(-phy_rotation, target_angle)
if joint != noone{
	physics_joint_set_value(joint,phy_joint_max_motor_torque,10000)
	physics_joint_set_value(joint,phy_joint_max_motor_force,10000)
	physics_joint_set_value(joint,phy_joint_motor_speed,0.8 * angle_diff)
}
target_angle = -owner.phy_rotation + offset_angle

// Mirror owners alpha

alpha = owner.alpha

//

audio_emitter_position(module_audio_emitter,phy_position_x,phy_position_y,0)
audio_emitter_velocity(module_audio_emitter, phy_speed_x, phy_speed_y, 0);

// Find mirror positions

// scr_find_mirror_positions();

// Wrap movement

//scr_wrap_room()//_test();

// Update surrounding modules
if ship_segment != noone{
	if ship_segment.ship_segment_above != noone
		module_above = ship_segment.ship_segment_above.module
	if ship_segment.ship_segment_right != noone
		module_right = ship_segment.ship_segment_right.module
	if ship_segment.ship_segment_below != noone
		module_below = ship_segment.ship_segment_below.module
	if ship_segment.ship_segment_left != noone
		module_left = ship_segment.ship_segment_left.module
}

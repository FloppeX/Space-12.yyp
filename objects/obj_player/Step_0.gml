// Timer

timer += 1

// Calculate variables that may be changed by modifiers
// Calculate variables that may be changed by modifiers

max_speed = (max_speed_base + max_speed_bonus) * max_speed_multiplier
rotation_speed = (rotation_speed_base + rotation_speed_bonus) * rotation_speed_multiplier
drift_resistance = (drift_resistance_base + drift_resistance_bonus) * drift_resistance_multiplier
max_health = (max_health_base + max_health_bonus) * max_health_multiplier
max_energy = (max_energy_base + max_energy_bonus) * max_energy_multiplier
max_particles = (max_particles_base + max_particles_bonus) * max_particles_multiplier
energy_increase = (energy_increase_base + energy_increase_bonus) * energy_increase_multiplier
luck = (luck_base + luck_bonus) * luck_multiplier

// Make sure that global.luck == luck

global.luck = luck



// Disabled?

disabled_timer -= 1;
if disabled_timer < 0 
	disabled_timer = 0
if disabled_timer > 0 
	controls_disabled = true
else controls_disabled = false

// Hit invulnerability

if hit_invulnerable_timer > 0
	hit_invulnerable_timer -= 1

	
// Turn

if controls_disabled == false{
	
	if abs(phy_angular_velocity) < rotation_speed{
		physics_apply_torque(array_length_1d(ship_segment) * rotation_force * rotation_value)
		phy_angular_damping = 2 * array_length_1d(ship_segment) + add_thrust * 10
		}
	else
		phy_angular_damping = 30
}
else phy_angular_damping = 4
	
// Stop ship from skidding
if add_thrust
	scr_counter_lateral_drift();
	
// dont move faster than max speed
if phy_speed > max_speed{
	var friction_coeff = 15
	//var temp_dir = point_direction(0,0,phy_speed_x,phy_speed_y)
	physics_apply_force(phy_position_x,phy_position_y,friction_coeff * -phy_speed_x,friction_coeff * -phy_speed_y)
	}
	

// Health

health_difference = obj_health_old - obj_health
if health_difference > 0{
	global.screen_shake_intensity = health_difference
	global.screen_shake_duration = health_difference 
	}
	
	
if obj_health <= 0 and destroyed == false{
	scr_explode_ship();
	//phy_active = false
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
		if scr_exists(ship_segment[i].module)
			with(ship_segment[i].module)
				instance_destroy() 
		with(ship_segment[i])
				instance_destroy()
		}
	ship_segment = noone
	with(obj_crew_new)
		instance_destroy()
	audio_play_sound_at(explosion_sound,phy_position_x,phy_position_y,0,100,800,1,0,1)
	boom = instance_create_depth(phy_position_x,phy_position_y,-10,obj_explosion)
	boom.radius = 300
	boom.damage = 50
	
	scr_write_stats_to_file()
	destroyed = true
	visible = false
	//instance_destroy();
	exit;
	}	
		

// Energy, health, particles

if energy_disabled
	energy_disabled_timer -=1

if round(energy) <= 0{
	energy_disabled = true
	energy_disabled_timer -= 1
	}
	
if energy_disabled_timer <= 0{
	energy_disabled = false
	energy_disabled_timer = energy_disabled_duration
	}
	
if !energy_disabled
	energy += energy_increase
	
energy = clamp(energy,0,max_energy)

obj_health = clamp(obj_health,0,max_health)
obj_health_old = obj_health
	
particles = clamp(particles,0,max_particles)	



// Sound

audio_emitter_position(ship_audio_emitter,phy_position_x,phy_position_y,0)

//audio_listener_orientation(0,1,0,0,0,1)
//audio_listener_velocity(phy_speed_x, phy_speed_y, 0);

// Credits
if obj_health > 0{
	var pickup_type = obj_pickup_credit

	if instance_number(pickup_type) > 0
		for(var i = 0; i < instance_number(pickup_type); i+=1;)
			with (instance_find(pickup_type,i)){
				var temp_dist = point_distance(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
				var temp_dir = point_direction(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
				if temp_dist <= other.pickup_seek_range{
						physics_apply_force(phy_position_x,phy_position_y,lengthdir_x(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir),lengthdir_y(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir))
						if scale < 0.96
							scale += 0.05
					}
			}
		
	var pickup_type = obj_pickup_health
	if obj_health < max_health
		if instance_number(pickup_type) > 0
			for(var i = 0; i < instance_number(pickup_type); i+=1;)
				with (instance_find(pickup_type,i)){
					var temp_dist = point_distance(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
					var temp_dir = point_direction(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
					if temp_dist <= other.pickup_seek_range{
						physics_apply_force(phy_position_x,phy_position_y,lengthdir_x(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir),lengthdir_y(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir))
						if scale < 0.96
							scale += 0.05
					}
				}
		
	var pickup_type = obj_pickup_particles
	if particles < max_particles
		if instance_number(pickup_type) > 0
			for(var i = 0; i < instance_number(pickup_type); i+=1;)
				with (instance_find(pickup_type,i)){
					var temp_dist = point_distance(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
					var temp_dir = point_direction(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
					if temp_dist <= other.pickup_seek_range{
						physics_apply_force(phy_position_x,phy_position_y,lengthdir_x(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir),lengthdir_y(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir))
						if scale < 0.96
							scale += 0.05
					}
				}
				
	var pickup_type = obj_pickup_diamond
		if instance_number(pickup_type) > 0
			for(var i = 0; i < instance_number(pickup_type); i+=1;)
				with (instance_find(pickup_type,i)){
					var temp_dist = point_distance(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
					var temp_dir = point_direction(phy_position_x,phy_position_y,other.phy_position_x,other.phy_position_y)
					if temp_dist <= other.pickup_seek_range{
						physics_apply_force(phy_position_x,phy_position_y,lengthdir_x(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir),lengthdir_y(other.pickup_pull_force*temp_dist/other.pickup_seek_range,temp_dir))
						if scale < 0.96
							scale += 0.05
					}
				}
	}
	
// Update total credits earned. For achievemnts maybe?
			
if credits > credits_old
credits_gained += (credits - credits_old)
global.total_credits += (credits - credits_old)
credits_old = credits

// GUI stuff

if scr_timer(20)
	scr_populate_map_object_array()
	
health_bar_x = global.gui_unit * 0.2
health_bar_y = 4.5 * global.gui_unit //540
health_bar_height = 1.5 * global.gui_unit
health_bar_width = global.gui_unit * 0.16

energy_bar_x = global.gui_unit * 0.4
energy_bar_y = 4.5 * global.gui_unit //540
energy_bar_height = 1.5 * global.gui_unit
energy_bar_width = global.gui_unit * 0.16

particles_bar_x = global.gui_unit * 0.6
particles_bar_y = 4.5 * global.gui_unit //540
particles_bar_height = 1.5 * global.gui_unit
particles_bar_width = global.gui_unit * 0.16



// Update modules so they can "find" each other. And make them free?

if scr_timer(60)
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		if scr_exists(ship_segment[i]){
				ship_segment[i].owner = id
				ship_segment[i].persistent = true
				if scr_exists(ship_segment[i].module){
					ship_segment[i].module.owner = id
					ship_segment[i].module.module_segment = ship_segment[i]
					/*
					if ship_segment[i].ship_segment_above != noone
						ship_segment[i].module.module_above = ship_segment[i].ship_segment_above.module
					if ship_segment[i].ship_segment_right != noone
						ship_segment[i].module.module_right = ship_segment[i].ship_segment_right.module
					if ship_segment[i].ship_segment_below != noone
						ship_segment[i].module.module_below = ship_segment[i].ship_segment_below.module
					if ship_segment[i].ship_segment_left != noone
						ship_segment[i].module.module_left = ship_segment[i].ship_segment_left.module
						*/
					ship_segment[i].module.persistent = true
					//ship_segment[i].module.cost = 0
					}
				}
		



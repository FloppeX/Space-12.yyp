// Timer

timer = 0

//

obj_health = 100
destroyed = false

// Gamepad controls


// Gamepad controls
/*
gamepad_button[0] = false
gamepad_button[1] = false
gamepad_button[2] = false
gamepad_button[3] = false
gamepad_button[4] = false
gamepad_button[5] = false
*/
use_active_item = false
select_next_active_item = false

add_thrust = 0;
rotation_value = 0;

selected_active_module = noone

controls_disabled = false
disabled_timer = 0



// Changeable ship variables

max_speed_base = 2.8
max_speed_multiplier = 1 
max_speed_bonus = 0

rotation_speed_base = 60
rotation_speed_multiplier = 1 
rotation_speed_bonus = 0

drift_resistance_base = 14
drift_resistance_multiplier = 1
drift_resistance_bonus = 0

max_health_base = 10
max_health_multiplier = 1
max_health_bonus = 0

max_energy_base = 100
max_energy_multiplier = 1
max_energy_bonus = 0

max_particles_base = 100
max_particles_multiplier = 1
max_particles_bonus = 0

energy_increase_base = 0.5;
energy_increase_multiplier = 1
energy_increase_bonus = 0

luck_base = 1
luck_multiplier = 1
luck_bonus = 0


//

// Calculate variables that may be changed by modifiers

max_speed = (max_speed_base * max_speed_multiplier) + max_speed_bonus
rotation_speed = (rotation_speed_base * rotation_speed_multiplier) + rotation_speed_bonus
drift_resistance = (drift_resistance_base * drift_resistance_multiplier) + drift_resistance_bonus
max_health = (max_health_base * max_health_multiplier) + max_health_bonus
max_energy = (max_energy_base * max_energy_multiplier) + max_energy_bonus
max_particles = (max_particles_base * max_particles_multiplier) + max_particles_bonus
energy_increase = (energy_increase_base * energy_increase_multiplier) + energy_increase_bonus

// Health

obj_health = max_health;
obj_health_old = obj_health

// Hit invulnerability - to avoid getting hit lots of times in a row

hit_invulnerable_timer = 0

// Energy

energy = max_energy;
energy_disabled = false
energy_disabled_timer = 60
energy_disabled_duration = 60

// Particles

particles = 0


// Diamonds

diamonds = 0

// Rotating & moving

rotation_force = 100
rotation_value = 0;
add_thrust = 0;

// Target

target_objects[0] = obj_enemy_ship
target_objects[1] = obj_enemy_ship

// Active module

selected_active_module = noone
use_active_item = false
select_next_active_item = false

// Graphics

invisible = false
alpha = 1
draw_scale = 1

// Map

show_map = true;

map_scale = 4.5
map_width = global.gui_scale * 100 * map_scale;
map_height = global.gui_scale * 100 * map_scale;
map_edge_right = 15.5 * global.gui_unit //display_get_gui_width() - 25 * map_scale
map_edge_left = map_edge_right - map_width
map_edge_top = 0.5 * global.gui_unit //* map_scale
map_center_x = map_edge_left+ 0.5*map_width
map_center_y = map_edge_top+0.5*map_height
map_range = 0.8 * global.play_area_width;//global.play_area_width //

map_objects[99,0] = noone
number_of_map_objects = 0

// Credits

credits = 0;

// Variables for keeping track of stats

enemies_killed = 0
bullets_fired = 0
credits_gained = 0
credits_old = 0

// Pickups

pickup_seek_range = 100
pickup_pull_force = 160

// Crew

crew[0] = noone

// Modifiers

modifiers[0,0] = noone

// Segments

segment_distance = 24

var module_placement_ok = false

repeat(20)
	if(!module_placement_ok){
		scr_create_ship_segments(4,segment_distance,obj_ship_segment_player)

		scr_place_engine_player()

		var segment_placed = false	
		var i = irandom(3)
		switch (i){
			case 0: temp_module = instance_create_depth(0,0,-10,obj_module_cockpit_1); break;
			case 1: temp_module = instance_create_depth(0,0,-10,obj_module_cockpit_2); break;
			case 2: temp_module = instance_create_depth(0,0,-10,obj_module_cockpit_3); break;
			case 3: temp_module = instance_create_depth(0,0,-10,obj_module_cockpit_4); break;
			case 4: temp_module = instance_create_depth(0,0,-10,obj_module_cockpit_5); break;
			}
		temp_module.owner = id;
	
		repeat(100){
			var i = irandom(array_length_1d(ship_segment)-1)
			if scr_check_module_placement(temp_module,ship_segment[i]) and ship_segment[i].module == noone and !segment_placed{
				ship_segment[i].module = temp_module
				segment_placed = true
				}
			}
	
		scr_place_weapon_player()
	
		//Check if this configuration is legal
		module_placement_ok = true
		for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
			if !scr_check_module_placement(ship_segment[i].module,ship_segment[i])
				module_placement_ok = false}

	}


scr_ship_update_segments(id,segment_distance)

for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
	if scr_exists(ship_segment[i]){
			ship_segment[i].owner = id
			ship_segment[i].persistent = true
			ship_segment[i].visible = true
			ship_segment[i].placement_angle = point_direction(phy_position_x,phy_position_y,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
			ship_segment[i].placement_distance = point_distance(phy_position_x,phy_position_y,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
			if scr_exists(ship_segment[i].module){
				ship_segment[i].module.owner = id
				ship_segment[i].module.persistent = true
				ship_segment[i].module.visible = true
				ship_segment[i].module.phy_position_x = ship_segment[i].phy_position_x
				ship_segment[i].module.phy_position_y = ship_segment[i].phy_position_y
				ship_segment[i].module.phy_rotation = phy_rotation-ship_segment[i].module.offset_angle
				ship_segment[i].module.joint = physics_joint_revolute_create(ship_segment[i], ship_segment[i].module,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,0, 360, 0, 10,0,1,0);
				}
			}
			
// Update max health and health because this depends on segments

max_health_base =  array_length_1d(ship_segment) * 12
obj_health = max_health_base

//Sounds

sound_priority = 1

explosion_sound = snd_explosion_large_01
engine_sound = snd_engine_2
ship_audio_emitter = audio_emitter_create()
audio_emitter_falloff(ship_audio_emitter, 600, 800, 1);


// Debris particles for if it blows up

debris_parts[0] = spr_debris_player_1
debris_parts[1] = spr_debris_player_2
debris_parts[2] = spr_debris_player_3
debris_parts[3] = spr_module_cockpit_1
// Timer

timer = 0

//

baseplate_sprite = noone
draw_scale = 1
alpha = 1

//

credit_cost = 6
diamond_cost = 0

//

mirror_x = 0
mirror_y = 0

//

// Placement

placement_req_above = 1 // any placement allowed
placement_req_right = 1
placement_req_below = 1
placement_req_left = 1

//

joint = noone
angle_diff = 0
//

active = false // Is this an active or passive item? Guns are neither.

activation_button = 2
activated = false
activation_timer = 0

owner = noone;
ship_segment = noone;
module_above = noone // These are pointers to the module that may be found next to this module
module_below = noone
module_left = noone
module_right = noone
owned_by_shop = false // used when selecting modules in the shop

fixed_rotation = false
target_angle = 0;
offset_angle = 0;
placement_offset_angle = 0
placement_offset_distance = 0
shoot = false
activate_shield = false

energy_cost = 0

for(var h = 0; h <= 0; h+=1;)
	for(var i = 0; i <= 2; i+=1;)
		modifiers[h,i] = noone
		
bullets[0] = noone

module_name = "Module name here"
description_lines[0] = "Module description here"

// Modifier variables

bullet_damage_modifier = 0
bullet_speed_modifier = 0

bullet_type_base = obj_bullet_player;
bullet_damage_base = 0;
bullet_range_base = 0
bullet_speed_base = 0;
bullet_speed_randomness_base = 0;
bullet_interval_base = 0;
bullet_push_force_base = 0
recoil_force_base = 0
bullet_spread_base = 0
bullet_number_base = 0
energy_cost_base = 0
particle_cost_base = 0

// Reset multipliers and bonuses
bullet_type = bullet_type_base

bullet_damage_multiplier = 1
bullet_range_multiplier = 1
bullet_speed_multiplier = 1
bullet_speed_randomness_multiplier = 1
bullet_interval_multiplier = 1
bullet_push_force_multiplier = 1
recoil_force_multiplier = 1
bullet_spread_multiplier = 1
bullet_number_multiplier = 1
energy_cost_multiplier = 1
particle_cost_multiplier = 1

bullet_damage_bonus = 0
bullet_range_bonus = 0
bullet_speed_bonus = 0
bullet_speed_randomness_bonus = 0
bullet_push_force_bonus = 0
recoil_force_bonus = 0
bullet_spread_bonus = 0
bullet_number_bonus = 0
bullet_interval_bonus = 0
energy_cost_bonus = 0
particle_cost_bonus = 0

// Calculate values
bullet_range = 100;

bullet_damage = round((bullet_damage_base * bullet_damage_multiplier) + bullet_damage_bonus)
bullet_range = round((bullet_range_base * bullet_range_multiplier) + bullet_range_bonus)
bullet_speed = (bullet_speed_base * bullet_speed_multiplier) + bullet_speed_bonus
bullet_speed_randomness = (bullet_speed_randomness_base * bullet_speed_randomness_multiplier) + bullet_speed_randomness_bonus
bullet_interval = round((bullet_interval_base * bullet_interval_multiplier) + bullet_interval_bonus)
bullet_push_force = (bullet_push_force_base + bullet_push_force_bonus) * bullet_push_force_multiplier
recoil_force = (recoil_force_base + recoil_force_bonus) * recoil_force_multiplier
bullet_spread = round((bullet_spread_base * bullet_spread_multiplier) + bullet_spread_bonus)
bullet_number = round((bullet_number_base * bullet_number_multiplier) + bullet_number_bonus)
energy_cost = round((energy_cost_base * energy_cost_multiplier) + energy_cost_bonus)
particle_cost = round((particle_cost_base * particle_cost_multiplier) + particle_cost_bonus)

//Sounds

sound = noone
module_audio_emitter = audio_emitter_create()
audio_emitter_falloff(module_audio_emitter, 100, 1200, 1);


// junk variables..

controls_disabled = true
obj_health = 0
draw_scale = 1
energy = 0
phy_rotation = -90
add_thrust = 0
persistent = false
gamepad_button[0] = false
gamepad_button[1] = false
gamepad_button[2] = false
gamepad_button[3] = false
gamepad_button[4] = false
gamepad_button[5] = false

target_object = obj_enemy_ship

alpha = 1

lateral_drift_direction = 0
drift_resistance_force = 0
rotation_value = 0

target_objects[0] = noone
target_objects[1] = noone

// Variables that really belong to ships but that this object needs
max_speed_multiplier = 0 
max_speed_bonus = 0

rotation_speed_multiplier = 1 
rotation_speed_bonus = 0

drift_resistance_multiplier = 1
drift_resistance_bonus = 0

max_particles_multiplier = 1
max_particles_bonus = 0


max_health_multiplier = 1
max_health_bonus = 0

max_energy_multiplier = 1
max_energy_bonus = 0

energy_increase_multiplier = 1
energy_increase_bonus = 0

////

shop_segments[0] = noone

//

enter_shop = true
exit_shop = false
/*
x_step_offset = 80
y_step_offset = 80
var i = 0
for(var p = 0; p < number_of_rows; p+=1;)
for(var q = 0; q < number_of_items_per_row; q+=1;){
	shop_segments[i] = instance_create_depth(x,y,10,obj_shop_segment);
	shop_segments[i].owner = id
	shop_segments[i].visible = false
	shop_segments[i].persistent = false
	shop_segments[i].phy_position_x = phy_position_x + 180 + q * x_step_offset
	shop_segments[i].phy_position_y = phy_position_y - (0.5 * y_step_offset * (number_of_rows-1)) + p * y_step_offset

	shop_segments[i].door = instance_create_depth(shop_segments[i].phy_position_x,shop_segments[i].phy_position_y,-20,obj_module_holder_door);

	if number_of_guns > 0{
		temp_module = scr_create_random_gun();
		number_of_guns -= 1
	}
	else {
		if number_of_utility > 0{
		temp_module = scr_create_random_device();
		 number_of_utility -= 1
		}

		else {
			temp_module = scr_create_random_crew();
			number_of_crew -= 1
			}
		}
	if scr_exists(temp_module){
		temp_module.owner = id
		temp_module.module_segment = shop_segments[i]
		temp_module.owned_by_shop = true

		shop_segments[i].module = temp_module
		temp_module.phy_position_x = shop_segments[i].phy_position_x
		temp_module.phy_position_y = shop_segments[i].phy_position_y
		
		temp_module.phy_rotation = ( phy_rotation - temp_module.offset_angle)
		//temp_module.joint = physics_joint_revolute_create(id, temp_module,temp_module.phy_com_x,temp_module.phy_com_y,0, 360, 0, 10,3,1,0);
		
		scr_adjust_module_placement_shop(temp_module,shop_segments[i])
		
		}
	i += 1
	}
	*/
	
// Get module identities - used to check if more items can be taken...
/*
module_identities[number_of_items] = noone
for(var i = 0; i < number_of_items; i+=1;)
	module_identities[i] = shop_segments[i].module.id
	*/
// Audio

audio_emitter = audio_emitter_create()
audio_emitter_falloff(audio_emitter, 200,700, 1);
audio_emitter_position(audio_emitter,phy_position_x,phy_position_y,0)
shop_noise = audio_play_sound_on(audio_emitter,snd_shop_background_hum,1,0.8)

// Create buttons

segment_button = instance_create_depth(x-60,y+80,-10,obj_shop_button_segment);
repair_button = instance_create_depth(x-20,y+80,-10,obj_shop_button_repair);
reload_button = instance_create_depth(x+20,y+80,-10,obj_shop_button_reload);
exit_button = instance_create_depth(x+60,y+80,-10,obj_shop_button_exit);

// 

player_target_position_x = 0.5 * room_width
player_target_position_y = 0.5 * room_height

// Randomize the structural parts and color for the shop

hue = irandom(255)


shop_structure_part = instance_create_depth(phy_position_x,phy_position_y,20,obj_shop_structure);
shop_structure_part.shadow = false
shop_structure_part.sprite_index = spr_shop_structure_bars
shop_structure_part.depth = 100
shop_structure_part.color = c_white

store_type_1 = noone
store_type_1 = noone

// 

store_list[0] = obj_shop_structure_gun_shop
store_list[1] = obj_shop_structure_device_shop
store_list[2] = obj_shop_structure_shield_shop
store_list[3] = obj_shop_structure_crew_shop
store_list[4] = obj_shop_structure_engine_shop
store_list[5] = obj_shop_structure_gun_shop_2

scr_shuffle_array(store_list)

//

shop_structure_test = instance_create_depth(phy_position_x-220,phy_position_y-130,20,array_shift(store_list));
shop_structure_test.scale = 1

shop_structure_test = instance_create_depth(phy_position_x+220,phy_position_y-130,20,array_shift(store_list));
shop_structure_test.scale = 1

shop_structure_test = instance_create_depth(phy_position_x-220,phy_position_y+130,20,array_shift(store_list));
shop_structure_test.scale = 1

shop_structure_test = instance_create_depth(phy_position_x+220,phy_position_y+130,20,obj_shop_structure_pawn_shop);
shop_structure_test.scale = 1


shop_structure_part = instance_create_depth(phy_position_x-300,phy_position_y-250,-10,obj_shop_structure);
shop_structure_part = instance_create_depth(phy_position_x-200,phy_position_y-250,-10,obj_shop_structure);

shop_structure_part = instance_create_depth(phy_position_x-300,phy_position_y,-10,obj_shop_structure);
shop_structure_part = instance_create_depth(phy_position_x-200,phy_position_y,-10,obj_shop_structure);

shop_structure_part = instance_create_depth(phy_position_x-300,phy_position_y+150,-10,obj_shop_structure);
shop_structure_part = instance_create_depth(phy_position_x-200,phy_position_y+250,-10,obj_shop_structure);

shop_structure_part = instance_create_depth(phy_position_x+300,phy_position_y-250,-10,obj_shop_structure);
shop_structure_part = instance_create_depth(phy_position_x+200,phy_position_y-250,-10,obj_shop_structure);

shop_structure_part = instance_create_depth(phy_position_x+300,phy_position_y,-10,obj_shop_structure);
shop_structure_part = instance_create_depth(phy_position_x+200,phy_position_y,-10,obj_shop_structure);

shop_structure_part = instance_create_depth(phy_position_x+300,phy_position_y+150,-10,obj_shop_structure);
shop_structure_part = instance_create_depth(phy_position_x+200,phy_position_y+150,-10,obj_shop_structure);


//


number_of_guns = 4
number_of_utility = 6
number_of_crew = 8
number_of_items = number_of_guns + number_of_utility + number_of_crew
number_of_items_left = 3
number_of_items_to_select = 99
temp_module = noone


// Assign items to all slots on the shops

for(var i = 0; i < instance_number(obj_shop_segment); i+=1;){
	var temp_segment = instance_find(obj_shop_segment,i)
	shop_segments[i] = temp_segment
	shop_segments[i].owner = id
	shop_segments[i].visible = false
	shop_segments[i].persistent = false
	shop_segments[i].module = noone
	}
event_inherited();

// Ship stats

max_rotation_speed = 60;
max_speed_base = 2.8
rotation_force = 200

// Enemies to target 

target_objects[0] = obj_player
target_objects[1] = obj_enemy_modular_team_1

///
// Segments

var number_of_segments = global.temp_number_of_segments
var segment_distance = 24

scr_create_ship_segments(number_of_segments,24,obj_ship_segment_enemy_team_2)

//scr_ship_update_segments(id,segment_distance)

repeat(round(number_of_segments/3))
	scr_place_engine_enemy (obj_module_engine_enemy_team_2)
	
var module_placed = false
	var temp_module = instance_create_depth(0,0,-10,obj_module_enemy_cockpit_1_team_2);
	repeat(100)
		if module_placed == false{
		var i = irandom(array_length_1d(ship_segment)-1)
		if scr_check_module_placement(temp_module,ship_segment[i]) and ship_segment[i].module == noone and !module_placed{
			ship_segment[i].module = temp_module
			module_placed = true
			}
		}
	if module_placed == false
		with(temp_module)
			instance_destroy();

repeat(10){
	var module_placed = false	
	repeat(10){
		if module_placed == false{
			var temp_module = scr_create_random_enemy_2_weapon();
			repeat(10){
				var i = irandom(array_length_1d(ship_segment)-1)
				if scr_check_module_placement(temp_module,ship_segment[i]) and ship_segment[i].module == noone and !module_placed{
					ship_segment[i].module = temp_module
					module_placed = true
					}
				}
			if module_placed == false
				with(temp_module)
					instance_destroy();
		}
	}
		
	var module_placed = false	
	repeat(10){
		if module_placed == false{
			var temp_module = scr_create_random_enemy_2_weapon();
			repeat(10){
				var i = irandom(array_length_1d(ship_segment)-1)
				if scr_check_module_placement(temp_module,ship_segment[i]) and ship_segment[i].module == noone and !module_placed{
					ship_segment[i].module = temp_module
					module_placed = true
					}
				}
			if module_placed == false
				with(temp_module)
					instance_destroy();
		}
	}
}
	
	/*
var segment_placed = false
temp_module = instance_create_depth(0,0,-10,obj_module_engine_enemy);
repeat(100){
	var i = irandom(array_length_1d(ship_segment)-1)
	if scr_check_module_placement(temp_module,ship_segment[i]) and ship_segment[i].module == noone and !segment_placed{
		ship_segment[i].module = temp_module
		segment_placed = true
		}
	}
	*/
	

for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
			ship_segment[i].owner = id
			ship_segment[i].persistent = false
			ship_segment[i].visible = true
			ship_segment[i].placement_angle = point_direction(phy_position_x,phy_position_y,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
			ship_segment[i].placement_distance = point_distance(phy_position_x,phy_position_y,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y)
			if ship_segment[i].module != noone{
				ship_segment[i].module.owner = id
				ship_segment[i].module.persistent = false
				ship_segment[i].module.visible = true
				ship_segment[i].module.phy_position_x = ship_segment[i].phy_position_x
				ship_segment[i].module.phy_position_y = ship_segment[i].phy_position_y
				ship_segment[i].module.joint = physics_joint_revolute_create(ship_segment[i], ship_segment[i].module,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,0, 360, 0, 10,0,1,0);
				}
			}


gun_bullet_speed = 8

// Health

max_health_base = 8 * number_of_segments
max_health = (max_health_base * max_health_multiplier) + max_health_bonus
obj_health = max_health

//Sounds

explosion_sound = snd_explosion_large_02
engine_sound = snd_engine_2
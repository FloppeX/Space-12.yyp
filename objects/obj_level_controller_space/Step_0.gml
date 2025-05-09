// TEST 
if keyboard_check_pressed(vk_delete)
	stage_timer = 0


// Zoom
/*
if gamepad_button_check_pressed(0,gp_padu)
		global.zoom = global.zoom - 100

if gamepad_button_check_pressed(0,gp_padd)
		global.zoom = global.zoom + 100
	
global.zoom = clamp(global.zoom,global.min_zoom,global.max_zoom)
*/
//

//if instance_exists(obj_player)
//	global.camera.follow_object = obj_player
	
//

if scr_exists(obj_player){

	stage_timer -= 1
	if stage_timer > 0
		enemy_wave_timer -= 1;
	}

if enemy_wave_timer <= 0{
	number_of_enemies = random_range(2,global.difficulty_level)
	number_of_enemies = clamp(number_of_enemies,2,6)
	enemy_wave_timer = stage_timer_start/(number_of_waves+1)
	}


	
if instance_number(obj_explosive_barrel) < number_of_explosive_barrels{
	var i = irandom(1)
	if i == 0{
		temp_xpos = global.wrap_border_left + random(global.play_area_width)
		temp_ypos = global.wrap_border_top
		}
	else{
		temp_xpos = global.wrap_border_left
		temp_ypos = global.wrap_border_top + random(global.play_area_height)
		}
	new_barrel =  instance_create_depth(temp_xpos,temp_ypos,0,obj_explosive_barrel);
	//number_of_explosive_barrels -= 1
	}

//

ship_interval_timer -= 1
if number_of_enemies >= 1 and ship_interval_timer <= 0 and scr_exists(obj_player){
	var random_placement_ok = false
	while !random_placement_ok{
		var tempdist = 200 + random(300)
		var tempdir = random(359)
		var temp_x = obj_player.phy_position_x + lengthdir_x(tempdist,tempdir)
		var temp_y = obj_player.phy_position_y + lengthdir_y(tempdist,tempdir)
		if !collision_circle(temp_x,temp_y,200,obj_wormhole,false,true) // Check so that no other wormholes are nearby
			random_placement_ok = true
		}

	
	global.temp_number_of_segments = irandom(global.difficulty_level+1);
	global.temp_number_of_segments = clamp(global.temp_number_of_segments,3,8)
	
	new_enemy = instance_create_depth(temp_x,temp_y,0,obj_enemy_modular_team_1);
	show_debug_message("Attempting to spawn: " + object_get_name(new_enemy.object_index) + " at (" + string(temp_x) + "," + string(temp_y) + ")");
	new_enemy.max_health_base = global.temp_number_of_segments * 10 + 10//new_enemy.max_health_base * (1 + 0.2 * global.difficulty_level)
	new_enemy.obj_health = new_enemy.max_health_base
	new_enemy.pickup_objects = 1 + irandom(irandom(global.difficulty_level))
	new_enemy.disabled_timer = 0
	with(new_enemy){
	phy_active = false
		visible = false
		for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
			ship_segment[i].phy_active = false
			ship_segment[i].visible = false
			if scr_exists(ship_segment[i].module){
				ship_segment[i].module.phy_active = false
				ship_segment[i].module.visible = false
				ship_segment[i].module.phy_rotation = -phy_rotation + ship_segment[i].module.offset_angle
				}
		}
	}
	
	new_enemy_wormhole = instance_create_depth(temp_x,temp_y,100,obj_wormhole_level_begin_enemy);
	new_enemy_wormhole.warping_ship = new_enemy
	
	number_of_enemies -= 1
	ship_interval_timer = ship_interval_timer_start
	}


// Cheats!

if keyboard_check_pressed(vk_enter)
	number_of_enemies += 1


// Are all enemies dead? Or is the timer 0? Then count down and move to next level

if stage_timer <= 0 and end_wormhole_created == false{
	global.difficulty_level += 1;
	global.active_level += 1
	wormhole = instance_create_depth(0.5 * room_width,0.5 * room_height-400,100,obj_wormhole_level_end_new)
	wormhole.next_level = global.levels[global.active_level]
	end_wormhole_created = true
	}
	
	
if instance_exists(obj_wormhole_level_end_new){
	wormhole_end_timer -= 1
	if wormhole_end_timer <= 0{
		with(obj_wormhole_level_end_new)
			done_warping = true
		wormhole_end_gone = true
		}
	}


// Is the player dead? Then count down and restart

//if !instance_exists(obj_player){
if obj_player.destroyed{
	death_timer -= 1
	global.difficulty_level = 1
	}
	
if death_timer <= 0 and !instance_exists(obj_death_menu){
	death_menu = instance_create_depth(0.5*display_get_gui_width(),0.4*display_get_gui_height(),0,obj_death_menu)
	death_menu.alignment = "center"
	death_menu.x_pos = 0.5*display_get_gui_width()
	death_menu.y_pos = 0.5*display_get_gui_height()
	}
	
// If the timer is 0, spawn lots of enemies

if stage_timer == 0 and number_of_enemies < 10
	number_of_enemies = 10

// Sound
if global.music_on
	if !audio_is_playing(level_music)
		audio_play_sound_on(global.music_emitter,level_music,1,10)
			
	
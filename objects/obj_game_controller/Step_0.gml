// TEST graphics...

// Update game timer

global.game_timer += 1

// Game controls
	
if keyboard_check(vk_escape)
	game_end();
	
if gamepad_button_check_pressed(0,gp_start){
	display_reset(global.aa_level, 0);
	game_restart();
	}

if gamepad_button_check_pressed(0,gp_select){
	if global.view_mode == 2
		global.view_mode = 1
	else global.view_mode = 2
	}
	
	
if instance_exists(obj_player){
	
	if keyboard_check_pressed(vk_end)
		with(obj_player)
			obj_health = 0
			
	if global.view_mode == 2
		global.max_zoom = 6000
	else global.max_zoom = 4400
	
	if gamepad_button_check_pressed(0,ord("z"))
		global.zoom = global.zoom -100

	if gamepad_button_check_pressed(0,ord("x"))
		global.zoom = global.zoom + 100
	
	global.zoom = clamp(global.zoom,global.min_zoom,global.max_zoom)
	}


	
// Check for enemies killed

//number_of_enemies = instance_number(obj_enemy_ship)
number_of_enemies = instance_number(obj_enemy_ship)
global.enemies_killed_this_step = max(0,number_of_enemies_old - number_of_enemies)
number_of_enemies_old = number_of_enemies
	

// Sound

audio_emitter_position(global.music_emitter,global.camera.phy_position_x,global.camera.phy_position_y,0.25 * global.zoom)

// Update stats

if scr_timer(60) 
	scr_write_stats_to_file()



timer = 0

// Physics settings

game_set_speed(60,gamespeed_fps)
physics_world_update_speed(60);
physics_world_update_iterations(20);

// Play area settings

scr_initialize_room()

// Create background sprites

scr_create_background_layers()

// Difficulty

global.difficulty_level = 1

// Create a menu

start_menu = instance_create_depth(0,0,0,obj_start_menu)
start_menu.x_pos = 2 * global.gui_unit
start_menu.y_pos = 0.4*display_get_gui_height()

// View settings

//view_object = instance_create_depth(0.5 * room_width,0.5 * room_height,-5,obj_view_object)

global.zoom = 900
zoom_timer = 0

// Clear particles

part_particles_clear(global.part_system_above)
part_particles_clear(global.part_system_below)

// Create some asteroids

number_of_asteroids = 32
number_of_enemies_team_1 = 0//6
number_of_enemies_team_2 = 0//6

for(var h = 0; h < number_of_asteroids; h+= 1){
	var i = irandom(1)
	if i == 0{
		temp_xpos = global.wrap_border_left + random(global.play_area_width)
		temp_ypos = global.wrap_border_top
		}
	else{
		temp_xpos = global.wrap_border_left
		temp_ypos = global.wrap_border_top + random(global.play_area_height)
		}
	new_asteroid =  instance_create_depth(temp_xpos,temp_ypos,0,obj_asteroid_big);
	number_of_asteroids -= 1
	}

// Sound

audio_stop_all()
level_music = snd_music_start_intro
if global.music_on 
	audio_play_sound_on(global.music_emitter,level_music,0,1)

// Create background sprites

scr_create_background_layers()



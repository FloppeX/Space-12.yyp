timer += 1

// Zoom

if gamepad_button_check_pressed(0,gp_padl)
		global.zoom = global.zoom - 100

if gamepad_button_check_pressed(0,gp_padr)
		global.zoom = global.zoom + 100
	
global.zoom = clamp(global.zoom,global.min_zoom,global.max_zoom)

global.camera.phy_speed_y = 2 * sin(degtorad(((0.1*timer) mod 360)))
global.camera.phy_speed_x = 2 * cos(degtorad(((0.1*timer) mod 360)))

// Enemies

if scr_timer(30)
	if(instance_number(obj_enemy_modular_team_1) < (number_of_enemies_team_1))
		new_enemy = scr_create_random_enemy(obj_enemy_modular_team_1);
		
if scr_timer(30)
	if(instance_number(obj_enemy_modular_team_2) < (number_of_enemies_team_2))	
		new_enemy_2 = scr_create_random_enemy(obj_enemy_modular_team_2);


/*else 
	if audio_is_playing(level_music)
		audio_stop_sound(level_music)
	*/
	
	
	
// Start graphics

// Create fake wormholes for title!

if timer == 80{
fake_wormhole = instance_create_depth(0,0,-100,obj_wormhole_fake)
fake_wormhole.draw_position_x = 0.5 * display_get_gui_width()
fake_wormhole.draw_position_y = 0.5 * display_get_gui_height()
}

if timer == 180{
	intro_obj_x = instance_create_depth(0,0,-100,obj_intro_effect)
	intro_obj_x.draw_position_x = 0.5 * display_get_gui_width()
	intro_obj_x.draw_position_y = 0.5 * display_get_gui_height()
	intro_obj_x.final_position_x = 0.35 * display_get_gui_width()
	intro_obj_x.final_position_y = 0.2 * display_get_gui_height()
	audio_play_sound_on(global.music_emitter,snd_wormhole_exit,0,1)
	}
	
if timer == 240{
	intro_obj_y = instance_create_depth(0,0,-100,obj_intro_effect)
	intro_obj_y.sprite_index = spr_y
	intro_obj_y.draw_position_x = 0.5 * display_get_gui_width()
	intro_obj_y.draw_position_y = 0.5 * display_get_gui_height()
	intro_obj_y.final_position_x = 0.45 * display_get_gui_width()
	intro_obj_y.final_position_y = 0.2 * display_get_gui_height()
	audio_play_sound_on(global.music_emitter,snd_wormhole_exit,0,1)
	}

if timer == 300{
	intro_obj_b = instance_create_depth(0,0,-100,obj_intro_effect)
	intro_obj_b.sprite_index = spr_b
	intro_obj_b.draw_position_x = 0.5 * display_get_gui_width()
	intro_obj_b.draw_position_y = 0.5 * display_get_gui_height()
	intro_obj_b.final_position_x = 0.55 * display_get_gui_width()
	intro_obj_b.final_position_y = 0.2 * display_get_gui_height()
	audio_play_sound_on(global.music_emitter,snd_wormhole_exit,0,1)
	}
	
if timer == 360{
	intro_obj_a = instance_create_depth(0,0,-100,obj_intro_effect)
	intro_obj_a.sprite_index = spr_a
	intro_obj_a.draw_position_x = 0.5 * display_get_gui_width()
	intro_obj_a.draw_position_y = 0.5 * display_get_gui_height()
	intro_obj_a.final_position_x = 0.65 * display_get_gui_width()
	intro_obj_a.final_position_y = 0.2 * display_get_gui_height()
	audio_play_sound_on(global.music_emitter,snd_wormhole_exit,0,1)
	}
	
if timer == 480{
	intro_obj_a = instance_create_depth(0,0,-100,obj_intro_text)
	intro_obj_a.sprite_index = spr_super
	intro_obj_a.draw_position_x = 0.5 * display_get_gui_width()
	intro_obj_a.draw_position_y = 0.1 * display_get_gui_height()
	audio_play_sound_on(global.music_emitter,snd_super_xyba,0,1)
	}
	
// Sound
if global.music_on
//	if timer >320
	if !audio_is_playing(level_music){
		if level_music == snd_music_start_intro{
			level_music = snd_music_start_intro_loop
			audio_play_sound_on(global.music_emitter,level_music,1,1)
			}
		else
			audio_play_sound_on(global.music_emitter,level_music,1,1)
	}
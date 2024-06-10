/*	
// Center camera
cam = camera_get_active()

camera_set_view_pos(cam,view_object_spectate.phy_position_x -0.5*camera_get_view_width(cam),view_object_spectate.phy_position_y-0.5*camera_get_view_height(cam))	
*/

// Zoom

// Create more enemies?

if gamepad_button_check_pressed(0,gp_shoulderl){
	temp_xpos = global.wrap_border_left + 0.26 * global.play_area_width +random(200)-100
	temp_ypos = global.wrap_border_top + 0.26 *global.play_area_height +random(200)-100

	new_enemy = instance_create_depth(temp_xpos,temp_ypos,0,obj_enemy_modular_team_1); 
}

if gamepad_button_check_pressed(0,gp_shoulderr){
	temp_xpos = global.wrap_border_right - 0.26 * global.play_area_width +random(200)-100
	temp_ypos = global.wrap_border_bottom - 0.26 *global.play_area_height +random(200)-100
	new_enemy = instance_create_depth(temp_xpos,temp_ypos,0,obj_enemy_modular_team_2);

}



// Go back to start menu

if gamepad_button_check_pressed(0,gp_start){
	with(all)
		instance_destroy()
	new_start_room = room_duplicate(rm_start)
	room_goto(new_start_room)
	}
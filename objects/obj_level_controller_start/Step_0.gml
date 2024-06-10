// Zoom

if gamepad_button_check_pressed(0,gp_padl)
		global.zoom = global.zoom - 400

if gamepad_button_check_pressed(0,gp_padr)
		global.zoom = global.zoom + 400
	
global.zoom = clamp(global.zoom,global.min_zoom,global.max_zoom)

// Enemies

if scr_timer(30)
	if(instance_number(obj_enemy_modular_team_1) < (number_of_enemies_team_1))
		new_enemy = scr_create_random_enemy(obj_enemy_modular_team_1);
		
if scr_timer(30)
	if(instance_number(obj_enemy_modular_team_2) < (number_of_enemies_team_2))	
		new_enemy_2 = scr_create_random_enemy(obj_enemy_modular_team_2);

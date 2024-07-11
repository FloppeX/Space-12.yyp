/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if global.button_menu_select 
	switch(selected_item){
		case 0 : 
			with(obj_player)
				instance_destroy()
			global.difficulty_level = 1
			global.active_level = 0
			room_goto(global.levels[global.active_level])
			room_restart()
			break;
		case 1 : 
			with(obj_player)
				instance_destroy();	
			global.difficulty_level = 1
			global.active_level = 0
			new_start_room = room_duplicate(rm_start)
			room_goto(new_start_room)
			break;
		case 2 : game_end();
	}
function scr_initialize_room(){
	
room_width = global.room_width;
room_height = global.room_height;

global.wrap_margin_player = 1000;
global.wrap_margin_objects = 1000;

global.viewport_width = display_get_width(); //view_get_wport(0);
global.viewport_height = display_get_height(); //view_get_hport(0);

global.play_area_width = room_width - 2 * global.wrap_margin_player;
global.play_area_height = room_height - 2 * global.wrap_margin_player;

global.wrap_border_left = global.wrap_margin_player
global.wrap_border_right = room_width - global.wrap_margin_player
global.wrap_border_top = global.wrap_margin_player
global.wrap_border_bottom = room_height - global.wrap_margin_player

}
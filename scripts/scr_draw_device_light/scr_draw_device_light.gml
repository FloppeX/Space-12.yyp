// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_device_light(x_pos,y_pos){
if connected == true{
	if global.game_timer mod 180 <= 120
		draw_sprite(spr_light_green_off,-1,scr_local_sprite_coords_x(x_pos,y_pos),scr_local_sprite_coords_y(x_pos,y_pos))
	else draw_sprite(spr_light_green_on,-1,scr_local_sprite_coords_x(x_pos,y_pos),scr_local_sprite_coords_y(x_pos,y_pos))
}
else
	{
	if global.game_timer mod 60 <= 30
		draw_sprite(spr_light_red_off,-1,scr_local_sprite_coords_x(x_pos,y_pos),scr_local_sprite_coords_y(x_pos,y_pos))
	else draw_sprite(spr_light_red_on,-1,scr_local_sprite_coords_x(x_pos,y_pos),scr_local_sprite_coords_y(x_pos,y_pos))
}
}
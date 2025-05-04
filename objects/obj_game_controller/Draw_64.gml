
if global.view_mode == 2{
	draw_set_font(global.font_small_text)
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_text(860,80,"FPS: " + string(fps))
	draw_text(860,100,"Real FPS: " + string(fps_real))
	draw_text(860,120,"Ships: " + string(instance_number(obj_enemy_modular_team_1)))
	draw_text(860,140,"Total instances: " + string(instance_number(all)))
	draw_text(860,160,"Viewport width: " + string(view_get_wport(view_current)))
	draw_text(860,180,"Viewport height: " + string(view_get_hport(view_current)))
	draw_text(860,200,"zoom: " + string(global.camera.zoom))
	draw_text(860,220,"room width: " + string(room_width))
	draw_text(860,240,"room height: " + string(room_height))
	draw_text(860,260,"total_credits: " + string(global.total_credits))
	draw_text(860,280,"Wormholes: " + string(instance_number(obj_wormhole)))
	draw_text(860,300,"wrap_border_left: " + string(global.wrap_border_left))
	draw_text(860,320,"wrap_border_right: " + string(global.wrap_border_right))
	
	//draw_sprite_part(spr_module_holder_door_left,-1,(global.game_timer mod 60)*24,0,24,48,1000,800)
	
}
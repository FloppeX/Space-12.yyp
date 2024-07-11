
if global.view_mode == 2{
	draw_set_font(global.font_big_text)
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_font(global.font_big_text)
	draw_set_color(c_white)
	draw_set_halign(fa_left)
	draw_text(860,80,"FPS: " + string(fps))
	draw_text(860,120,"Real FPS: " + string(fps_real))
	draw_text(860,160,"Ships: " + string(instance_number(obj_enemy_modular_team_1)))
	draw_text(860,200,"Total instances: " + string(instance_number(all)))
	draw_text(860,280,"Viewport width: " + string(view_get_wport(view_current)))
	draw_text(860,320,"Viewport height: " + string(view_get_hport(view_current)))
	draw_text(860,360,"zoom: " + string(global.camera.zoom))
	draw_text(860,400,"room width: " + string(room_width))
	draw_text(860,440,"room height: " + string(room_height))
	draw_text(860,480,"total_credits: " + string(global.total_credits))
	draw_text(860,520,"Wormholes: " + string(instance_number(obj_wormhole)))
	draw_text(860,560,"Crew array length: " + string(array_length(global.array_player_crew)))
	//for(var i = 0; i < array_length_1d(text) ; i+=1;)
	//	draw_text(860,400+i*40,text[i])
	
}
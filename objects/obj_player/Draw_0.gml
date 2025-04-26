

for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
	//if ship_segment[i].ship_segment_right != noone
		draw_sprite_ext(spr_segment_2,-1,ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,1,1,-phy_rotation,c_white,alpha)

// Draw at this and other positions
if global.view_mode == 2{
	for (var p = -global.play_area_width; p <= global.play_area_width; p += global.play_area_width)
		for (var q = -global.play_area_height; q <= global.play_area_height; q+= global.play_area_height)
			draw_sprite_ext(sprite_index,-1,phy_position_x+p,phy_position_y+q,draw_scale,draw_scale,-phy_rotation,c_white,alpha)
	}
	
// TEST
if global.view_mode == 2{
	draw_set_font(global.font_small_text)
	draw_set_halign(fa_center)
	draw_set_color(c_white)
	number_of_map_objects = 0
	while(map_objects[number_of_map_objects,0] != noone)
		number_of_map_objects += 1
	draw_text(phy_position_x,phy_position_y+80,"phy_rotation: " + string(phy_rotation mod 360))
	draw_text(phy_position_x,phy_position_y+120,"angular velocity: " + string((phy_angular_velocity)))
	}
	/*
draw_self()
draw_sprite(spr_segment_2,-1,scr_local_sprite_coords_x(-15,-15),scr_local_sprite_coords_y(-15,-15))
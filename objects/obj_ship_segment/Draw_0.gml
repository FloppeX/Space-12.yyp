//draw_sprite_ext(sprite_index,-1,phy_position_x,phy_position_y,1,1,-phy_rotation,c_white,alpha)

if ship_segment_right != noone
	for (var p = -global.play_area_width; p <= global.play_area_width; p += global.play_area_width)
		for (var q = -global.play_area_height; q <= global.play_area_height; q+= global.play_area_height)
			draw_sprite_ext(spr_crossbar,-1,phy_position_x+p,phy_position_y+q,draw_scale,draw_scale,-phy_rotation-90,c_white,alpha)
			
if ship_segment_below != noone
	for (var p = -global.play_area_width; p <= global.play_area_width; p += global.play_area_width)
		for (var q = -global.play_area_height; q <= global.play_area_height; q+= global.play_area_height)
			draw_sprite_ext(spr_crossbar,-1,phy_position_x+p,phy_position_y+q,draw_scale,draw_scale,-phy_rotation+180,c_white,alpha)
			

for (var p = -global.play_area_width; p <= global.play_area_width; p += global.play_area_width)
	for (var q = -global.play_area_height; q <= global.play_area_height; q+= global.play_area_height)
		draw_sprite_ext(sprite_index,-1,phy_position_x+p,phy_position_y+q,draw_scale,draw_scale,-phy_rotation,c_white,alpha)

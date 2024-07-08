
if scr_exists(owner){
	if owner.phy_active = false
		phy_active = false
	else
		phy_active = true
	
	if owner.visible = false
		visible = false
	else
		visible = true
	}
		

if visible
	for (var p = -global.play_area_width; p <= global.play_area_width; p += global.play_area_width)
		for (var q = -global.play_area_height; q <= global.play_area_height; q+= global.play_area_height)
			draw_sprite_ext(sprite_index,-1,phy_position_x+p,phy_position_y+q,draw_scale,draw_scale,-phy_rotation,c_white,alpha)
/*
// TEST
if global.view_mode == 2{
	if scr_exists(module_above)
		draw_sprite_ext(spr_arrow,-1, phy_position_x,phy_position_y,1,1,90,c_white,1)
	if scr_exists(module_right)
		draw_sprite_ext(spr_arrow,-1, phy_position_x,phy_position_y,1,1,0,c_white,1)
	if scr_exists(module_below) 
		draw_sprite_ext(spr_arrow,-1, phy_position_x,phy_position_y,1,1,-90,c_white,1)
	if scr_exists(module_left)
		draw_sprite_ext(spr_arrow,-1, phy_position_x,phy_position_y,1,1,180,c_white,1)
}

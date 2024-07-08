
draw_sprite_ext(sprite_index,-1,mirror_x,mirror_y,1,1,-phy_rotation,c_white,1)
draw_sprite_ext(sprite_index,-1,x,mirror_y,1,1,-phy_rotation,c_white,1)
draw_sprite_ext(sprite_index,-1,mirror_x,y,1,1,-phy_rotation,c_white,1)
draw_self();

if diamonds > 0
	scr_diamond_twinkle(16,240,twinkle_dist,twinkle_dir)
	
// TEST
if global.view_mode == 2{
	draw_set_font(global.font_small_text)
	draw_set_color(c_white)
	draw_text(phy_position_x,phy_position_y+50,"pickups: " + string(pickup_objects))
	draw_text(phy_position_x,phy_position_y+70,"pickups c1: " + string(child_1_pickups))
	draw_text(phy_position_x,phy_position_y+90,"pickups c2: " + string(child_2_pickups))
}
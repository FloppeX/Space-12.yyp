/*for(var i = 0; i < array_length(shop_segments); i+=1;){
	draw_sprite(spr_module_holder,-1,shop_segments[i].x,shop_segments[i].y)
	}
*/
for(var i = 0;i < array_length(shop_segments); i+=1;)
	if scr_exists(shop_segments[i].module){
		draw_sprite_ext(shop_segments[i].module.sprite_index,-1,shop_segments[i].module.phy_position_x+4,shop_segments[i].module.phy_position_y+4,1,1,-shop_segments[i].module.phy_rotation,c_black,0.3)
		}

if global.view_mode == 2
{
	draw_set_font(global.font_small_text)
	draw_set_color(c_white)
	draw_text(phy_position_x-200,phy_position_y,"enter_shop: " + string(enter_shop))
	draw_text(phy_position_x-200,phy_position_y + 30,"exit_shop: " + string(exit_shop))
}


	

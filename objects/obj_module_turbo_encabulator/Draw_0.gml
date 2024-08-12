/*if scr_exists(module_above)
	if object_is_ancestor(module_above.object_index,obj_module_engine)
		draw_sprite_ext(spr_power_cable,(global.game_timer mod 32)/4,x,y,1,1,-phy_rotation-90,c_white,1)
	
if scr_exists(module_right)
	if object_is_ancestor(module_right.object_index,obj_module_engine)
		draw_sprite_ext(spr_power_cable,(global.game_timer mod 32)/4,x,y,1,1,-phy_rotation+180,c_white,1)

if scr_exists(module_below)
	if object_is_ancestor(module_below.object_index,obj_module_engine)
		draw_sprite_ext(spr_power_cable,(global.game_timer mod 32)/4,x,y,1,1,-phy_rotation+90,c_white,1)

if scr_exists(module_left)	
	if object_is_ancestor(module_left.object_index,obj_module_engine)
		draw_sprite_ext(spr_power_cable,(global.game_timer mod 32)/4,x,y,1,1,-phy_rotation,c_white,1)
*/

event_inherited();

if connected == true{
	if global.game_timer mod 180 <= 120
		draw_sprite(spr_light_green_off,-1,x,y)
	else draw_sprite(spr_light_green_on,-1,x,y)
}
else
	{
	if global.game_timer mod 60 <= 30
		draw_sprite(spr_light_red_off,-1,x,y)
	else draw_sprite(spr_light_red_on,-1,x,y)
}
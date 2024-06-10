
if will_affect_neighbor == true{
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
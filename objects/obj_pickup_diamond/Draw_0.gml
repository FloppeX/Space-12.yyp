event_inherited();
scr_diamond_twinkle(16,240,6,120)
/*
var temp_duration = 20
var temp_timer = 0
var temp_scale = 0
var temp_rotation = 0
var temp_distance = 6
var temp_direction = 120
if timer mod 360 < temp_duration {
	temp_timer = timer mod temp_duration
	if temp_timer < 30
		temp_scale = temp_timer/(temp_duration/2)
	else 
		temp_scale = (temp_duration-temp_timer)/(temp_duration/2)
	temp_rotation = temp_timer * 9
	draw_sprite_ext(spr_star_twinkle,-1,phy_position_x+lengthdir_x(temp_distance,temp_direction),phy_position_y+lengthdir_y(temp_distance,temp_direction),2,2,-phy_rotation + temp_rotation,c_white,0.6)
}
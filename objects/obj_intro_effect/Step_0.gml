if temp_scale < final_scale
	temp_scale += scale_speed
	
draw_position_x += movement_speed_x
draw_position_y += movement_speed_y

var xdist = final_position_x - draw_position_x
var ydist = final_position_y - draw_position_y

movement_acc_x = xdist/1200
movement_acc_y = ydist/1200

movement_speed_x += movement_acc_x
movement_speed_y += movement_acc_y



movement_speed_x *= 0.96
movement_speed_y *= 0.96

if temp_scale < 0.6*final_scale
	rotation -= 5
if temp_scale >= 0.6 * final_scale
if rotation mod 360 == 0
		rotation = 0
	else rotation -= 5
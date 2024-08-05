if temp_scale < final_scale
	temp_scale += scale_speed
	
draw_position_x += movement_speed_x
draw_position_y += movement_speed_y

var xdist = final_position_x - draw_position_x
var ydist = final_position_y - draw_position_y

movement_acc_x = xdist/400
movement_acc_y = ydist/400

movement_speed_x += movement_acc_x
movement_speed_y += movement_acc_y

/*
if draw_position_x > final_position_x
	movement_speed_x -= 0.2
if draw_position_x < final_position_x
	movement_speed_x += 0.2
if draw_position_y > final_position_y
	movement_speed_y -= 0.2
if draw_position_y < final_position_y 
	movement_speed_y += 0.2
*/
//movement_speed_x = clamp(movement_speed_x,-max_movement_speed,max_movement_speed)
//movement_speed_y = clamp(movement_speed_y,-max_movement_speed,max_movement_speed)

movement_speed_x *= 0.90
movement_speed_y *= 0.90

if temp_scale < final_scale
	rotation -= 10
if temp_scale == final_scale 
	if rotation mod 360 == 0
		rotation = 0
	else rotation -= 10
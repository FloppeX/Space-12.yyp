var door_pos_a = door_closed_offset+door_travel_x
draw_sprite(spr_module_holder_door_a,-1,x-door_pos_a,y)
for(var i = 3; i+door_pos_a < 28; i+= 3)
	draw_sprite(spr_module_holder_door_b,-1,x-(door_pos_a+i),y)
var door_pos_b = door_closed_offset+door_travel_x
draw_sprite(spr_module_holder_door_a,-1,x+door_pos_b,y)
for(var i = 3; i+door_pos_a < 28; i+= 3)
	draw_sprite(spr_module_holder_door_b,-1,x+(door_pos_a+i),y)
draw_self()
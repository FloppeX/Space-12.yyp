function scr_draw_objects_on_map() {
	for(var i=0;map_objects[i,0] != noone;i+=1){
			var map_sprite = map_objects[i,0]
			var map_dist = map_objects[i,1]
			var map_dir = map_objects[i,2]
			var map_rot = map_objects[i,3]
			var map_color = map_objects[i,4]
			draw_sprite_ext(map_sprite,-1,map_center_x+ lengthdir_x(map_dist,map_dir),map_center_y + lengthdir_y(map_dist,map_dir),global.gui_scale * map_scale,global.gui_scale * map_scale,map_rot,map_color,1)
			}


}

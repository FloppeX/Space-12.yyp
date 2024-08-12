
function scr_local_sprite_coords_y(local_x,local_y){
var temp_dir = point_direction(local_x,local_y,0,0)
var temp_dist = point_distance(local_x,local_y,0,0)

var temp_y = phy_position_y+lengthdir_y(temp_dist,-(phy_rotation+temp_dir))
return temp_y
}
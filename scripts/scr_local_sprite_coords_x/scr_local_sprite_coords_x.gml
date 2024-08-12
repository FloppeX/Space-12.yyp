
function scr_local_sprite_coords_x(local_x,local_y){
var temp_dir = point_direction(local_x,local_y,0,0)
var temp_dist = point_distance(local_x,local_y,0,0)

var temp_x = phy_position_x+lengthdir_x(temp_dist,-(phy_rotation+temp_dir))
return temp_x
}
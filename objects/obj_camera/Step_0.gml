if !scr_exists(follow_object){
	if instance_exists(obj_player)
		follow_object = obj_player
	else
		if instance_number(obj_enemy_ship)
			follow_object = instance_find(obj_enemy_ship,instance_number(obj_enemy_ship)-1)
}

if scr_exists(follow_object){
	
 // --- TEMPORARY SNAPPING CODE ---
    // Comment out the physics speed calculation:
    /*
    var temp_dir = scr_wrap_direction_to_point(phy_position_x, phy_position_y, follow_object.phy_position_x, follow_object.phy_position_y);
    var temp_dist = scr_wrap_distance_to_point(phy_position_x, phy_position_y, follow_object.phy_position_x, follow_object.phy_position_y);
    camera_speed = min(6, temp_dist / 24);
    phy_speed_x = lengthdir_x(camera_speed, temp_dir);
    phy_speed_y = lengthdir_y(camera_speed, temp_dir);
    */

    // Add direct position snapping:
    phy_position_x = follow_object.phy_position_x;
    phy_position_y = follow_object.phy_position_y;
    phy_speed_x = 0; // Stop residual physics movement
    phy_speed_y = 0;
    // --- END TEMPORARY SNAPPING CODE ---
	}
	
// Move the background

layer_hspeed(layer_get_id("background_layer_1"), phy_speed_x*0.8)
layer_vspeed(layer_get_id("background_layer_1"), phy_speed_y*0.8)

layer_hspeed(layer_get_id("background_layer_2"), phy_speed_x*0.6)
layer_vspeed(layer_get_id("background_layer_2"), phy_speed_y*0.6)

layer_hspeed(layer_get_id("background_layer_3"), phy_speed_x*0.4)
layer_vspeed(layer_get_id("background_layer_3"), phy_speed_y*0.4)

layer_hspeed(layer_get_id("background_layer_4"), phy_speed_x*0)
layer_vspeed(layer_get_id("background_layer_4"), phy_speed_y*0)

	
// Wrap room

scr_wrap_room();

//


// Screen shake and rumble

if (global.screen_shake_duration > 0){
	phy_position_x += choose(random(global.screen_shake_intensity), -random(global.screen_shake_intensity))
	phy_position_y += choose(random(global.screen_shake_intensity), -random(global.screen_shake_intensity))
	gamepad_set_vibration(0,1,1)
	global.screen_shake_duration -= 1
	global.screen_shake_intensity -= 1
	}
else 
	gamepad_set_vibration(0,0,0)


// Audio

var listener_height = 0.25*global.zoom
listener_height = clamp(listener_height,0,1000)

audio_listener_position(phy_position_x,phy_position_y,listener_height)

// Zoom


if obj_input_controller.zoom_out
	zoom -= 10
		
if obj_input_controller.zoom_in
	zoom += 10

zoom = global.zoom
zoom = clamp(zoom,global.min_zoom,global.max_zoom)

temp_zoom += (zoom - temp_zoom)/100//25


var vm = matrix_build_lookat(phy_position_x,phy_position_y,-100,phy_position_x,phy_position_y,100,0,1,0);
var pm = matrix_build_projection_ortho(temp_zoom*1.6,temp_zoom,1,100000)
camera_set_view_mat(camera,vm)
camera_set_proj_mat(camera,pm)
view_camera[0] = camera;


// Inside obj_camera Step Event, after setting phy_speed_x/y
if scr_timer(60) { // Print once per second
    show_debug_message("Camera Debug: ID=" + string(id) + " Target=" + ((scr_exists(follow_object))?string(follow_object.id):"None") + " Pos=(" + string(floor(phy_position_x)) + "," + string(floor(phy_position_y)) + ") Speed=(" + string(phy_speed_x) + "," + string(phy_speed_y) + ")");
}


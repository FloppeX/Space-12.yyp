

// Keep modules from activating

with(obj_player){
	disabled_timer = 30
	add_thrust = 0
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		if scr_exists(ship_segment[i].module)
					ship_segment[i].module.activated = false
	}
	
// Move the player into and out of shop

with(obj_player){
	var angle_diff = angle_difference(-phy_rotation,90)
	physics_apply_angular_impulse(0.4 * angle_diff)
	physics_apply_angular_impulse(0.001 * phy_angular_velocity)
	var x_diff = obj_shop.phy_position_x - phy_position_x
	var x_force = x_diff
	physics_apply_force(phy_position_x,phy_position_y,x_force,0)
	var x_braking_force = -50 * phy_speed_x
		physics_apply_force(phy_position_x,phy_position_y,x_braking_force,0)
	
}

if (obj_player.phy_position_y - obj_shop.phy_position_y) > 50 and !scr_exists(wormhole_begin)
	global.player_entering_shop = true

var force_max = 60

if global.player_entering_shop{
	with(obj_player){
		var y_diff = phy_position_y - obj_shop.phy_position_y 
		var y_force = clamp(-y_diff,-force_max,force_max)
		physics_apply_force(phy_position_x,phy_position_y,0,y_force)
		var y_braking_force = -50 * phy_speed_y
		physics_apply_force(phy_position_x,phy_position_y,0,y_braking_force)
		
		global.zoom =  500 + y_diff
		
		if y_diff < 200 and y_diff > 180
			with(obj_module_holder_door){
				close = false
				open = true
	}
		}	
}

if global.player_exiting_shop and !instance_exists(obj_wormhole){
	global.zoom = 900
	global.active_level += 1
	wormhole_end = instance_create_depth(0.5 * room_width,0.5 * room_height-500,100,obj_wormhole_level_end_new)
	wormhole_end.next_level = global.levels[global.active_level]
	
	with(obj_module_holder_door){
			close = true
			open = false
	}
	}
				

if global.player_exiting_shop
	with(obj_player){
		var y_diff = phy_position_y - obj_wormhole.phy_position_y 
		var y_force = clamp(-y_diff,-force_max,force_max)
		physics_apply_force(phy_position_x,phy_position_y,0,y_force)
		//var y_braking_force = -40 * phy_speed_y
		//	physics_apply_force(phy_position_x,phy_position_y,0,y_braking_force)
		}
	
if global.player_entering_shop and !scr_exists(cursor)
	cursor = instance_create_depth(0.5 * room_width,0.5 * room_height,30,obj_cursor_new)
if global.player_exiting_shop and scr_exists(cursor)
	with(cursor)
		instance_destroy()
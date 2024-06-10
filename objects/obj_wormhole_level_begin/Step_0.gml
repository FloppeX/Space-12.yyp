event_inherited();

warp_start_timer -= 1;

if warping_ship == noone and !done_warping
	warping_ship = instance_place(phy_position_x,phy_position_y,ship_type)
	
if warping_ship == obj_player
	global.camera.follow_object = obj_player

if scr_exists(warping_ship)and !done_warping{
	
	
	// Create a fake ship object that will spin and shrink
	if !scr_exists(fake_warping_ship){
		fake_warping_ship = instance_create_depth(warping_ship.phy_position_x,warping_ship.phy_position_y,-10,obj_wormhole_traveller_level_begin_ship)
		fake_warping_ship.phy_rotation = warping_ship.phy_rotation
		fake_warping_ship.sprite_index = warping_ship.sprite_index
		var temp_dir = 270
		var temp_dist = 0//160//random(40)
		fake_warping_ship.phy_position_x = phy_position_x + lengthdir_x(temp_dist,temp_dir)
		fake_warping_ship.phy_position_y = phy_position_y + lengthdir_y(temp_dist,temp_dir)
		fake_warping_ship.draw_scale = 0
		fake_warping_ship.ship_rotation_speed = ship_rotation_speed
		for(var i = 0; i < array_length_1d(warping_ship.ship_segment); i+=1;){
			
			if scr_exists(warping_ship.ship_segment[i].module){
				fake_warping_ship.modules[i,0] = warping_ship.ship_segment[i].module.sprite_index
				fake_warping_ship.modules[i,3] = warping_ship.ship_segment[i].module.offset_angle
			}
			else{
				fake_warping_ship.modules[i,0] = spr_segment_2
				fake_warping_ship.modules[i,3] = 0
			}
			fake_warping_ship.modules[i,1] = warping_ship.ship_segment[i].placement_angle
			fake_warping_ship.modules[i,2] = warping_ship.ship_segment[i].placement_distance
	
			if warping_ship.ship_segment[i].ship_segment_right != noone
				fake_warping_ship.modules[i,4] = 1
			else fake_warping_ship.modules[i,4] = 0
			if warping_ship.ship_segment[i].ship_segment_below != noone
				fake_warping_ship.modules[i,5] = 1
			else fake_warping_ship.modules[i,5] = 0
			}
		}
		
	// Keeo the warping ship where the fake one is
	if scr_exists(warping_ship)
			with(warping_ship){
				scr_wrap_room_ship_new()
				disabled_timer = 10
				phy_speed_x = 0;
				phy_speed_y = 0;
				phy_position_x = other.phy_position_x
				phy_position_y = other.phy_position_y
				phy_rotation = other.phy_rotation
				phy_active = false
				visible = false
				for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
					ship_segment[i].phy_active = false
					ship_segment[i].visible = false
					if scr_exists(ship_segment[i].module){
						ship_segment[i].module.phy_active = false
						ship_segment[i].module.visible = false
						ship_segment[i].module.phy_rotation = phy_rotation-ship_segment[i].module.offset_angle
						}
					}				
				}

		
	// Check the fake ship to see if done warping
	if scr_exists(fake_warping_ship) and warp_start_timer <= 0{
		with(warping_ship){
		phy_rotation = other.fake_warping_ship.phy_rotation
		for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
					if scr_exists(ship_segment[i].module){
						ship_segment[i].module.phy_rotation = phy_rotation-ship_segment[i].module.offset_angle
						}
			}
		}
		if fake_warping_ship.draw_scale == 1{
			with(warping_ship){
				phy_active = true
				visible = false
				for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
					ship_segment[i].phy_active = true
					ship_segment[i].visible = false
					if scr_exists(ship_segment[i].module){
						ship_segment[i].module.phy_active = true
						ship_segment[i].module.visible = false
						ship_segment[i].module.phy_rotation = phy_rotation-ship_segment[i].module.offset_angle
					}
				}
			}
		}
			
			
		fake_warping_ship.draw_scale += 0.01
		fake_warping_ship.draw_scale = clamp(fake_warping_ship.draw_scale,0,1)
		fake_warping_ship.phy_rotation = fake_warping_ship.phy_rotation mod 360
		//var temp_angle_diff = abs(angle_difference(fake_warping_ship.phy_rotation,270))
		
		if fake_warping_ship.draw_scale == 1{
			if fake_warping_ship.phy_rotation > 90
				fake_warping_ship.ship_rotation_speed = -cos(degtorad(fake_warping_ship.phy_rotation))*ship_rotation_speed
			}
		}
	}
	

if scr_exists(fake_warping_ship)
	if fake_warping_ship.draw_scale == 1 and fake_warping_ship.ship_rotation_speed < 2
		done_warping = true
		
if done_warping == true and scr_exists(fake_warping_ship){
	if scr_exists(warping_ship){
		
		with(warping_ship){
			visible = true
			
			for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
				ship_segment[i].phy_active = true
				ship_segment[i].visible = true
				if scr_exists(ship_segment[i].module){
					ship_segment[i].module.phy_active = true
					ship_segment[i].module.visible = true
					//ship_segment[i].module.phy_rotation = phy_rotation-ship_segment[i].module.offset_angle
					}
				}
			phy_speed_x = 0;
			phy_speed_y = 0;
			//phy_rotation = other.fake_warping_ship.phy_rotation
			phy_position_x = other.fake_warping_ship.phy_position_x
			phy_position_y = other.fake_warping_ship.phy_position_y
			phy_angular_velocity = 0
			phy_active = true
			disabled_timer = 0
			visible = true

			}
		}
		with(fake_warping_ship)
				instance_destroy();
	}

if scr_exists(fake_warping_ship) and !scr_exists(warping_ship){
	done_warping = true
	with(fake_warping_ship)
				instance_destroy();
}
	
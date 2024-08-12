/*x = mouse_x
y = mouse_y
*/

gamepad_set_axis_deadzone(0, 0.1);
	left_stick_value = sqrt(power(gamepad_axis_value(0,gp_axislh),2) + power(gamepad_axis_value(0,gp_axislv),2))
	if left_stick_value > 0.2 {//abs(gamepad_axis_value(0,gp_axislh)) > 0.2 or abs(gamepad_axis_value(0,gp_axislv)) > 0.2{
		x += 2.5 * gamepad_axis_value(0,gp_axislh)
		y += 2.5 * gamepad_axis_value(0,gp_axislv)
		}
	gamepad_set_axis_deadzone(0, 0);

//


//
player_ship = instance_find(obj_player,0)

if mouse_check_button_pressed(mb_left) or gamepad_button_check_pressed(0,gp_face1){
	selected_segment = instance_place(x,y,obj_ship_segment)
	
	
	if scr_exists(selected_segment){
		var purchase_ok = false
		if player_ship.credits >= selected_segment.credit_cost and player_ship.diamonds >= selected_segment.diamond_cost
			purchase_ok = true;
		if selected_segment.owner == player_ship
			purchase_ok = true;
		if purchase_ok{
			if scr_check_module_placement(cursor_module,selected_segment){
				// Deduct the cost
				if selected_segment.owner != player_ship {
					if selected_segment.credit_cost > 0 or selected_segment.diamond_cost > 0{
						player_ship.credits -= selected_segment.credit_cost
						player_ship.diamonds -= selected_segment.diamond_cost
						selected_segment.module.owned_by_shop = false;
						selected_segment.module.owner = player_ship
						selected_segment.owner = player_ship
						selected_segment.module.credit_cost = 0.5 * selected_segment.module.credit_cost
						selected_segment.credit_cost = selected_segment.module.credit_cost
						selected_segment.module.depth = -20
						audio_play_sound_on(obj_shop.audio_emitter,snd_purchase,0,1)
						}
					//selected_segment.credit_cost = 0
				}				
				// Delete the modules joint
				segment_module = selected_segment.module
				selected_segment.module = noone
				if scr_exists(segment_module)
					if segment_module.joint != noone{
						physics_joint_delete(segment_module.joint)
						segment_module.joint = noone
						}
					
				// perform swap	
				
				// Move modules to swap modules
				segment_module_swap = segment_module
				cursor_module_swap = cursor_module
				
				// Move swap modules to regular modules
				segment_module = cursor_module_swap
				cursor_module_swap = noone
				if scr_exists(segment_module){
						selected_segment.module = segment_module
						selected_segment.module.owner = selected_segment.owner
						selected_segment.module.ship_segment = selected_segment
						selected_segment.module.phy_position_x = selected_segment.phy_position_x
						selected_segment.module.phy_position_y = selected_segment.phy_position_y
						selected_segment.module.visible = true
						selected_segment.module.persistent = true
						selected_segment.module.depth = selected_segment.depth -20
						if !selected_segment.visible // This is dumb, but it works as a way of checking if the segment is on a ship or a shop
							scr_adjust_module_placement_shop(selected_segment.module,selected_segment)
						else
							selected_segment.module.joint = physics_joint_revolute_create(selected_segment, selected_segment.module,selected_segment.module.phy_position_x,selected_segment.module.phy_position_y,0, 360, 0, 30,0,1,0);
						}
				segment_module = noone
	
				cursor_module = segment_module_swap
				segment_module_swap = noone
				
				if scr_exists(cursor_module){
					if cursor_module.joint != noone{
						physics_joint_delete(cursor_module.joint)
						cursor_module.joint = noone
						}

					}
				
				
				}
		}
		else 
			audio_play_sound_on(obj_shop.audio_emitter,snd_shop_error_1,0,1)
		}
		selected_segment = noone;
	}

if  scr_exists(cursor_module) and !object_is_ancestor(cursor_module.object_index,obj_crew_token){
	cursor_module.visible = true
	cursor_module.phy_position_x = x 
	cursor_module.phy_position_y = y
	cursor_module.phy_rotation = -90 -cursor_module.offset_angle
	cursor_module.ship_segment = noone
	cursor_module.module_above = noone
	cursor_module.module_right = noone
	cursor_module.module_below = noone
	cursor_module.module_left = noone
	
	}
	
//

if mouse_check_button_pressed(mb_left) or gamepad_button_check_pressed(0,gp_face1){
	pressed_button = instance_place(x,y,obj_shop_button)
	if pressed_button != noone
		pressed_button.activated = true
	}

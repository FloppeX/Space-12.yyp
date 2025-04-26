
// At the VERY START of obj_player Step_1 Event
show_debug_message("--- Step_1 Start Debug ---");
show_debug_message("Type of modifiers: " + typeof(modifiers)); // Should be "array"

if (is_array(modifiers)) {
    show_debug_message("Is Array = true");
    show_debug_message("Array Height (1D): " + string(array_length(modifiers))); // Check 1D length
    show_debug_message("Array Height (2D): " + string(array_height_2d(modifiers))); // Check 2D height

    // Check width of first row ONLY if height > 0
    if (array_height_2d(modifiers) > 0) {
         // Defensive check: ensure row 0 is actually an array itself
         if (is_array(modifiers[0])) {
              show_debug_message("Width of Row 0: " + string(array_length(modifiers[0]))); // Should be 5
         } else {
              show_debug_message("Row 0 is NOT an array!"); // Problem if this shows!
         }
    } else {
         show_debug_message("Height is 0, cannot check width."); // This would explain the error
    }
} else {
    show_debug_message("Is Array = false"); // Problem if this shows!
}
show_debug_message("-------------------------");




// Execute modifiers

for(var h = 0; h < array_height_2d(modifiers); h+=1;)
	if modifiers[h,0] != noone{
		script_execute(modifiers[h,0],modifiers[h,1])
		/*
		if scr_timer(120){ // Update descriptions. Dont need to do this every step...
			modifiers[h,2] = modifier_description
			description_lines[h+1,0] = modifier_description
			}
			*/
		}
		
// Update base health, since new segments may have been added

max_health_base =  array_length_1d(ship_segment) * 10

invisible = false
		
// Gamepad controls

if controls_disabled == false{
	gamepad_set_axis_deadzone(0, 0.1);
	rotation_value = gamepad_axis_value(0,gp_axislh);
	left_stick_value = sqrt(power(gamepad_axis_value(0,gp_axislh),2) + power(gamepad_axis_value(0,gp_axislv),2))
	if abs(gamepad_axis_value(0,gp_axislh)) > 0.2 or abs(gamepad_axis_value(0,gp_axislv)) > 0.2
		target_rotation = point_direction(0,0, gamepad_axis_value(0,gp_axislh), gamepad_axis_value(0,gp_axislv))
	gamepad_set_axis_deadzone(0, 0);
	
	rotation_value = sign(rotation_value) * left_stick_value
	
	if gamepad_button_check(0,gp_shoulderl){
		target_rotation = -phy_rotation+90
		left_stick_value = 1
		}
		
	if gamepad_button_check(0,gp_shoulderr){
		target_rotation = -phy_rotation-90
		left_stick_value = 1
		}
		
	add_thrust = gamepad_button_value(0, gp_shoulderrb)

	use_active_item = gamepad_button_value(0, gp_shoulderlb)

	if gamepad_button_check(0,gp_face1)
		gamepad_button[1] = true
	else gamepad_button[1] = false
	
	if gamepad_button_check(0,gp_face2)
		gamepad_button[2] = true
	else gamepad_button[2] = false
	
	if gamepad_button_check(0,gp_face3)
		gamepad_button[3] = true
	else gamepad_button[3] = false
		
	if gamepad_button_check(0,gp_face4)
		gamepad_button[4] = true
	else gamepad_button[4] = false
		
	if gamepad_button_check_pressed(0,gp_shoulderl)
		select_next_active_item = true
	else select_next_active_item = false
}

// Keyboard controls
if controls_disabled == false and !gamepad_is_connected(0){
	rotation_value = 0
	if keyboard_check(ord("A"))
		rotation_value -= 1
	if keyboard_check(ord("D"))
		rotation_value += 1
		
	if keyboard_check(ord("W"))
		add_thrust = 1
		
	if keyboard_check(ord("Q"))
		use_active_item = true

	if keyboard_check(vk_down)
		gamepad_button[1] = true
	else gamepad_button[1] = false
	
	if keyboard_check(vk_right)
		gamepad_button[2] = true
	else gamepad_button[2] = false
	
	if keyboard_check(vk_left)
		gamepad_button[3] = true
	else gamepad_button[3] = false
		
	if keyboard_check(vk_up) or keyboard_check(vk_space)
		gamepad_button[4] = true
	else gamepad_button[4] = false
		
	if keyboard_check(ord("E"))
		select_next_active_item = true
	else select_next_active_item = false
}

// Zoom

if gamepad_button_check_pressed(0,gp_padl)
		global.zoom = global.zoom - 100

if gamepad_button_check_pressed(0,gp_padr)
		global.zoom = global.zoom + 100
	
global.zoom = clamp(global.zoom,global.min_zoom,global.max_zoom)

	/*
if keyboard_check(vk_right){
	shop = room_duplicate(rm_shop)
	room_goto (shop)
	}
*/
// Testing stuff

	
if keyboard_check_pressed(ord("M")){
		credits += 4
	}
	
if keyboard_check_pressed(ord("N")){
		diamonds += 1
	}
	
if keyboard_check_pressed(ord("H"))
	obj_health += 50
	
if keyboard_check_pressed(vk_control){
		scr_add_ship_segment(id,24,obj_ship_segment_player)
	}
	
if keyboard_check_pressed(ord("Q")){
		scr_ship_update_segments(id,segment_distance)
	}
	
// Update modules and activate them!

for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
	if scr_exists(ship_segment[i].module){
		if gamepad_button[ship_segment[i].module.activation_button] == true and ship_segment[i].module.activation_button != 0
			ship_segment[i].module.activated = true
		if use_active_item and ship_segment[i].module.active
			ship_segment[i].module.activated = true
		}
		
// Update "wrap"-settings

global.wrap_border_left = phy_position_x - 0.5 * global.play_area_width;
global.wrap_border_right = phy_position_x + 0.5 * global.play_area_width;
global.wrap_border_top = phy_position_y - 0.5 * global.play_area_height;
global.wrap_border_bottom = phy_position_y + 0.5 * global.play_area_height;


function scr_create_ship_segments_OLD(argument0, argument1, argument2) {
	var number_of_segments = argument0//irandom(6)+3
	var segment_distance = argument1//24
	var segment_type = argument2
	
	show_debug_message("-> scr_create_ship_segments START for " + string(self.id) + "(" + object_get_name(self.object_index) + "). Num Segments Arg: " + string(num_segments) + ", Seg Obj Arg: " + object_get_name(seg_obj)); // Verify args

	//ship_segment[number_of_segments-1] = noone

	ship_segment[0] = instance_create_depth(phy_position_x,phy_position_y,-1,segment_type)
	number_segments_placed = 1;
	var segment_placed = false;

	repeat(20)
		if number_segments_placed < number_of_segments{
			segment_placed = false
			var i = irandom(array_length_1d(ship_segment)-1)//for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
				if segment_placed == false {
					var direction_randomizer = irandom(99)
					if direction_randomizer >= 0 and direction_randomizer < 30
						if !instance_place(ship_segment[i].phy_position_x+segment_distance,ship_segment[i].phy_position_y,segment_type){
							ship_segment[array_length_1d(ship_segment)] = instance_create_depth(ship_segment[i].phy_position_x+segment_distance,ship_segment[i].phy_position_y,-6,segment_type)
							number_segments_placed += 1
							segment_placed = true
							}
					if direction_randomizer >= 30 and direction_randomizer <= 49
						if !instance_place(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y-segment_distance,segment_type){
							ship_segment[array_length_1d(ship_segment)] = instance_create_depth(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y-segment_distance,-6,segment_type)
							number_segments_placed += 1
							segment_placed = true
							}
					if direction_randomizer >= 50 and direction_randomizer <= 69
						if !instance_place(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y+segment_distance,segment_type){
							ship_segment[array_length_1d(ship_segment)] = instance_create_depth(ship_segment[i].phy_position_x,ship_segment[i].phy_position_y+segment_distance,-6,segment_type)
							number_segments_placed += 1
							segment_placed = true
							}
					if direction_randomizer >= 69 and direction_randomizer <= 99
						if !instance_place(ship_segment[i].phy_position_x-segment_distance,ship_segment[i].phy_position_y,segment_type){
							ship_segment[array_length_1d(ship_segment)] = instance_create_depth(ship_segment[i].phy_position_x-segment_distance,ship_segment[i].phy_position_y,-6,segment_type)
							number_segments_placed += 1
							segment_placed = true
							}
						
					if segment_placed == true
						for(var h = 0; h < number_segments_placed; h += 1)
							if ship_segment[h] != noone
								with(ship_segment[h]){
									temp_segment = instance_place(phy_position_x,phy_position_y-segment_distance,segment_type)
										if temp_segment != noone
											if temp_segment.owner == owner
												ship_segment_left = temp_segment
									temp_segment = instance_place(phy_position_x+segment_distance,phy_position_y,segment_type)
										if temp_segment != noone
											if temp_segment.owner == owner
												ship_segment_above = temp_segment
									temp_segment = instance_place(phy_position_x,phy_position_y+segment_distance,segment_type)
										if temp_segment != noone
											if temp_segment.owner == owner
												ship_segment_right = temp_segment
									temp_segment = instance_place(phy_position_x-segment_distance,phy_position_y,segment_type)
										if temp_segment != noone
											if temp_segment.owner == owner
												ship_segment_below = temp_segment
									}
				}
		}

	// Delete all joints
			
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		with(ship_segment[i]){
			physics_joint_delete(joint)
			joint = noone
		}
	
	// Move the segments to the correct position

	for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
		temp_segment = ship_segment[i].ship_segment_left
		if temp_segment != noone{
			temp_segment.phy_position_x = ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation+90)
			temp_segment.phy_position_y = ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation+90)
			}
		temp_segment = ship_segment[i].ship_segment_above
		if temp_segment != noone{
			temp_segment.phy_position_x = ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation)
			temp_segment.phy_position_y = ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation)
			}
		temp_segment = ship_segment[i].ship_segment_right
		if temp_segment != noone{
			temp_segment.phy_position_x = ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation-90)
			temp_segment.phy_position_y = ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation-90)
			}
		temp_segment = ship_segment[i].ship_segment_below
		if temp_segment != noone{
			temp_segment.phy_position_x = ship_segment[i].phy_position_x + lengthdir_x(segment_distance,-phy_rotation+180)
			temp_segment.phy_position_y = ship_segment[i].phy_position_y + lengthdir_y(segment_distance,-phy_rotation+180)
			}
		}
	
	// Update position of actual ship object = average of all segment positions

	var x_total = 0
	var y_total = 0;
	for(var i = 0; i < array_length_1d(ship_segment); i+=1;){
		x_total += ship_segment[i].phy_position_x
		y_total += ship_segment[i].phy_position_y
		}
	phy_position_x = x_total / array_length_1d(ship_segment)
	phy_position_y = y_total / array_length_1d(ship_segment)

	// Join segments to ship

	for(var i = 0; i < array_length_1d(ship_segment); i+=1;)
		ship_segment[i].joint = physics_joint_weld_create(ship_segment[i], id, ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,0, 1, 1,false); //10, 12,false);

	show_debug_message("scr_create_ship_segments: Exiting for " + string(self.id) + ". Final seg count: " + string(array_length(self.ship_segment)));
}

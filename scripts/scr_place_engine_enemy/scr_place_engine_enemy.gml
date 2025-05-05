/// @function scr_place_engine_enemy(engine_module_object)
/// @param engine_module_object The object type of the engine to place.
/// @description Places the specified engine module in the valid empty slot furthest to the "rear" (maximum relative Y).
///              Uses scr_find_valid_module_slots. Returns true if placed, false otherwise.
///              Assumes called from the ship instance. Requires ship_segment array.

function scr_place_engine_enemy(argument0) {
    var engine_type = argument0;
    var engine_placed = false;
    var best_seg_index = -1;
    var max_relative_y = -infinity; // Find the largest relative Y (Geometric Down = Ship Rear)

    // Safety Check: Ensure ship_segment array exists
    if (!variable_instance_exists(id, "ship_segment") || !is_array(ship_segment)) {
        show_debug_message("ERROR in scr_place_engine_enemy: ship_segment array missing for " + string(id));
        return false;
    }

    // Create temporary engine instance to check placement requirements
    if (!object_exists(engine_type)) { show_debug_message("ERROR: Engine type " + string(engine_type) + " not found!"); return false; }
    var temp_engine = instance_create_depth(0, 0, 0, engine_type);
    if (!instance_exists(temp_engine)) { show_debug_message("ERROR: Failed to create temp engine!"); return false; }
    temp_engine.owner = id;
    // *** CORRECTED REQUIREMENTS: Ensure engine requires space behind it (Geometric Down) ***
    temp_engine.placement_req_below = noone; // Engine needs clear space to the geometric bottom (ship's rear)
    temp_engine.placement_req_above = 1;
    temp_engine.placement_req_left = 1;
    temp_engine.placement_req_right = 1;
    // *** END Requirement Setting ***


    // Find *all* valid empty slots for this engine type based on requirements
    var valid_slots = scr_find_valid_module_slots(id, temp_engine);
    var num_valid = ds_list_size(valid_slots);

    show_debug_message("scr_place_engine_enemy: Found " + string(num_valid) + " valid slots for engine.");

    if (num_valid > 0) {
        // Iterate through the list of VALID slots to find the best one (maximum relative Y)
        for (var i = 0; i < num_valid; i++) {
            var seg_index = valid_slots[| i];

            // Double check segment exists and index is valid
            if (seg_index < array_length(ship_segment) && scr_exists(ship_segment[seg_index])) {
                var _seg = ship_segment[seg_index];
                // Calculate Y relative to ship center
                var relative_y = _seg.phy_position_y - phy_position_y;

                if (relative_y > max_relative_y) { // Look for maximum Y
                     max_relative_y = relative_y;
                     best_seg_index = seg_index;
                }
            }
        } // End loop through valid slots

        // Place engine if a best slot was determined
        if (best_seg_index != -1) {
             var target_segment = ship_segment[best_seg_index];
             if (target_segment.module == noone) { // Double check empty
                 instance_destroy(temp_engine); // Destroy the temporary one
                 var final_engine = instance_create_depth(0,0,0, engine_type);
                 if(instance_exists(final_engine)){
                     final_engine.owner = id; final_engine.ship_segment = target_segment; target_segment.module = final_engine;
                     engine_placed = true;
                     show_debug_message("scr_place_engine_enemy: Placed engine in segment " + string(best_seg_index) + " with relative Y " + string(max_relative_y));
                 } else { show_debug_message("ERROR: Failed to create final engine instance!"); engine_placed = false; }
             } else { show_debug_message("WARN: Best slot for engine (" + string(best_seg_index) + ") was already filled!"); instance_destroy(temp_engine); engine_placed = false; }
        } else { show_debug_message("WARN: Could not determine best rear segment from valid slots."); instance_destroy(temp_engine); engine_placed = false; }
    } else {
         show_debug_message("WARN: No valid slots found for engine based on requirements."); // Added specific message
         instance_destroy(temp_engine);
         engine_placed = false;
    }

    ds_list_destroy(valid_slots);
    if (!engine_placed && instance_exists(temp_engine)) { instance_destroy(temp_engine); show_debug_message("WARN: scr_place_engine_enemy did not place an engine."); }
    return engine_placed;
}
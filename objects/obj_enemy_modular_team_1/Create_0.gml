// Inherit common enemy properties from parent obj_enemy_ship
event_inherited();

// --- Team 1 Specific Stats (Overrides if needed) ---
// max_rotation_speed = 60; // Example: Keep parent's value unless specified
// max_speed_base = 2.8;
// rotation_force = 200;
target_objects = [obj_player, obj_enemy_modular_team_2]; // Ensure correct targets for Team 1

// --- Ship Generation ---
var segment_distance = 24;
// Use the global variable set before creating this instance
var number_of_segments = max(3, global.temp_number_of_segments); // Ensure at least 3 segments
ship_segment = []; // Initialize array

show_debug_message("Creating Team 1 Enemy (" + string(id) + ") with " + string(number_of_segments) + " segments.");
var number_of_segments = max(3, global.temp_number_of_segments);
var segment_distance = 24;
var _seg_obj_to_create = obj_ship_segment_enemy; // Define variable just to be clear

// Pass the NAME of the object using object_get_name()
scr_create_ship_segments_NEW(number_of_segments, segment_distance, object_get_name(_seg_obj_to_create));

// --- Place Modules ---

// 1. Place Engine(s) (Same as before)
var num_engines = max(1, round(number_of_segments / 4));
repeat (num_engines) {
    scr_place_engine_enemy(obj_module_engine_enemy); // Use correct engine type for the enemy
}

// 2. Place Cockpit (Same as before - place if possible)
var cockpit_placed = false;
var temp_cockpit = instance_create_depth(0, 0, -10, obj_module_enemy_cockpit_1); // Use correct cockpit type
if (scr_exists(temp_cockpit)) {
    var valid_cockpit_slots = scr_find_valid_module_slots(id, temp_cockpit);
    if (ds_list_size(valid_cockpit_slots) > 0) {
        ds_list_shuffle(valid_cockpit_slots);
        var index = valid_cockpit_slots[| 0];
        ship_segment[index].module = temp_cockpit;
        temp_cockpit.owner = id; temp_cockpit.ship_segment = ship_segment[index]; cockpit_placed = true;
    }
    ds_list_destroy(valid_cockpit_slots);
    if (!cockpit_placed) { instance_destroy(temp_cockpit); /* Log warning */ }
}

// --- MODIFICATION START: Guarantee ONE Weapon ---
var first_weapon_placed = false;
var weapon_attempts = 0;
var max_weapon_attempts = 30; // Try up to 30 times to place the first weapon

repeat (max_weapon_attempts) {
    var temp_weapon = scr_create_random_enemy_weapon(); // Use correct weapon generator
    if (!scr_exists(temp_weapon)) { weapon_attempts +=1; continue; } // Try again if creation failed

    var valid_slots = scr_find_valid_module_slots(id, temp_weapon);
    if (ds_list_size(valid_slots) > 0) {
        // Found a spot for this weapon!
        ds_list_shuffle(valid_slots);
        var index = valid_slots[| 0];
        ship_segment[index].module = temp_weapon;
        temp_weapon.owner = id; temp_weapon.ship_segment = ship_segment[index];
        first_weapon_placed = true;
        ds_list_destroy(valid_slots);
        show_debug_message("Placed first weapon (type: " + object_get_name(temp_weapon.object_index) + ") after " + string(weapon_attempts+1) + " attempts.");
        break; // Exit the repeat loop successfully
    } else {
        // No valid slot for *this* specific weapon, destroy it and try another type
        ds_list_destroy(valid_slots);
        instance_destroy(temp_weapon);
        weapon_attempts += 1;
    }
}

if (!first_weapon_placed) {
    show_debug_message("WARNING: Enemy " + string(id) + " failed to place ANY weapon after " + string(max_weapon_attempts) + " attempts!");
    // Consider adding fallback logic here if needed - e.g., force-place a basic blaster?
}
// --- MODIFICATION END ---


// 4. Place Additional Weapons (Optional - use the simple 'place if possible' logic)
var num_additional_weapons = max(0, round(number_of_segments / 3) - 1); // Place total based on size, minus the one we guaranteed
var additional_weapons_placed = 0;
for (var w = 0; w < num_additional_weapons; w += 1) {
    var weapon_placed_this_loop = false;
    var temp_weapon = scr_create_random_enemy_weapon();
    if (!scr_exists(temp_weapon)) continue;

    var valid_slots = scr_find_valid_module_slots(id, temp_weapon);
    if (ds_list_size(valid_slots) > 0) {
        ds_list_shuffle(valid_slots);
        var index = valid_slots[| 0];
        ship_segment[index].module = temp_weapon;
        temp_weapon.owner = id; temp_weapon.ship_segment = ship_segment[index]; weapon_placed_this_loop = true; additional_weapons_placed += 1;
    }
    ds_list_destroy(valid_slots);
    if (!weapon_placed_this_loop) { instance_destroy(temp_weapon); }
}
// show_debug_message("Placed " + string(additional_weapons_placed) + " additional weapons.");


// 5. Place Devices (Optional - use the simple 'place if possible' logic)
var num_devices_to_place = max(0, round(number_of_segments / 5));

// --- Final Update & Joint Creation ---
// Make sure scr_ship_update_segments(...) is commented out before this!

show_debug_message("Starting final loop for joint creation for " + string(id) + " (" + object_get_name(object_index) + ")");
var _is_enemy = object_is_ancestor(object_index, obj_enemy_ship); // Check if this is an enemy

for (var i = 0; i < array_length(ship_segment); i += 1) {
    var _seg = ship_segment[i]; // Get segment instance more clearly
    if (scr_exists(_seg)) {

        // Set final properties for segment
        _seg.owner = id;
        _seg.persistent = persistent; // Inherit persistence (true for player, false for enemy)
        _seg.visible = true;
        // Recalculate placement angle/dist based on final physics position? Or leave as is?
        _seg.placement_angle = point_direction(phy_position_x, phy_position_y, _seg.phy_position_x, _seg.phy_position_y);
        _seg.placement_distance = point_distance(phy_position_x, phy_position_y, _seg.phy_position_x, _seg.phy_position_y);

        // --- 1. Create Segment Weld Joint (Connects Segment to Main Ship Body) ---
        // Ensure segment joint variable exists and is initialized
        if (!variable_instance_exists(_seg.id, "joint")) { _seg.joint = noone; }

        // Create the weld joint connecting this segment (_seg) to the main ship body (id) IF it doesn't exist
        if (_seg.joint == noone) {
            _seg.joint = physics_joint_weld_create(id, _seg, _seg.phy_position_x, _seg.phy_position_y, 0, 10000, 1, false);
             if (_seg.joint < 0) {
                  show_debug_message("WARN: Failed to create weld joint for segment " + string(_seg.id));
                  _seg.joint = noone;
             } else {
                  // show_debug_message("Created weld joint " + string(_seg.joint) + " for segment " + string(_seg.id));
             }
        }
		// --- Handle Attached Module & Its Joint ---
            if (scr_exists(_seg.module)) {
                var _module = _seg.module;
                // ... (set module owner, persistent, visible, pos, rot) ...
                 _module.owner = id;
                 _module.persistent = persistent;
                 _module.visible = true;
                 _module.phy_position_x = _seg.phy_position_x;
                 _module.phy_position_y = _seg.phy_position_y;
                 // Calculate the initial angle based on ship rotation and module offset
				var _initial_module_angle = -phy_rotation + _module.offset_angle;

				// Normalize the angle to be within 0-359.9 degrees
				while (_initial_module_angle >= 360) { _initial_module_angle -= 360; }
				while (_initial_module_angle < 0) { _initial_module_angle += 360; }

				// Set the module's physics rotation to the normalized angle
				_module.phy_rotation = _initial_module_angle;

                // Ensure module joint variable exists
                if (!variable_instance_exists(_module.id, "joint")) { _module.joint = noone; }

                // Create the revolute joint connecting the module (_module) to THIS segment (_seg) if it doesn't exist
                if (_module.joint == noone) {
                    if (_is_enemy) { show_debug_message("   Attempting revolute joint for enemy module " + string(_module.id) + " on segment " + string(_seg.id)); } // Debug for enemy

                    // *** CORRECTED ARGUMENTS (11 total) ***
                    _module.joint = physics_joint_revolute_create(
                                         _seg,      // inst1: The segment it's attached to
                                         _module,   // inst2: The module itself
                                         _module.phy_position_x, // w_anchor_x: Anchor X (world)
                                         _module.phy_position_y, // w_anchor_y: Anchor Y (world)
                                         0,         // ang_min_lim: Angle Lower Limit (degrees)
                                         360,       // ang_max_lim: Angle Upper Limit (degrees)
                                         false,     // ang_limit_enable: Enable Angle Limits? (false = free rotation)
                                         0,         // max_motor_torque: Max Motor Torque (motor off)
                                         0,         // motor_speed: Motor Speed (doesn't matter if off) - Changed from 10
                                         false,     // motor_enable: Enable Motor? (false)
                                         false);    // collide_connected: Collide Connected Bodies? (false)

                     if (_module.joint < 0) {
                          show_debug_message("WARN: Failed to create revolute joint for module " + string(_module.id) + " (Attached to seg " + string(_seg.id) + ")");
                          _module.joint = noone;
                     } else {
                          if (_is_enemy) { show_debug_message("   SUCCESS creating revolute joint " + string(_module.joint) + " for enemy module " + string(_module.id)); } // Debug for enemy
                     }
                }
            } // --- End Module Handling ---
    } // End if (scr_exists(_seg))
} // End final loop

show_debug_message("Finished final loop for joint creation for " + string(id));

// Final health calculation (should be done AFTER the loop)
max_health_base = array_length(ship_segment) * ((object_is_ancestor(object_index, obj_enemy_ship)) ? 8 : 10); // Different base health?
max_health_multiplier = (object_is_ancestor(object_index, obj_enemy_ship)) ? (1 + 0.1 * global.difficulty_level) : 1; // Apply enemy difficulty?
max_health = (max_health_base * max_health_multiplier) + max_health_bonus;
obj_health = max_health;
old_obj_health = obj_health;

show_debug_message(object_get_name(object_index) + " (" + string(id) + ") Create Event COMPLETED.");
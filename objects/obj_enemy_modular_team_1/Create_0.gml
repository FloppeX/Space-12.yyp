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
scr_ship_update_segments(id, segment_distance); // Update neighbors and positions relative to CoM

for (var i = 0; i < array_length(ship_segment); i += 1) {
    if (scr_exists(ship_segment[i])) {
        ship_segment[i].owner = id;
        ship_segment[i].persistent = false;
        ship_segment[i].visible = true;
        ship_segment[i].placement_angle = point_direction(phy_position_x, phy_position_y, ship_segment[i].phy_position_x, ship_segment[i].phy_position_y);
        ship_segment[i].placement_distance = point_distance(phy_position_x, phy_position_y, ship_segment[i].phy_position_x, ship_segment[i].phy_position_y);

        if (scr_exists(ship_segment[i].module)) {
            var _module = ship_segment[i].module;
            _module.owner = id;
            _module.persistent = false;
            _module.visible = true;
            _module.phy_position_x = ship_segment[i].phy_position_x;
            _module.phy_position_y = ship_segment[i].phy_position_y;
            _module.phy_rotation = -phy_rotation + _module.offset_angle;
            if (_module.joint == noone) {
                _module.joint = physics_joint_revolute_create(ship_segment[i], _module, _module.phy_position_x, _module.phy_position_y, 0, 360, 0, 10, 0, 1, 0);
            }
        }
        // Ensure segment weld joints are created (assuming scr_ship_update_segments handles this)
    }
}

// --- Final Health Calculation ---
max_health_base = array_length(ship_segment) * 8; // Base health per segment for enemies
max_health_multiplier = (1 + 0.1 * global.difficulty_level); // Apply difficulty scaling
max_health = (max_health_base * max_health_multiplier) + max_health_bonus; // Include bonuses from parent
obj_health = max_health;
old_obj_health = obj_health;

// --- Specific Sounds (If different from parent) ---
// explosion_sound = snd_explosion_medium; // Example
// engine_sound = snd_engine_1b;        // Example

// Ensure gun_bullet_speed is set (if not inherited)
gun_bullet_speed = 8; // Value from original snippet
// In obj_player Create Event

// --- NEW CONFIGURATION VARIABLES ---
starting_segments = 4;                      // How many segments the player ship starts with
guarantee_forward_facing_starting_gun = true; // If true, generation retries until layout allows a forward gun. If false, gun might not be placed.
// ----------------------------------

// --- Basic Initialization ---
timer = 0;
obj_health = 100; // Placeholder, recalculated later
destroyed = false;
use_active_item = false;
select_next_active_item = false;
add_thrust = 0;
rotation_value = 0;
selected_active_module = noone;
controls_disabled = false;
disabled_timer = 0;
gamepad_button = array_create(6, false);
calculated_com_x = phy_position_x; // Initialize CoM to current position
calculated_com_y = phy_position_y;

// --- Ship Stats Initialization ---
max_speed_base = 2.8; max_speed_multiplier = 1; max_speed_bonus = 0;
rotation_speed_base = 60; rotation_speed_multiplier = 1; rotation_speed_bonus = 0;
drift_resistance_base = 14; drift_resistance_multiplier = 1; drift_resistance_bonus = 0;
max_health_base = 10; max_health_multiplier = 1; max_health_bonus = 0; // Base recalculated later
max_energy_base = 100; max_energy_multiplier = 1; max_energy_bonus = 0;
max_particles_base = 100; max_particles_multiplier = 1; max_particles_bonus = 0;
energy_increase_base = 0.5; energy_increase_multiplier = 1; energy_increase_bonus = 0;
luck_base = 1; luck_multiplier = 1; luck_bonus = 0;

// Calculate initial drift resistance (other stats calculated in Step 0)
drift_resistance = (drift_resistance_base * drift_resistance_multiplier) + drift_resistance_bonus;

// Set initial health, energy, particles, etc.
obj_health = 100; // Temporary
obj_health_old = obj_health;
energy = 100; max_energy = 100;
particles = 0; max_particles = 100;
diamonds = 0; credits = 0; credits_old = 0; credits_gained = 0;
hit_invulnerable_timer = 0;
energy_disabled = false; energy_disabled_timer = 60; energy_disabled_duration = 60;

// Targetting
target_objects = [obj_enemy_ship, obj_enemy_modular_team_2];

// Graphics
invisible = false; alpha = 1; draw_scale = 1;

// Map & UI related
show_map = true;
map_scale = 4.5;
map_width = global.gui_scale * 100 * map_scale; map_height = global.gui_scale * 100 * map_scale;
map_edge_right = 15.5 * global.gui_unit; map_edge_left = map_edge_right - map_width;
map_edge_top = 0.5 * global.gui_unit; map_center_x = map_edge_left + 0.5*map_width; map_center_y = map_edge_top+0.5*map_height;
map_range = 0.8 * global.play_area_width;
map_objects = array_create(100, 5, noone);
number_of_map_objects = 0;

// Pickups
pickup_seek_range = 100; pickup_pull_force = 160;

// Crew & Modifiers (Manual 2D array creation)
crew = [];
modifiers = [];
for (var _h = 0; _h < 10; _h += 1) { modifiers[_h] = array_create(5, noone); }

// Physics properties
rotation_force = 100;
segment_distance = 24; // Made into instance variable

// Sounds
sound_priority = 1; explosion_sound = snd_explosion_large_01; engine_sound = snd_engine_2;
ship_audio_emitter = audio_emitter_create();
audio_emitter_falloff(ship_audio_emitter, 600, 800, 1);

// Debris
debris_parts[0] = spr_debris_player_1; debris_parts[1] = spr_debris_player_2; debris_parts[2] = spr_debris_player_3;

// --- Ship Generation ---
ship_segment = []; // Ensure array is initialized/reset

var weapon_placed = false;
var cockpit_placed = false;
var temp_weapon = noone;
var temp_cockpit = noone;

// --- Conditional Logic based on Guarantee Flag ---
if (guarantee_forward_facing_starting_gun) {
    // --- Logic to GUARANTEE 2+ Forward Slots ---
    var _forward_slots_found = 0;
    var _attempts = 0;
    var _max_attempts = 50;
    show_debug_message("Attempting to generate player ship layout (Guaranteeing Fwd Gun)...");

    repeat (_max_attempts) {
        // Cleanup previous attempt
        for (var i = 0; i < array_length(ship_segment); i += 1) { if (scr_exists(ship_segment[i])) { if (scr_exists(ship_segment[i].module)) instance_destroy(ship_segment[i].module); instance_destroy(ship_segment[i]); } }
        ship_segment = [];

        // Create segments using NEW script and instance variable 'starting_segments'
        scr_create_ship_segments_NEW(starting_segments, segment_distance, obj_ship_segment_player);

        // Check for required forward slots (needs space to Geometric Right)
        _forward_slots_found = 0;
        var _dummy = instance_create_depth(0, 0, 0, obj_module);
        // Define forward requirements (clear space right)
        _dummy.placement_req_right = noone; _dummy.placement_req_left = 1; _dummy.placement_req_above = 1; _dummy.placement_req_below = 1;
        for (var i = 0; i < array_length(ship_segment); i += 1) { if (scr_exists(ship_segment[i]) && ship_segment[i].module == noone && scr_check_module_placement(_dummy, ship_segment[i])) { _forward_slots_found += 1; } }
        instance_destroy(_dummy);

        if (_forward_slots_found >= 2) { // Need space for weapon AND cockpit
            show_debug_message("Layout OK after " + string(_attempts + 1) + " attempts.");
            break; // Exit loop
        }
        _attempts += 1;
    }

    if (_attempts >= _max_attempts) { show_debug_message("ERROR: Failed to generate player ship with 2 forward slots!"); /* Handle failure? */ }

    // Place Engine(s) - Assuming scr_place_engine_player is updated (Response #65)
    scr_place_engine_player();

    // Place Weapon in a Forward Slot (using corrected requirements)
    temp_weapon = scr_create_random_starting_gun();
    if (scr_exists(temp_weapon)) {
        temp_weapon.offset_angle = 0;
        temp_weapon.placement_req_right = noone; temp_weapon.placement_req_left = 1; temp_weapon.placement_req_above = 1; temp_weapon.placement_req_below = 1;
        var valid_weapon_slots = scr_find_valid_module_slots(id, temp_weapon);
        if (ds_list_size(valid_weapon_slots) > 0) {
            ds_list_shuffle(valid_weapon_slots); var index = valid_weapon_slots[| 0];
            if (scr_exists(ship_segment[index]) && ship_segment[index].module == noone){ // Final check
                 ship_segment[index].module = temp_weapon; temp_weapon.owner = id; temp_weapon.ship_segment = ship_segment[index]; weapon_placed = true;
                 show_debug_message("Player Create: Placed starting weapon in segment " + string(index));
            } else {weapon_placed = false;} // Slot became invalid?
        }
        ds_list_destroy(valid_weapon_slots);
        if (!weapon_placed && instance_exists(temp_weapon)) { instance_destroy(temp_weapon); show_debug_message("WARN: Could not place starting weapon!"); }
    }

    // Place Cockpit in a DIFFERENT Forward Slot (using corrected requirements)
    if (weapon_placed) { // Only if weapon was placed
        var temp_cockpit_obj = choose(obj_module_cockpit_1, obj_module_cockpit_2, obj_module_cockpit_3, obj_module_cockpit_4, obj_module_cockpit_5);
        temp_cockpit = instance_create_depth(0, 0, -10, temp_cockpit_obj);
        if (scr_exists(temp_cockpit)) {
            // Set forward placement requirements for cockpit too
            temp_cockpit.placement_req_right = noone; temp_cockpit.placement_req_left = 1; temp_cockpit.placement_req_above = 1; temp_cockpit.placement_req_below = 1;
            var valid_slots = scr_find_valid_module_slots(id, temp_cockpit); // Finds *remaining* valid forward slots
            if (ds_list_size(valid_slots) > 0) {
                ds_list_shuffle(valid_slots); var index = valid_slots[| 0];
                 if (scr_exists(ship_segment[index]) && ship_segment[index].module == noone){ // Final check
                    ship_segment[index].module = temp_cockpit; temp_cockpit.owner = id; temp_cockpit.ship_segment = ship_segment[index]; cockpit_placed = true;
                    show_debug_message("Player Create: Placed cockpit in segment " + string(index));
                 } else {cockpit_placed = false;} // Slot became invalid?
            }
            ds_list_destroy(valid_slots);
            if (!cockpit_placed && instance_exists(temp_cockpit)) { instance_destroy(temp_cockpit); show_debug_message("WARN: Couldn't place cockpit!"); }
        }
    }
    // --- End Guarantee Logic ---

} else {
    // --- Logic that DOESN'T Guarantee Gun (Best Effort) ---
    show_debug_message("Attempting to generate player ship layout (Best Effort Gun)...");

    // Create segments using NEW script and instance variable 'starting_segments'
    // *** CORRECTED SCRIPT CALL ***
    scr_create_ship_segments_NEW(starting_segments, segment_distance, obj_ship_segment_player);

    // Place Engine(s) - Assuming scr_place_engine_player is updated (Response #65)
    scr_place_engine_player();

    // Place Cockpit (using simple slot finding with corrected requirements)
    var temp_cockpit_obj = choose(obj_module_cockpit_1, obj_module_cockpit_2, obj_module_cockpit_3, obj_module_cockpit_4, obj_module_cockpit_5);
    temp_cockpit = instance_create_depth(0, 0, -10, temp_cockpit_obj);
    if (scr_exists(temp_cockpit)) {
        // *** CORRECTED PLACEMENT REQUIREMENTS ***
        temp_cockpit.placement_req_right = noone; temp_cockpit.placement_req_left = 1; temp_cockpit.placement_req_above = 1; temp_cockpit.placement_req_below = 1;
        var valid_slots = scr_find_valid_module_slots(id, temp_cockpit);
        if (ds_list_size(valid_slots) > 0) {
            ds_list_shuffle(valid_slots); var index = valid_slots[| 0];
            if (scr_exists(ship_segment[index]) && ship_segment[index].module == noone){
                 ship_segment[index].module = temp_cockpit; temp_cockpit.owner = id; temp_cockpit.ship_segment = ship_segment[index]; cockpit_placed = true;
            } else {cockpit_placed = false;}
        }
        ds_list_destroy(valid_slots);
        if (!cockpit_placed && instance_exists(temp_cockpit)) { instance_destroy(temp_cockpit); }
    }

    // Place Weapon (using simple slot finding with corrected requirements - might fail)
    temp_weapon = scr_create_random_starting_gun();
    if (scr_exists(temp_weapon)) {
        // *** CORRECTED PLACEMENT REQUIREMENTS ***
        temp_weapon.offset_angle = 0;
        temp_weapon.placement_req_right = noone; temp_weapon.placement_req_left = 1; temp_weapon.placement_req_above = 1; temp_weapon.placement_req_below = 1;

        var valid_slots = scr_find_valid_module_slots(id, temp_weapon);
        if (ds_list_size(valid_slots) > 0) {
            ds_list_shuffle(valid_slots); var index = valid_slots[| 0];
            if (scr_exists(ship_segment[index]) && ship_segment[index].module == noone){
                ship_segment[index].module = temp_weapon; temp_weapon.owner = id; temp_weapon.ship_segment = ship_segment[index]; weapon_placed = true;
            } else {weapon_placed = false;}
        }
        ds_list_destroy(valid_slots);
        if (!weapon_placed && instance_exists(temp_weapon)) {
            instance_destroy(temp_weapon);
            show_debug_message("NOTE: Could not place starting weapon (guarantee was off).");
        }
    }
    // --- End Best Effort Logic ---
} // End if/else (guarantee_forward_facing_starting_gun)


// --- Final Joint Creation --- (Using corrected code from Response #55)
// Ensure scr_ship_update_segments(...) is COMMENTED OUT before this!
show_debug_message("Starting final loop for joint creation for " + string(id) + " (" + object_get_name(object_index) + ")");
for (var i = 0; i < array_length(ship_segment); i += 1) {
    var _seg = ship_segment[i];
    if (scr_exists(_seg)) {
        _seg.owner = id; _seg.persistent = persistent; _seg.visible = true;
        _seg.placement_angle = point_direction(phy_position_x, phy_position_y, _seg.phy_position_x, _seg.phy_position_y);
        _seg.placement_distance = point_distance(phy_position_x, phy_position_y, _seg.phy_position_x, _seg.phy_position_y);

        // Create Segment Weld Joint
        if (!variable_instance_exists(_seg.id, "joint")) { _seg.joint = noone; }
        if (_seg.joint == noone) {
            _seg.joint = physics_joint_weld_create(id, _seg, _seg.phy_position_x, _seg.phy_position_y, 0, 20, 0.2, false);
            if (_seg.joint < 0) { show_debug_message("PLAYER WARN: Failed weld joint seg " + string(_seg.id)); _seg.joint = noone; }
            else { /* show_debug_message("PLAYER OK: Weld joint seg " + string(_seg.id)); */ }
        }
        // Handle Attached Module & Its Joint
        if (scr_exists(_seg.module)) {
            var _module = _seg.module;
            _module.owner = id; _module.persistent = persistent; _module.visible = true;
            _module.phy_position_x = _seg.phy_position_x; _module.phy_position_y = _seg.phy_position_y;
            var _initial_module_angle = -phy_rotation + _module.offset_angle;
            while (_initial_module_angle >= 360) { _initial_module_angle -= 360; } while (_initial_module_angle < 0) { _initial_module_angle += 360; }
            _module.phy_rotation = _initial_module_angle;
            if (!variable_instance_exists(_module.id, "joint")) { _module.joint = noone; }
            if (_module.joint == noone) {
                _module.joint = physics_joint_revolute_create(_seg, _module, _module.phy_position_x, _module.phy_position_y, 0, 0, false, 0, 0, false, false); // Free spin
                if (_module.joint < 0) { show_debug_message("PLAYER WARN: Failed revolute joint module " + string(_module.id)); _module.joint = noone; }
            }
        }
    }
}
show_debug_message("Finished final loop for joint creation for " + string(id));


scr_update_segment_neighbors();

//scr_recenter_ship_on_com();

// --- Final Health Calculation ---
max_health_base = array_length(ship_segment) * 10;
max_health = (max_health_base + max_health_bonus) * max_health_multiplier;
obj_health = max_health;
obj_health_old = obj_health;

// --- Final Player-Specific Setup ---
global.player = id; // Set global player reference


// Create the marker using depth, placing it shallower (more in front) than the player
var marker_depth = -10000; // Or choose depth relative to player, e.g., depth - 10
show_debug_message("Attempting to create marker at depth: " + string(marker_depth));
com_marker_instance = instance_create_depth(x, y, marker_depth, obj_com_marker); // Use instance_create_depth

if (!instance_exists(com_marker_instance)) {
    show_debug_message("WARN: Failed to create CoM marker instance using depth!");
    com_marker_instance = noone;
} else {
    com_marker_instance.visible = true; // Explicitly set visible
    show_debug_message("CoM marker instance " + string(com_marker_instance) + " created at depth " + string(marker_depth) + ".");
}
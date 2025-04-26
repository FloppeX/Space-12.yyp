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
gamepad_button = array_create(6, false); // Ensure array exists

// --- Ship Stats Initialization ---
max_speed_base = 2.8; max_speed_multiplier = 1; max_speed_bonus = 0;
rotation_speed_base = 60; rotation_speed_multiplier = 1; rotation_speed_bonus = 0;
drift_resistance_base = 14; drift_resistance_multiplier = 1; drift_resistance_bonus = 0;
max_health_base = 10; max_health_multiplier = 1; max_health_bonus = 0; // Base recalculated later
max_energy_base = 100; max_energy_multiplier = 1; max_energy_bonus = 0;
max_particles_base = 100; max_particles_multiplier = 1; max_particles_bonus = 0;
energy_increase_base = 0.5; energy_increase_multiplier = 1; energy_increase_bonus = 0;
luck_base = 1; luck_multiplier = 1; luck_bonus = 0;
// (Initial derived stat calculations omitted as they run in Step 0 anyway)

// Set initial health, energy, particles, etc.
obj_health = 100; // Temporary, set properly after segments created
obj_health_old = obj_health;
energy = 100; // Start with max?
max_energy = 100; // Set initial max
particles = 0;
max_particles = 100;
diamonds = 0;
credits = 0;
credits_old = 0;
credits_gained = 0;
hit_invulnerable_timer = 0;
energy_disabled = false;
energy_disabled_timer = 60;
energy_disabled_duration = 60;

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
map_objects = array_create(100, 5, noone); // Increased size?
number_of_map_objects = 0;

// Pickups
pickup_seek_range = 100; pickup_pull_force = 160;

// Crew & Modifiers
crew = [];
modifiers = []; // Create the outer array (rows)
for (var _h = 0; _h < 10; _h += 1) { // Loop 10 times for 10 rows
    modifiers[_h] = array_create(5, noone); // Create the inner array (5 columns) for this row
	}

// Physics properties
rotation_force = 100;

// Sounds
sound_priority = 1;
explosion_sound = snd_explosion_large_01;
engine_sound = snd_engine_2;
ship_audio_emitter = audio_emitter_create();
audio_emitter_falloff(ship_audio_emitter, 600, 800, 1);

// Debris
debris_parts[0] = spr_debris_player_1;
debris_parts[1] = spr_debris_player_2;
debris_parts[2] = spr_debris_player_3;
// debris_parts[3] = ... // Cockpit sprite?

// --- Ship Generation ---
segment_distance = 24;
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

        // Create segments using the instance variable 'starting_segments'
        scr_create_ship_segments(starting_segments, segment_distance, obj_ship_segment_player);

        // Check for required forward slots
        _forward_slots_found = 0;
        var _dummy = instance_create_depth(0, 0, 0, obj_module); // Use base module for check
        _dummy.placement_req_above = noone; _dummy.placement_req_left = 1; _dummy.placement_req_right = 1; _dummy.placement_req_below = 1;
        for (var i = 0; i < array_length(ship_segment); i += 1) { if (scr_exists(ship_segment[i]) && ship_segment[i].module == noone && scr_check_module_placement(_dummy, ship_segment[i])) { _forward_slots_found += 1; } }
        instance_destroy(_dummy);

        if (_forward_slots_found >= 2) {
            show_debug_message("Layout OK after " + string(_attempts + 1) + " attempts.");
            break; // Exit loop
        }
        _attempts += 1;
    }

    if (_attempts >= _max_attempts) { show_debug_message("ERROR: Failed to generate player ship with 2 forward slots!"); /* Handle failure? */ }

    // Place Engine(s)
    scr_place_engine_player();

    // Place Weapon in a Forward Slot
    temp_weapon = scr_create_random_starting_gun();
    if (scr_exists(temp_weapon)) {
        temp_weapon.offset_angle = 0; temp_weapon.placement_req_above = noone; temp_weapon.placement_req_left = 1; temp_weapon.placement_req_right = 1; temp_weapon.placement_req_below = 1;
        var valid_slots = scr_find_valid_module_slots(id, temp_weapon);
        if (ds_list_size(valid_slots) > 0) {
            ds_list_shuffle(valid_slots);
            var index = valid_slots[| 0];
            ship_segment[index].module = temp_weapon; temp_weapon.owner = id; temp_weapon.ship_segment = ship_segment[index]; weapon_placed = true;
        }
        ds_list_destroy(valid_slots);
        if (!weapon_placed) { instance_destroy(temp_weapon); show_debug_message("WARN: Couldn't place weapon despite finding >=2 forward slots!"); }
    }

    // Place Cockpit in a DIFFERENT Forward Slot
    if (weapon_placed) {
        var temp_cockpit_obj = choose(obj_module_cockpit_1, obj_module_cockpit_2, obj_module_cockpit_3, obj_module_cockpit_4, obj_module_cockpit_5);
        temp_cockpit = instance_create_depth(0, 0, -10, temp_cockpit_obj);
        if (scr_exists(temp_cockpit)) {
            temp_cockpit.placement_req_above = noone; temp_cockpit.placement_req_left = 1; temp_cockpit.placement_req_right = 1; temp_cockpit.placement_req_below = 1;
            var valid_slots = scr_find_valid_module_slots(id, temp_cockpit); // Finds *remaining* valid slots
            if (ds_list_size(valid_slots) > 0) {
                ds_list_shuffle(valid_slots);
                var index = valid_slots[| 0];
                ship_segment[index].module = temp_cockpit; temp_cockpit.owner = id; temp_cockpit.ship_segment = ship_segment[index]; cockpit_placed = true;
            }
            ds_list_destroy(valid_slots);
            if (!cockpit_placed) { instance_destroy(temp_cockpit); show_debug_message("WARN: Couldn't place cockpit despite finding >=2 forward slots!"); }
        }
    }
    // --- End Guarantee Logic ---

} else {
    // --- Logic that DOESN'T Guarantee Gun ---
    show_debug_message("Attempting to generate player ship layout (Best Effort Gun)...");

    // Create segments using the instance variable 'starting_segments'
    scr_create_ship_segments(starting_segments, segment_distance, obj_ship_segment_player);

    // Place Engine(s)
    scr_place_engine_player();

    // Place Cockpit (using simple slot finding)
    var temp_cockpit_obj = choose(obj_module_cockpit_1, obj_module_cockpit_2, obj_module_cockpit_3, obj_module_cockpit_4, obj_module_cockpit_5);
    temp_cockpit = instance_create_depth(0, 0, -10, temp_cockpit_obj);
    if (scr_exists(temp_cockpit)) {
        var valid_slots = scr_find_valid_module_slots(id, temp_cockpit);
        if (ds_list_size(valid_slots) > 0) {
            ds_list_shuffle(valid_slots);
            var index = valid_slots[| 0];
            ship_segment[index].module = temp_cockpit; temp_cockpit.owner = id; temp_cockpit.ship_segment = ship_segment[index]; cockpit_placed = true;
        }
        ds_list_destroy(valid_slots);
        if (!cockpit_placed) { instance_destroy(temp_cockpit); }
    }

    // Place Weapon (using simple slot finding - might fail)
    temp_weapon = scr_create_random_starting_gun();
    if (scr_exists(temp_weapon)) {
        // Set desired forward placement, but don't require it
        temp_weapon.offset_angle = 0; temp_weapon.placement_req_above = noone; temp_weapon.placement_req_left = 1; temp_weapon.placement_req_right = 1; temp_weapon.placement_req_below = 1;

        var valid_slots = scr_find_valid_module_slots(id, temp_weapon);
        if (ds_list_size(valid_slots) > 0) {
            ds_list_shuffle(valid_slots);
            var index = valid_slots[| 0];
            ship_segment[index].module = temp_weapon; temp_weapon.owner = id; temp_weapon.ship_segment = ship_segment[index]; weapon_placed = true;
        }
        ds_list_destroy(valid_slots);

        if (!weapon_placed) {
            instance_destroy(temp_weapon);
            show_debug_message("NOTE: Could not place starting weapon (guarantee was off).");
        }
    }
    // --- End Best Effort Logic ---
} // End if/else (guarantee_forward_facing_starting_gun)


// --- Final Update & Joint Creation (Runs for both cases) ---
scr_ship_update_segments(id, segment_distance);

for (var i = 0; i < array_length(ship_segment); i += 1) {
    if (scr_exists(ship_segment[i])) {
        ship_segment[i].owner = id;
        ship_segment[i].persistent = true;
        ship_segment[i].visible = true;

        ship_segment[i].placement_angle = point_direction(phy_position_x, phy_position_y, ship_segment[i].phy_position_x, ship_segment[i].phy_position_y);
        ship_segment[i].placement_distance = point_distance(phy_position_x, phy_position_y, ship_segment[i].phy_position_x, ship_segment[i].phy_position_y);

        if (scr_exists(ship_segment[i].module)) {
            var _module = ship_segment[i].module;
            _module.owner = id;
            _module.persistent = true;
            _module.visible = true;
            _module.phy_position_x = ship_segment[i].phy_position_x;
            _module.phy_position_y = ship_segment[i].phy_position_y;
            _module.phy_rotation = -phy_rotation + _module.offset_angle;
            if (_module.joint == noone) {
                _module.joint = physics_joint_revolute_create(ship_segment[i], _module, _module.phy_position_x, _module.phy_position_y, 0, 360, 0, 10, 0, 1, 0);
            }
        }
        // Weld joint for segment itself (assuming scr_ship_update_segments does this?)
        // if (ship_segment[i].joint == noone) {
        //    ship_segment[i].joint = physics_joint_weld_create(id, ship_segment[i], ship_segment[i].phy_position_x,ship_segment[i].phy_position_y,0, 10000, 10000,false);
        // }
    }
}

// Update max health based on final number of segments
max_health_base = array_length(ship_segment) * 10; // Adjust base health per segment if needed
max_health = (max_health_base + max_health_bonus) * max_health_multiplier;
obj_health = max_health; // Start at full health
obj_health_old = obj_health;
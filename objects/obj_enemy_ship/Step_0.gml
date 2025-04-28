// =============================================================================
// Step Event Start
// Current time: Saturday, April 26, 2025 at 12:34:08 PM CEST
// =============================================================================

// =============================================================================
// Timers & Variables Update
// =============================================================================

timer += 1; // General purpose timer

// Calculate potentially modified stats
max_speed = (max_speed_base * max_speed_multiplier) + max_speed_bonus;
rotation_speed = (rotation_speed_base * rotation_speed_multiplier) + rotation_speed_bonus;
max_health = (max_health_base * max_health_multiplier) + max_health_bonus;
max_energy = (max_energy_base * max_energy_multiplier) + max_energy_bonus;
energy_increase = (energy_increase_base * energy_increase_multiplier) + energy_increase_bonus;

// Status Effect Timers
disabled_timer -= 1;
if (disabled_timer < 0) { disabled_timer = 0; }
controls_disabled = (disabled_timer > 0);

ai_disabled_timer -= 1;
if (ai_disabled_timer < 0) { ai_disabled_timer = 0; }

hit_invulnerable_timer = max(0, hit_invulnerable_timer - 1);

// =============================================================================
// Health & Destruction
// =============================================================================

if (obj_health <= 0) {
    phy_active = false;
    audio_stop_sound(engine_noise);

    scr_explode_ship();
    // Destroy attached modules and segments using scr_exists
    for (var i = 0; i < array_length_1d(ship_segment); i += 1;) { // Using array_length_1d
        if (scr_exists(ship_segment[i])) {
            if (scr_exists(ship_segment[i].module)) {
                 instance_destroy(ship_segment[i].module);
            }
            instance_destroy(ship_segment[i]);
        }
    }
    audio_emitter_free(ship_audio_emitter);

    scr_create_pickups_after_death(obj_pickup_credit, pickup_objects_credits);
    scr_create_pickups_after_death(obj_pickup_health, pickup_objects_health);
    scr_create_pickups_after_death(obj_pickup_particles, pickup_objects_particles);
    scr_create_explosion_medium(phy_position_x, phy_position_y);

    // Update player score/stats if killed by player
    if (scr_exists(the_one_that_killed_me) && the_one_that_killed_me == obj_player) {
        obj_player.enemies_killed += 1;
        global.total_kills += 1;
    }

    instance_destroy();
    exit; // Stop executing further code in this step event
}

// =============================================================================
// Health Bar Management
// =============================================================================

if (obj_health < old_obj_health) {
    health_bar_timer = 180;
}

if (health_bar_timer > 0) {
    health_bar_x = phy_position_x;
    health_bar_y = phy_position_y - 80;
    health_bar_height = 8;
    health_bar_width = 36;
    health_bar_timer -= 1;
}
old_obj_health = obj_health;

// =============================================================================
// AI Logic (State Machine with Improved Avoidance)
// =============================================================================

var _is_avoiding = false; // Flag to check if avoidance is active this step
var _avoid_target_dir = 0; // Direction determined by avoidance logic IF active
// Note: _avoid_target_speed is conceptual; we set add_thrust directly for avoidance

// Initialize movement targets and throttle intent
target_dir = -phy_rotation; // Default aim forward if no other logic applies
target_speed = 0;           // Conceptual target speed (used by states)
add_thrust = 0;             // AI's desired throttle (0 to 1) - Default to 0

if (ai_disabled_timer <= 0 && !controls_disabled) { // Only run AI if active and controls enabled

    // --- Target Acquisition ---
    if (timer mod 30 == 0) {
        target = noone;
        target = scr_rocket_find_target_in_arc(target_objects[0], -phy_rotation, targeting_arc, seek_range);
        if (target == noone) {
            target = scr_rocket_find_target_in_arc(target_objects[1], -phy_rotation, targeting_arc, seek_range);
        }
        if (scr_exists(target) && target.invisible) {
             target = noone;
        }
    }

    // --- High-Priority State Transitions ---
    state_timer -= 1;
    // Flee Check
    if (obj_health / max_health < flee_health_threshold) {
        if (ai_state != ENEMY_STATE.FLEE) {
            // show_debug_message("Switching to FLEE state (Low Health)");
            ai_state = ENEMY_STATE.FLEE;
            state_timer = 120;
        }
    }
    // Evade Check
    else if (recently_hit && ai_state != ENEMY_STATE.FLEE) {
        if (ai_state != ENEMY_STATE.EVADE) {
             // show_debug_message("Switching to EVADE state (Hit)");
             ai_state = ENEMY_STATE.EVADE;
             state_timer = evade_duration;
        }
        recently_hit = false;
    }

    // --- Collision Avoidance Check (Improved Asteroid Dodging) ---
    if (timer mod avoid_check_frequency == 0) { // Check periodically

        // Define feeler end points relative to the ship
        var _ship_dir = -phy_rotation;
        var _feeler_x_fwd = phy_position_x + lengthdir_x(avoid_feeler_length, _ship_dir);
        var _feeler_y_fwd = phy_position_y + lengthdir_y(avoid_feeler_length, _ship_dir);
        var _feeler_x_left = phy_position_x + lengthdir_x(avoid_feeler_length * 0.8, _ship_dir + avoid_feeler_angle);
        var _feeler_y_left = phy_position_y + lengthdir_y(avoid_feeler_length * 0.8, _ship_dir + avoid_feeler_angle);
        var _feeler_x_right = phy_position_x + lengthdir_x(avoid_feeler_length * 0.8, _ship_dir - avoid_feeler_angle);
        var _feeler_y_right = phy_position_y + lengthdir_y(avoid_feeler_length * 0.8, _ship_dir - avoid_feeler_angle);

        // Check for asteroids along the feeler paths
        var _hit_fwd = collision_line(phy_position_x, phy_position_y, _feeler_x_fwd, _feeler_y_fwd, obj_asteroid, false, true);
        var _hit_left = collision_line(phy_position_x, phy_position_y, _feeler_x_left, _feeler_y_left, obj_asteroid, false, true);
        var _hit_right = collision_line(phy_position_x, phy_position_y, _feeler_x_right, _feeler_y_right, obj_asteroid, false, true);

        // Calculate avoidance steering adjustment for asteroids
        var _avoid_steer_adjust = 0;
        if (_hit_fwd != noone) {
            _avoid_steer_adjust = choose(1, -1) * avoid_steer_strength * 1.5; // Strong turn
        } else {
            if (_hit_left != noone) { _avoid_steer_adjust -= avoid_steer_strength; } // Steer right
            if (_hit_right != noone) { _avoid_steer_adjust += avoid_steer_strength; } // Steer left
        }

        // If avoiding asteroid, set avoidance flag and targets
        if (_avoid_steer_adjust != 0) {
            _is_avoiding = true;
            _avoid_target_dir = target_dir + _avoid_steer_adjust; // Adjust current direction
            // _avoid_target_speed = max_speed * 0.75; // Conceptual speed for avoidance
            add_thrust = 0.75; // Set throttle directly for avoidance
        }

        // --- Teammate Avoidance Check (Only if not avoiding asteroid) ---
        if (!_is_avoiding) {
            var _collision_check_distance_t = 140;
            var _collision_check_radius_t = 75;
            var _closest_teammate = collision_circle(phy_position_x + lengthdir_x(_collision_check_distance_t, _ship_dir),
                                                     phy_position_y + lengthdir_y(_collision_check_distance_t, _ship_dir),
                                                     _collision_check_radius_t, obj_enemy_ship, false, true);
            if (scr_exists(_closest_teammate) && _closest_teammate != id) {
                var _avoid_dir_t = point_direction(phy_position_x, phy_position_y, _closest_teammate.phy_position_x, _closest_teammate.phy_position_y);
                if (angle_difference(_ship_dir, _avoid_dir_t) > 0) { _avoid_target_dir = _avoid_dir_t + 90; } else { _avoid_target_dir = _avoid_dir_t - 90; }
                // _avoid_target_speed = max_speed * 0.5; // Conceptual speed
                _is_avoiding = true; // Set flag to use avoidance targets
                add_thrust = 0.5; // Set throttle directly for teammate avoidance
            }
        }
    } // End of periodic avoidance check

    // --- Determine Final Direction and Throttle based on State/Avoidance ---
    if (_is_avoiding) {
        // If avoiding, use direction/throttle from the avoidance logic block above
        target_dir = _avoid_target_dir;
        // add_thrust was already set by the specific avoidance logic (asteroid or teammate)

    } else {
        // If not avoiding, run the state machine to determine actions and set target_dir / add_thrust
        switch (ai_state) {

            case ENEMY_STATE.IDLE:
                target_speed = max_speed * 0.4;
                add_thrust = 0.4; // Set throttle for wandering
                if (scr_exists(target)) {
                    ai_state = ENEMY_STATE.ATTACK; state_timer = 0; break;
                }
                if (state_timer <= 0) {
                    target_dir = random(360);
                    state_timer = irandom_range(idle_wander_timer_min, idle_wander_timer_max);
                }
                break;

            case ENEMY_STATE.ATTACK:
                // Transition: If target lost, switch back to IDLE
                if (!scr_exists(target)) {
                    // show_debug_message("ATTACK -> IDLE (Target Lost)");
                    ai_state = ENEMY_STATE.IDLE;
                    state_timer = irandom_range(idle_wander_timer_min, idle_wander_timer_max);
                    break; // Exit switch
                }

                // --- Calculate Target Info ---
                var target_point_x = scr_wrap_closest_x(target);
                var target_point_y = scr_wrap_closest_y(target);
                var _dir_to_target = point_direction(phy_position_x, phy_position_y, target_point_x, target_point_y);
                var _target_dist = scr_wrap_distance_to_point(phy_position_x, phy_position_y, target.phy_position_x, target.phy_position_y);

                // --- Maneuvering Logic ---
                if (_target_dist > attack_close_distance) {
                    // --- Far Distance: Approach ---
                    // Calculate intercept course
                    var _intercept_dir = scr_wrap_intercept_course_new(id, target, phy_speed);
                    if (_intercept_dir != -1) { target_dir = _intercept_dir; }
                    else { target_dir = _dir_to_target; } // Fallback: aim directly
                    add_thrust = 1.0; // Full throttle approach
                    // show_debug_message("ATTACK: Approaching");

                } else {
                    // --- Close Distance: Find Easiest Gun to Align ---
                    var min_abs_error = 361; // Start higher than max possible angle diff (180)
                    var best_gun_target_dir = -1; // Ship direction needed for the best gun found so far
                    var found_suitable_gun = false;

                    // Evaluate each gun module
                    for (var i = 0; i < array_length_1d(ship_segment); i += 1;) {
                        if (scr_exists(ship_segment[i]) && scr_exists(ship_segment[i].module)) {
                            var _module = ship_segment[i].module;
                            if (object_is_ancestor(_module.object_index, obj_module_gun)) {
                                // Get this gun's offset angle relative to ship's forward
                                var _gun_offset_angle = _module.offset_angle; // Assumes module has this variable

                                // Calculate the raw desired angle
								var _desired_ship_orientation_for_gun = _dir_to_target - _gun_offset_angle;

								// Normalize the angle to be within 0-359.9 degrees
								while (_desired_ship_orientation_for_gun >= 360) { _desired_ship_orientation_for_gun -= 360; }
								while (_desired_ship_orientation_for_gun < 0) { _desired_ship_orientation_for_gun += 360; }

                                // Calculate how much the ship needs to turn from its current orientation
                                var _orientation_error = angle_difference(-phy_rotation, _desired_ship_orientation_for_gun);
                                var _abs_error = abs(_orientation_error);

                                // Check if this gun is better (requires less turning) than the best found so far
                                if (_abs_error < min_abs_error) {
                                     // Optional: Check if target is within this gun's range *before* selecting it?
                                     // var _dist_to_target_for_gun = point_distance(module.x, module.y, target_point_x, target_point_y); // Approximate
                                     // if (_dist_to_target_for_gun <= _module.bullet_range) {
                                        min_abs_error = _abs_error;
                                        best_gun_target_dir = _desired_ship_orientation_for_gun;
                                        found_suitable_gun = true;
                                     // }
                                }
                            }
                        }
                    } // End of gun evaluation loop

                    // Set ship's movement based on the best gun found
                    if (found_suitable_gun) {
                        target_dir = best_gun_target_dir; // Aim to align the best gun
                        // Set throttle based on how much turning is needed
                        add_thrust = (min_abs_error > 25) ? 0.2 : 0.6; // Low throttle if turning > 25deg, moderate otherwise for maneuvering
                        // show_debug_message("ATTACK: Aligning best gun (Error: " + string(min_abs_error) + ")");
                    } else {
                        // Fallback: No suitable gun found (or no guns attached)
                        // Default to just facing the target directly and holding position
                        target_dir = _dir_to_target;
                        add_thrust = 0.1;
                        // show_debug_message("ATTACK: No suitable gun angle, facing target");
                    }
                } // End close-range logic

                // --- Shooting Logic (Corrected Arguments & Conditions) ---
                var _shoot_target_arc = 30; // Define arc width for gun check
                for (var i = 0; i < array_length_1d(ship_segment); i += 1;) {
                     if (scr_exists(ship_segment[i]) && scr_exists(ship_segment[i].module)) {
                        var _module = ship_segment[i].module;

                        // Check if it's a gun AND if it's ready/enabled
                        if (object_is_ancestor(_module.object_index, obj_module_gun) &&
                            _module.ready_to_shoot && // Is the gun ready?
                            !_module.activation_timer && // Is it not already activating?
                            !controls_disabled) {       // Are controls enabled?

                            // Check periodically for a target in the gun's specific arc
                            if (timer mod 20 == 0) {

                                // Check bullet_range validity before using it
                                if (!is_undefined(_module.bullet_range)) {

                                    // *** CORRECTED SCRIPT CALLS with actual arguments ***
                                    var _gun_target = scr_rocket_find_target_in_arc(
                                        object_get_name(target_objects[0]),  // Arg0: Target Name String
                                        -_module.phy_rotation,               // Arg1: Module Angle
                                        _shoot_target_arc,                   // Arg2: Arc Width
                                        _module.bullet_range * 1.5           // Arg3: Range Check
                                    );

                                    if (_gun_target == noone && array_length(target_objects) > 1) { // Check second target type if first failed
                                        _gun_target = scr_rocket_find_target_in_arc(
                                            object_get_name(target_objects[1]),  // Arg0: Target Name String
                                            -_module.phy_rotation,               // Arg1: Module Angle
                                            _shoot_target_arc,                   // Arg2: Arc Width
                                            _module.bullet_range * 1.5           // Arg3: Range Check
                                        );
                                    }

                                    // Fire if the gun found any valid, visible target in its arc
                                    if (scr_exists(_gun_target) && !_gun_target.invisible) {
                                         _module.activation_timer = 30; // Activate gun
                                         // show_debug_message("ATTACK: Firing Gun at instance " + string(_gun_target));
                                    }
                                } else {
                                     // Safety message if bullet_range was somehow still undefined
                                     show_debug_message("WARNING: _module.bullet_range is undefined for module ID " + string(_module.id));
                                }
                            } // End timer mod check
                        } // End gun check & conditions
                     } // End module exists check
                 } // End for loop
                 // --- End Shooting Logic ---
				 break;

            case ENEMY_STATE.EVADE:
                add_thrust = 1.0; // Evasion throttle
                if (timer mod 15 == 0) { target_dir = -phy_rotation + choose(-1, 1) * irandom_range(60, 120); }
                if (state_timer <= 0) { /* ... transition logic ... */ }
                break;

            case ENEMY_STATE.FLEE:
                add_thrust = 1.0; // Flee throttle
                if (scr_exists(target)) { target_dir = point_direction(target.x, target.y, phy_position_x, phy_position_y); }
                else { if (state_timer mod 60 == 0) { target_dir = random(360); } }
                if (state_timer <= 0) { /* ... transition logic ... */ }
                break;

        } // End switch(ai_state)
    } // End if (!_is_avoiding) else

} else { // AI or Controls are disabled
    add_thrust = 0; // Set throttle to zero if disabled
    target_dir = -phy_rotation; // Aim forward
    // target_speed = 0; // Conceptual speed
}


// =============================================================================
// Movement Execution (Physics - Rotation Only)
// =============================================================================

// --- Rotation --- (Handled by main ship body based on final target_dir)
if (!controls_disabled) {
    var angle_diff = angle_difference(-phy_rotation, target_dir);
    var rotation_value = clamp(angle_diff / 20, -1, 1);
    if (abs(phy_angular_velocity) < rotation_speed) {
        physics_apply_torque(array_length_1d(ship_segment) * rotation_force * rotation_value);
        phy_angular_damping = 2 + 10 * add_thrust; // Simplified damping
    } else {
        phy_angular_damping = 30;
    }
} else {
     phy_angular_damping = 4;
}

// --- Counter lateral drift --- (Keep or remove depending on how it works)
if (!controls_disabled && add_thrust > 0) {
     scr_counter_lateral_drift();
}


// =============================================================================
// Pass Throttle Intent to Engine Modules
// =============================================================================

// Override throttle if ship is already at or above max speed
if (phy_speed >= max_speed) {
    add_thrust = 0; // Command zero thrust regardless of AI state's desire
    // show_debug_message("Speed limit reached, overriding thrust to 0");
}

// Pass the final calculated 'add_thrust' to engine modules
for (var i = 0; i < array_length_1d(ship_segment); i += 1;) {
    if (scr_exists(ship_segment[i]) && scr_exists(ship_segment[i].module)) {
        var _module = ship_segment[i].module;
        if (object_is_ancestor(_module.object_index, obj_module_engine)) {
             _module.throttle_input = add_thrust;
        }
    }
}

// =============================================================================
// Energy Management
// =============================================================================

if (energy < max_energy) { energy += energy_increase; }
if (energy > max_energy) { energy = max_energy; }

// =============================================================================
// Sound Management
// =============================================================================

audio_emitter_position(ship_audio_emitter, phy_position_x, phy_position_y, 0);

// =============================================================================
// Module/Segment Ownership & Visibility (Final Check)
// =============================================================================

for (var i = 0; i < array_length_1d(ship_segment); i += 1;) {
    if (scr_exists(ship_segment[i])) {
        ship_segment[i].owner = id;
        ship_segment[i].persistent = false;
        ship_segment[i].visible = true;
        if (ship_segment[i].module != noone) {
            ship_segment[i].module.owner = id;
            ship_segment[i].module.persistent = false;
            ship_segment[i].module.visible = true;
        }
    }
}

// =============================================================================
// Step Event End
// =============================================================================
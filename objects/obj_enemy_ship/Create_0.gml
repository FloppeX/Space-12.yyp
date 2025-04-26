// Timer

timer = 0

//credits = irandom(5)+1
pickup_objects = 1//+irandom(global.difficulty_level)
pickup_objects_credits = 1//irandom(1)
pickup_objects_health = irandom(1)
pickup_objects_particles = irandom(1)
// Stats variables, for keeping track of stuff

the_one_that_killed_me = noone
// Segments

ship_segment[0] = noone

// Ship properties

mirror_x = 0
mirror_y = 0

draw_scale = 1
alpha = 1

obj_rotation = 0

max_health = 20
obj_health = 20
old_obj_health = 20
health_bar_timer = 0

invisible = false

// Luck

luck = 1

// Energy

max_energy = 100;
energy = max_energy;
energy_increase = 1;

max_particles = 100;
particles = max_particles;

disabled_timer = 0
controls_disabled = false

target_speed = 0
max_speed = 5
thrust = 0
max_thrust = 360
add_thrust = 0

// Changeable ship variables

max_speed_base = 2.8
max_speed_multiplier = 0 
max_speed_bonus = 0

rotation_speed_base = 60
rotation_speed_multiplier = 1 
rotation_speed_bonus = 0

max_health_base = 100 
max_health_multiplier = 1
max_health_bonus = 0

max_energy_base = 100
max_energy_multiplier = 1
max_energy_bonus = 0

max_particles_base = 100
max_particles_multiplier = 1
max_particles_bonus = 0

energy_increase_base = 0.5;
energy_increase_multiplier = 1
energy_increase_bonus = 0

///

// Rotating & moving

rotation_force = 100
rotation_value = 0;
add_thrust = 0;

///

max_rotation_speed = 100;
drift_resistance = 14//80;

damage = 4;

ai_mode = 1
ai_disabled_timer = 0
shoot = false
direction_randomizer = 0
abort_attack = false
attack_duration = 300//irandom(480)+240//240
attack_timer = attack_duration
min_standoff_distance = 120 //100
max_standoff_distance = 400

invisible = false

hit_invulnerable_timer = 0

target = noone;
target_objects = [obj_player, obj_enemy_modular_team_2];
// In Create Event, AFTER setting target_objects
show_debug_message("--- Create Event Debug ---");
if (is_array(target_objects)) {
    show_debug_message("target_objects is an array. Length: " + string(array_length(target_objects)));
    if (array_length(target_objects) > 0) show_debug_message("Index 0 Value: " + string(target_objects[0]));
    if (array_length(target_objects) > 1) show_debug_message("Index 1 Value: " + string(target_objects[1]));
} else {
    show_debug_message("target_objects is NOT an array!");
}
// Verify the objects themselves exist in the project
show_debug_message("Checking obj_player exists: " + string(object_exists(obj_player)));
show_debug_message("Checking obj_enemy_modular_team_2 exists: " + string(object_exists(obj_enemy_modular_team_2)));
show_debug_message("--------------------------");

targeting_arc = 360;
seek_range = 1000;
target_dir = 0
angle_diff = 0
ai_timer = 0

closest_obstacle = noone
closest_teammate = noone
avoiding_obstacle = false;


target_point_x = irandom(global.wrap_border_left + global.play_area_width)
target_point_y = irandom(global.wrap_border_left + global.play_area_width)


debris_parts[0] = spr_debris_enemy_interceptor_1
debris_parts[1] = spr_debris_enemy_interceptor_2
debris_parts[2] = spr_debris_enemy_interceptor_3
debris_parts[3] = spr_debris_enemy_interceptor_4


// AI 

// -- AI State Machine Setup --

// Define AI States using an Enum
enum ENEMY_STATE {
    IDLE,    // Wandering, patrolling, looking for target
    ATTACK,  // Actively engaging the target
    EVADE,   // Taking evasive maneuvers when under fire
    FLEE     // Running away when health is low
    // AVOID state could be added if avoidance needs more complex logic than just overriding direction
}

// Initialize AI State Variables
ai_state = ENEMY_STATE.IDLE; // Start in IDLE state
target = noone;              // Current target instance
state_timer = 0;             // Timer for state-specific actions/durations
recently_hit = false;        // Flag set to true by projectiles hitting this ship

// AI Tuning Variables (Adjust these to change behavior)
flee_health_threshold = 0.25; // Flee when health drops below 25% of max_health
evade_duration = 60;         // How long (in steps) to evade after being hit
idle_wander_timer_min = 120; // Min time (steps) between picking new wander directions
idle_wander_timer_max = 240; // Max time (steps) between picking new wander directions
attack_strafe_chance = 0.3;  // 30% chance to decide to strafe instead of approach when close
attack_strafe_duration = 90; // How long (in steps) a strafing maneuver lasts
attack_close_distance = 250; // Distance considered "close" for attack maneuvers (like strafing)

// -- Make sure other necessary variables are initialized --
// max_speed_base, rotation_speed_base, max_health_base, etc.
// attack_duration, min_standoff_distance, max_standoff_distance, targeting_arc, seek_range, etc.
// ship_segment array, thrust_force, rotation_force, etc.
// ship_audio_emitter = audio_emitter_create();
// pickup_objects_credits, pickup_objects_health, etc.

// Asteroid Avoidance Parameters
avoid_feeler_length = 120;     // How far ahead the feelers check
avoid_feeler_angle = 25;       // Angle offset for side feelers (degrees)
avoid_steer_strength = 8;      // How sharply to steer away per step (degrees)
avoid_check_frequency = 5;     // How often to check (e.g., every 5 steps)

// Sounds
sound_priority = 0.5
explosion_sound = snd_explosion_large_02
engine_sound = snd_engine_2
engine_noise = noone

ship_audio_emitter = audio_emitter_create()
audio_emitter_falloff(ship_audio_emitter, 600, 800, 1);
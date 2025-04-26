// @description obj_enemy_ship Create Event: Initializes common properties for all enemy ships.

// Inherit from parent obj_ship if applicable (assuming physics properties etc. are set there)
event_inherited();

// --- Basic State & Timers ---
timer = 0;
obj_health = 100; // Default starting health, usually overridden by child based on segments
max_health_base = 100; // Base value, overridden by child
max_health = max_health_base;
old_obj_health = obj_health;
health_bar_timer = 0;
hit_invulnerable_timer = 0;
disabled_timer = 0;
controls_disabled = false;
ai_disabled_timer = 0;
the_one_that_killed_me = noone;
invisible = false;
alpha = 1;
draw_scale = 1; // Might be set by children?

// --- Ship Structure ---
ship_segment = []; // Initialize as empty array - child objects will populate this

// --- Core Stats (Base values - multipliers/bonuses applied in Step 0) ---
max_speed_base = 2.8;
rotation_speed_base = 60;
drift_resistance_base = 14; // Not present in original enemy create, maybe inherited or player-only?
max_health_base = 10;    // Placeholder - Child MUST set this based on segment count
max_energy_base = 100;
max_particles_base = 100; // Assuming enemies might use particles? Initialize if needed.
energy_increase_base = 0.5;
luck_base = 1;
rotation_force = 100;    // Turning force

// --- Resource Initialization ---
energy = max_energy_base; // Start with full energy
particles = 0;            // Start with zero particles?
// pickup_objects_* define what this ship drops on death
pickup_objects_credits = 1 + irandom(global.difficulty_level div 2); // Example scaling
pickup_objects_health = irandom(1);
pickup_objects_particles = irandom(1);

// --- AI State Machine Initialization ---
// Define States (Enum should be defined globally or in a script for access here)
/* // Enum defined elsewhere or in child? Assuming it exists:
enum ENEMY_STATE { IDLE, ATTACK, EVADE, FLEE }
*/
ai_state = ENEMY_STATE.IDLE; // Start in IDLE state
state_timer = 0;
recently_hit = false;

// AI Tuning Variables
flee_health_threshold = 0.25;
evade_duration = 60;
idle_wander_timer_min = 120;
idle_wander_timer_max = 240;
attack_strafe_chance = 0.3;
attack_strafe_duration = 90;
attack_close_distance = 250;
attack_duration = 300 + irandom(180); // Base duration for an attack cycle
attack_timer = attack_duration;
min_standoff_distance = 120; // Used by older AI mode, maybe useful for states?
max_standoff_distance = 400; // Used by older AI mode

// Asteroid Avoidance Parameters
avoid_feeler_length = 120;
avoid_feeler_angle = 25;
avoid_steer_strength = 8;
avoid_check_frequency = 5;

// --- Targeting ---
target = noone;
// Ensure target_objects is initialized correctly!
// This MUST contain valid object IDs present in your Asset Browser
target_objects = [obj_player, obj_enemy_modular_team_2];
targeting_arc = 360; // Initial broad targeting arc?
seek_range = 1000;
target_dir = 0; // Initial direction
target_speed = 0; // Initial conceptual speed
target_point_x = phy_position_x + irandom_range(-500, 500); // Initial wander target?
target_point_y = phy_position_y + irandom_range(-500, 500);

// --- Graphics / Effects ---
debris_parts = [spr_debris_enemy_interceptor_1, spr_debris_enemy_interceptor_2, spr_debris_enemy_interceptor_3, spr_debris_enemy_interceptor_4]; // Example debris

// --- Sound ---
sound_priority = 0.5; // Lower priority than player?
explosion_sound = snd_explosion_large_01; // More appropriate default? Child can override.
engine_sound = snd_engine_1b;         // Default enemy engine sound? Child can override.
engine_noise = noone; // Handle for engine sound instance
ship_audio_emitter = audio_emitter_create();
audio_emitter_falloff(ship_audio_emitter, 600, 800, 1); // Enemy falloff range

// --- Debug/Legacy AI Variables (Can likely remove if fully using state machine) ---
// ai_mode = 1; // Replaced by ai_state
// direction_randomizer = 0;
// abort_attack = false;
// closest_obstacle = noone;
// closest_teammate = noone;
// avoiding_obstacle = false;

// --- Final Multiplier/Bonus Init (These are reset in Step 2) ---
max_speed_multiplier = 1; max_speed_bonus = 0;
rotation_speed_multiplier = 1; rotation_speed_bonus = 0;
drift_resistance_multiplier = 1; drift_resistance_bonus = 0; // If needed
max_health_multiplier = 1; max_health_bonus = 0;
max_energy_multiplier = 1; max_energy_bonus = 0;
max_particles_multiplier = 1; max_particles_bonus = 0;
energy_increase_multiplier = 1; energy_increase_bonus = 0;
luck_multiplier = 1; luck_bonus = 0;

drift_resistance = (drift_resistance_base * drift_resistance_multiplier) + drift_resistance_bonus;

// Run debug checks if needed (copied from original enemy create)
show_debug_message("--- Create Event Debug ---");
if (is_array(target_objects)) { /* ... debug checks from before ... */ } else { show_debug_message("target_objects is NOT an array!"); }
show_debug_message("Checking obj_player exists: " + string(object_exists(obj_player)));
show_debug_message("Checking obj_enemy_modular_team_2 exists: " + string(object_exists(obj_enemy_modular_team_2)));
show_debug_message("--------------------------");
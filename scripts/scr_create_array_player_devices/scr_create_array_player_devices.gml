function scr_create_array_player_devices() {
	// Gun arrays

	global.array_player_devices = []
	var module_number,module_id,module_type,credit_cost,module_rarity;
	// 0 = gun, 1 = device, 2 = crew

	module_number = 0

	module_id = obj_module_engine_player
	module_type = 0
	credit_cost = 5
	module_rarity = 16
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 1

	module_id = obj_module_rotational_thrusters
	module_type = 0
	credit_cost = 3
	module_rarity = 12
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 2

	module_id = obj_module_patchwork_plating
	module_type = 0
	credit_cost = 2
	module_rarity = 12
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 3

	module_id = obj_module_sawblade_player
	module_type = 0
	credit_cost = 6
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 4

	module_id = obj_module_shield_player
	module_type = 0
	credit_cost = 8
	module_rarity = 12
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 5

	module_id = obj_module_force_shield_player
	module_type = 0
	credit_cost = 10
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 6

	module_id = obj_module_reflective_shield_player
	module_type = 0
	credit_cost = 10
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 7

	module_id = obj_module_cloaking_device
	module_type = 0
	credit_cost = 12
	module_rarity = 50
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 8

	module_id = obj_module_teleporter
	module_type = 0
	credit_cost = 12
	module_rarity = 1
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 9

	module_id = obj_module_gravity_shield
	module_type = 0
	credit_cost = 12
	module_rarity = 2
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 10

	module_id = obj_module_hyperkinetic_ammo
	module_type = 0
	credit_cost = 8
	module_rarity = 6
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 11

	module_id = obj_module_high_octane_plasma
	module_type = 0
	credit_cost = 8
	module_rarity = 6
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 12

	module_id = obj_module_deaths_head
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 13

	module_id = obj_module_biomechanical_actuator
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 14

	module_id = obj_module_fluxative_reactor
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 15

	module_id = obj_module_epicyclic_capacitors
	module_type = 0
	credit_cost = 6
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 16

	module_id = obj_module_cryostatic_capacitors
	module_type = 0
	credit_cost = 8
	module_rarity = 6
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 17

	module_id = obj_module_heliophotonic_panel
	module_type = 0
	credit_cost = 6
	module_rarity = 12
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 18
	
	module_id = obj_module_spectrocoil_reactor
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 19
	
	module_id = obj_module_thermodynamic_damper
	module_type = 0
	credit_cost = 8
	module_rarity = 6
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 20
	
	module_id = obj_module_gravitational_modulator
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 21
	
	module_id = obj_module_turbo_encabulator
	module_type = 0
	credit_cost = 8
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 22
	
	module_id = obj_module_particle_bay
	module_type = 0
	credit_cost = 6
	module_rarity = 6
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 23
	
	module_id = obj_module_plasmonic_uranium_ammo
	module_type = 0
	credit_cost = 8
	module_rarity = 6
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 24
	
	module_id = obj_module_quantum_phase_reactor
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 25
	
	module_id = obj_module_match_grade_ammo
	module_type = 0
	credit_cost = 6
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity

	module_number = 26

	module_id = obj_module_autonomus_targeting_array
	module_type = 0
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 27

	module_id = obj_module_traction_control_system
	credit_cost = 8
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 28

	module_id = obj_module_engine_rotation_relay
	credit_cost = 6
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 29

	module_id = obj_module_autoshooter
	credit_cost = 6
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 30

	module_id = obj_module_engine_small
	credit_cost = 4
	module_rarity = 10
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 31

	module_id = obj_module_engine_big
	credit_cost = 4
	module_rarity = 8
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 32

	module_id = obj_module_ion_engine
	credit_cost = 4
	module_rarity = 4
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
	module_number = 33

	module_id = obj_module_engine_junk
	credit_cost = 4
	module_rarity = 40
	global.array_player_devices[module_number,0] = module_id
	global.array_player_devices[module_number,1] = module_type
	global.array_player_devices[module_number,2] = credit_cost
	global.array_player_devices[module_number,3] = module_rarity
	
}
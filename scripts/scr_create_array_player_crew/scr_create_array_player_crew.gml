function scr_create_array_player_crew() {
	// Gun arrays

	global.array_player_crew = []
	var crew_number,crew_id,crew_cost,crew_rarity;
	// 0 = gun, 1 = device, 2 = crew

	crew_number = 0

	crew_id = obj_crew_token_brawler
	crew_cost = 10
	crew_rarity = 16
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 1

	crew_id = obj_crew_token_outlaw
	crew_cost = 10
	crew_rarity = 12
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 2

	crew_id = obj_crew_token_mystic_manipulator
	crew_cost = 10
	crew_rarity = 12
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 3

	crew_id = obj_crew_token_arachnoid_harvester
	crew_cost = 10
	crew_rarity = 8
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 4

	crew_id = obj_crew_token_bloodsucker
	crew_cost = 10
	crew_rarity = 12
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity
	crew_number = 5

	crew_id = obj_crew_token_freebooter
	crew_cost = 10
	crew_rarity = 8
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 6

	crew_id = obj_crew_token_mechanoid_gunsmith
	crew_cost = 10
	crew_rarity = 8
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 7

	crew_id = obj_crew_token_rock_man
	crew_cost = 10
	crew_rarity = 1
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 8

	crew_id = obj_crew_token_mechanoid_lovebot
	crew_cost = 10
	crew_rarity = 1
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity

	crew_number = 9

	crew_id = obj_crew_token_ratling_tailgunner
	crew_cost = 10
	crew_rarity = 2
	global.array_player_crew[crew_number,0] = crew_id
	global.array_player_crew[crew_number,1] = crew_cost
	global.array_player_crew[crew_number,2] = crew_rarity
	
}
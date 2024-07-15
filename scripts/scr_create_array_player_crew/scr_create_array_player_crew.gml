function scr_create_array_player_crew() {
	
	global.array_player_crew[0] = obj_crew_token_brawler
	global.array_player_crew[1] = obj_crew_token_outlaw
	global.array_player_crew[2] = obj_crew_token_mystic_manipulator
	global.array_player_crew[3] = obj_crew_token_arachnoid_harvester
	global.array_player_crew[4] = obj_crew_token_bloodsucker
	global.array_player_crew[5] = obj_crew_token_freebooter
	global.array_player_crew[6] = obj_crew_token_mechanoid_gunsmith
	global.array_player_crew[7] = obj_crew_token_rock_man
	global.array_player_crew[8] = obj_crew_token_mechanoid_lovebot
	global.array_player_crew[9] = obj_crew_token_uzok_tailgunner
	global.array_player_crew[10] = obj_crew_token_battle_hardened_crusader
	global.array_player_crew[11] = obj_crew_token_psychic_leech
	global.array_player_crew[12] = obj_crew_token_combat_repair_bot
	global.array_player_crew[13] = obj_crew_token_hot_shot_pilot
	global.array_player_crew[14] = obj_crew_token_slurpy_the_dog
	global.array_player_crew[15] = obj_crew_token_brain_in_a_jar
	global.array_player_crew[16] = obj_crew_token_corvid_illusionist
	global.array_player_crew[17] = obj_crew_token_ancient_astronaut

	scr_shuffle_array(global.array_player_crew)
}
function scr_create_random_crew() {
	temp_crew = noone

	if array_length(global.array_player_crew) >= 1{
		temp_crew = instance_create_depth(0,0,-10,array_shift(global.array_player_crew));
		return temp_crew
	}
	else 
		return noone
}

/*
global.array_player_crew[i,0] = noone
for(var p = array_length(global.array_player_crew)-1;p >= 0;p -= 1)
	if global.array_player_crew[p,0] == noone
		array_delete(global.array_player_crew,p,1)
*/

	/*
	
	var h = irandom(10)
		switch (h){
			case 0: temp_module = instance_create_depth(0,0,-10,obj_crew_ratling_gunner);break;
			case 1: temp_module = instance_create_depth(0,0,-10,obj_crew_telekinetic_gunner);break;
			case 2: temp_module = instance_create_depth(0,0,-10,obj_crew_bloodsucker);break;
			case 3: temp_module = instance_create_depth(0,0,-10,obj_crew_outlaw);break;
			case 4: temp_module = instance_create_depth(0,0,-10,obj_crew_rock_man);break;
			case 5: temp_module = instance_create_depth(0,0,-10,obj_crew_arachnoid_harvester);break;
			case 6: temp_module = instance_create_depth(0,0,-10,obj_crew_mechanoid_gunsmith);break;
			case 7: temp_module = instance_create_depth(0,0,-10,obj_crew_mechanoid_lovebot);break;
			case 8: temp_module = instance_create_depth(0,0,-10,obj_crew_squidface_geologist);break;
			case 9: temp_module = instance_create_depth(0,0,-10,obj_crew_mechanoid_prospector);break;
			case 10: temp_module = instance_create_depth(0,0,-10,obj_crew_token_brawler);break;
			}
	temp_module.cost = round(0.75 * temp_module.cost + random(0.5)*temp_module.cost)
	return temp_module;



}

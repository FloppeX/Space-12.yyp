function scr_create_random_enemy_2_cockpit() {
	var h = irandom(1)
		switch (h){
			case 0: temp_module = instance_create_depth(0,0,-10,obj_module_enemy_cockpit_1_team_2); break;
			case 1: temp_module = instance_create_depth(0,0,-10,obj_module_enemy_cockpit_2_team_2); break;
			}
	
	return temp_module;



}

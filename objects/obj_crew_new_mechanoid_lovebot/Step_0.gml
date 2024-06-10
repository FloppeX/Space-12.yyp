event_inherited();

if scr_timer(60) // Check every second
	with(owner){
		
		var range = 300
		var closest_distance = range
		var temp_distance = 0
		var target = noone;
	
		for(var i = 0; i < instance_number(obj_enemy_ship); i+=1;){
			target = instance_find(obj_enemy_ship,i)
			temp_distance = scr_wrap_closest_distance_to_instance(target)
			if temp_distance <= range
				if scr_chance_percent(20+luck){ // base chance of enemies falling in love
					love_effect = instance_create_depth(target.phy_position_x,target.phy_position_y,10,obj_effect_charmed)
					love_effect.target = target
					}
			}
		}


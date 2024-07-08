event_inherited();

object = noone
target = noone

if scr_timer(60){
	var seek_range = 800
	
		
	with(owner){
		var temp_object = scr_wrap_nearest_instance(obj_asteroid)
		if temp_object != noone
			if scr_wrap_closest_distance_to_instance(temp_object) < 200
				other.object = temp_object
	}
		
	if object != noone{
		with(owner){
			var temp_target = scr_wrap_nearest_instance(obj_enemy_ship)
			if temp_target != noone
				if scr_wrap_closest_distance_to_instance(temp_target) < 800
					other.target = temp_target
		}
		if target != noone{
			var target_dir = scr_wrap_direction_to_point(object.phy_position_x,object.phy_position_y,target.phy_position_x,target.phy_position_y)
			var owner_dir = scr_wrap_direction_to_point(object.phy_position_x,object.phy_position_y,owner.phy_position_x,owner.phy_position_y)
			
			if abs(angle_difference(target_dir,owner_dir)) > 60
			{
				var force = 50
				force_x = lengthdir_x(force,target_dir)
				force_y = lengthdir_y(force,target_dir)
			
				if target_dir != -1{ //if it has a valid target direction
					with(object)
						physics_apply_impulse(phy_position_x,phy_position_y,other.force_x*phy_mass,other.force_y*phy_mass)
					audio_play_sound_on(owner.ship_audio_emitter,snd_telekinesis,0,1)
				}
			}
		}
	}
}

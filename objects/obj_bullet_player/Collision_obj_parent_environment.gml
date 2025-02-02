//
hit_enemy = true;
other.obj_health -= damage;

var i = irandom(2)
switch (i){
	case 0: bullet_impact_sound = snd_bullet_vs_environment_1 ; break;
	case 1: bullet_impact_sound = snd_bullet_vs_environment_2 ; break;
	case 2: bullet_impact_sound = snd_bullet_vs_environment_3 ; break;
	}
	
with (other){
	temp_dir = point_direction(other.phy_position_x,other.phy_position_y,phy_position_x,phy_position_y)
	var x_force = lengthdir_x(other.push_force,temp_dir)
	var y_force = lengthdir_y(other.push_force,temp_dir)
	physics_apply_impulse(other.phy_position_x,other.phy_position_y,x_force,y_force)
	}

//audio_play_sound_at(bullet_impact_sound,phy_position_x,phy_position_y,0,100,800,1,0,1)
audio_emitter_falloff(projectile_audio_emitter, 100, 800, 1);
audio_play_sound_on(projectile_audio_emitter,bullet_impact_sound,0,1)


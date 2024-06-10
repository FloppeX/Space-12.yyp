var punch_damage = 15
var punch_force = 100
enemy_ship = noone
with (obj_ship_segment_player){
	var temp_target = instance_place(phy_position_x,phy_position_y,obj_ship_segment_enemy)
	if temp_target != noone
		other.enemy_ship = temp_target
	}
if scr_exists(enemy_ship) and enemy_ship.phy_active == true{
	with(enemy_ship){
		temp_dir = point_direction(other.owner.phy_position_x,other.owner.phy_position_y,phy_position_x,phy_position_y)
		var x_force = lengthdir_x(punch_force,temp_dir)
		var y_force = lengthdir_y(punch_force,temp_dir)
		physics_apply_impulse(other.owner.phy_position_x,other.owner.phy_position_y,x_force,y_force)
	}
	audio_play_sound_on(owner.ship_audio_emitter,snd_punch,0,1)
	enemy_ship.obj_health -= punch_damage
	damage_number = instance_create_depth(enemy_ship.phy_position_x,enemy_ship.phy_position_y,-1,obj_damage_number)
	damage_number.damage = punch_damage;
}
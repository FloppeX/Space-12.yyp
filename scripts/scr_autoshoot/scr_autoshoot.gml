// Applies to a module (gun) and shoots it of there is an enemy in front of it
function scr_autoshoot(argument0,argument1){
var target_arc = 20
var target_object_1 = argument0
var target_object_2 = argument1

if !activation_timer and ready_to_shoot{
	var temp_target = scr_rocket_find_target_in_arc(target_object_1,-phy_rotation,target_arc,bullet_range * 1.1)
	if temp_target == noone 
		temp_target = scr_rocket_find_target_in_arc(target_object_2,-phy_rotation,target_arc,bullet_range * 1.1)
	if temp_target != noone 
		activation_timer = 30
	}	
}
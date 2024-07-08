event_inherited();


if pickup_objects == 0
		sprite_index = spr_asteroid_small_2
if pickup_objects > 0{
	if pickup_object_type == obj_pickup_credit
		sprite_index = spr_asteroid_small_credit
	if pickup_object_type == obj_pickup_health
		sprite_index = spr_asteroid_small_health
	if pickup_object_type == obj_pickup_particles
		sprite_index = spr_asteroid_small_particles
}


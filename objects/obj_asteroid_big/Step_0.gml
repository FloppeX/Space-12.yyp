event_inherited();


if pickup_objects == 0
	sprite_index = spr_asteroid_big

if pickup_objects > 0{
	if pickup_object_type == obj_pickup_credit
		sprite_index = spr_asteroid_big_credit
	if pickup_object_type == obj_pickup_health
		sprite_index = spr_asteroid_big_health
	if pickup_object_type == obj_pickup_particles
		sprite_index = spr_asteroid_big_particles
}

event_inherited();

sprite_index = spr_asteroid_med_particles

pickup_objects = irandom(1)+1

pickup_object_type = obj_pickup_particles;

if random(100) <= global.asteroid_chance_credit * 5 * global.luck
	child_object = obj_asteroid_small_particles
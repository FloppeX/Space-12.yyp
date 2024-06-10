event_inherited()

sprite_index = spr_asteroid_big_credit

pickup_objects = irandom(1)+2

pickup_object_type = obj_pickup_credit;

if random(100) <= global.asteroid_chance_credit * 5 * global.luck
	child_object = obj_asteroid_medium_credit
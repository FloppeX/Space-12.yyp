event_inherited();

obj_health = 24;

//damage = 20
push_force = 30//900

child_object = obj_asteroid_medium;
death_effect_size = 2;

/*
var random_number = random(100)
if random_number <= global.asteroid_chance_credit
	child_object =  obj_asteroid_medium_credit
	else {if random_number <= (global.asteroid_chance_credit + global.asteroid_chance_health)
		child_object =  obj_asteroid_medium_health
		else {if random_number<= (global.asteroid_chance_credit + global.asteroid_chance_health + global.asteroid_chance_particles)
			child_object =  obj_asteroid_medium_particles
			}
		}
	
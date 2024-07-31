function scr_create_random_module(argument0) {
	/*
	input: module array, module type
	output: randomly selected module
	*/
	var array = argument0
	var total_probability = 0;
	var random_number = 0;
	var probability_step = 0;

	for(var i = 0; i < array_height_2d(array); i+=1;)
		total_probability += array[i,3] //Add all rarity to get a "probability sum"
	
	random_number = irandom(total_probability) // Get a random number from the total

	for(var i = 0; i < array_height_2d(array); i+=1;){
		probability_step += array[i,3]
		if random_number <= probability_step{
			var temp_module = instance_create_depth(0,0,-10,array[i,0]);
			if temp_module.fixed_rotation
				temp_module.offset_angle = temp_module.fixed_rotation
			else
				temp_module.offset_angle = irandom(3) * 90;
			temp_module.credit_cost = array[i,2]
			temp_module.credit_cost = round(0.75 * temp_module.credit_cost + random(0.5)*temp_module.credit_cost)
			return temp_module
			}
		} 

	return noone // if the function fails...


}

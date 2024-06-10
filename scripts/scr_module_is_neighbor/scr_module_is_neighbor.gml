//takes two modules, checks if they are neighbors

function scr_module_is_neighbor(argument0, argument1) {
var temp_module_1 = argument0
var temp_module_2 = argument1

if scr_exists(temp_module_1.module_above)
	if temp_module_1.module_above == temp_module_2
		return true;

if scr_exists(temp_module_1.module_right)
	if temp_module_1.module_right == temp_module_2
		return true;
		
if scr_exists(temp_module_1.module_below)
	if temp_module_1.module_below == temp_module_2
		return true;
		
if scr_exists(temp_module_1.module_left)
	if temp_module_1.module_left == temp_module_2
		return true;
		
return false;
}
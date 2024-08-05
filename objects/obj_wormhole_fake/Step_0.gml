timer += 1

if timer < 180
	if wormhole_size < 1
		wormhole_size += 0.02
if timer > 180{
	wormhole_size -= 0.02
	if wormhole_size <= 0
		instance_destroy()
}
phy_rotation += rotation_speed;
	
rotation += rotation_speed


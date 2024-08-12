timer += 1

if timer < 180
	if wormhole_size < 1
		wormhole_size += 0.02
if timer > 440{
	wormhole_size -= 0.02
	if wormhole_size <= 0
		instance_destroy()
}
phy_rotation += rotation_speed;
	
rotation += rotation_speed

audio_emitter_position(audio_emitter,global.camera.phy_position_x,global.camera.phy_position_y,0)
audio_emitter_gain(audio_emitter, wormhole_size);
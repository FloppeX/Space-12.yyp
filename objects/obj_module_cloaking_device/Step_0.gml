event_inherited();

if !scr_exists(owner)
	exit
	
if activated {
	owner.invisible = true
	owner.alpha = 0.2
	}
else {
	owner.invisible = false
	owner.alpha = 1
	}
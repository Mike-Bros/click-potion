extends AnimatedSprite2D


func shake(duration):
	$ShakeTimer.start(duration)

func _process(delta):
	if $ShakeTimer.get_time_left() > 0.0:
		play()
	else:
		stop()


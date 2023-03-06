extends Control

signal left_clicked
signal right_clicked

@export var sprite_frames: SpriteFrames
@export var difficulty: int
@export var count: int
var disabled: bool

func _ready():
	if sprite_frames:
		$Area2D/AnimatedSprite.set_sprite_frames(sprite_frames)
	else:
		$Area2D/AnimatedSprite.set_sprite_frames(load("res://art/pots/shake-pot-master.res"))


func _process(delta):
	$Count.text = str(count)
	$RequiredLevel.text = "Level " + str(difficulty)
	if disabled:
		$RequiredLevel.show()
	else:
		$RequiredLevel.hide()

func shake(duration):
	$Area2D/AnimatedSprite.animation = "default"
	$Area2D/AnimatedSprite.play()
	await(get_tree().create_timer(duration).timeout)
	$Area2D/AnimatedSprite.stop()
#	var animation_names = $Area2D/AnimatedSprite.sprite_frames.get_animation_names()
#	print(animation_names)
	

func _on_mouse_entered():
	shake(.5)


func _on_input_event(viewport, event, shape_idx):
	if event.get_class() == "InputEventMouseButton":
		if event.button_index == 1 and !event.pressed:
			emit_signal("left_clicked")
		if event.button_index == 2 and !event.pressed:
			emit_signal("right_clicked")


func _on_left_clicked():
	print("left clicked")
	shake(.5)


func disable():
	disabled = true
	$Area2D/AnimatedSprite.set_sprite_frames(load("res://art/pots/shake-pot-master.res"))
	
func enable():
	disabled = false
	$Area2D/AnimatedSprite.set_sprite_frames(sprite_frames)

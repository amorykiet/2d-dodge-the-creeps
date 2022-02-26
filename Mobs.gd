extends RigidBody2D

var speed_max = 250
var speed_min = 100

func _ready():
	randomize()
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % 3]
	$AnimatedSprite.playing = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

extends Area2D

export var speed = 400
var screen = OS.window_size
signal hit

func _ready():
	hide()

func _process(delta):
	# move around
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	if direction.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_h = direction.x < 0
		$AnimatedSprite.flip_v =false
	if direction.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v =direction.y > 0

	if direction.length() > 0:
		direction.normalized()
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += direction * speed * delta
	position.x = clamp(position.x, 0, screen.x)
	position.y = clamp(position.y, 0, screen.y)

func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_Player_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	emit_signal("hit")

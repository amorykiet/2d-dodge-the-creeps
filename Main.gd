extends Node

export var mob_scene: PackedScene
var score
onready var high_score = 0

#gameplay
func new_game():
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$HUD.update_score(score)
	$Music.play()
	$HUD.show_message("Ready...")
	yield($StartTimer, "timeout")
	$Player.start($StartPosition2D.position)
	$SpawnTimer.start()
	$ScoreTimer.start()

#spawn mobs
func _on_SpawnTimer_timeout():
	#instance mob
	var mob = mob_scene.instance()
	add_child(mob)
	
	#location of mob
	var mob_location = $MobPath2D/MobPathLocation
	$MobPath2D/MobPathLocation.unit_offset = randf()
	mob.position = mob_location.position
	
	#direction of mob
	var direction = mob_location.rotation + PI/2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation += direction
	
	#velocity of mob
	var velocity  = Vector2(rand_range(mob.speed_min, mob.speed_max), 0)
	velocity.rotated(mob.rotation)
	mob.linear_velocity = velocity.rotated(mob.rotation)

#Score time
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	if high_score <= score:
		high_score = score
		$HUD.update_high_score(high_score)

func _on_Player_hit():
	$HUD.game_over()
	$SpawnTimer.stop()
	$ScoreTimer.stop()
	$Music.stop()
	$DeadSound.play()

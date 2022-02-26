extends CanvasLayer

signal start_game

func update_score(new_score):
	$ScoreLabel.text = str(new_score)
	
func update_high_score(new_score):
	$HighScoreNumber.text = str(new_score)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func game_over():
	show_message("Game over")
	yield($MessageTimer, "timeout")
	$MessageLabel.text = "Dodge the creeps"
	$MessageLabel.show()
	yield(get_tree().create_timer(0,1), "timeout")
	$Button.show()

func _on_Button_pressed():
	$Button.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
		$MessageLabel.hide()

extends CanvasLayer
signal start_game

func _ready() -> void:
	set_visibility(false)

func show_message(text: String) -> void:
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over() -> void:
	show_message("Game Over!")
	await $MessageTimer.timeout
	
	$Message.text = "Dodge The Creeps!"
	$Message.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score: int) -> void:
	$ScoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()

func set_visibility(see: bool) -> void:
	if see:
		$ScoreLabel.show()
		$VirtualJoystick.show()
	elif !see:
		$ScoreLabel.hide()
		$VirtualJoystick.hide()
	else:
		print(see)

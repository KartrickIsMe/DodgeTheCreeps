extends Node

@export var mob_scene: PackedScene
var score: int

func game_over() -> void:
	$Music.stop()
	$DeathSound.play()
	$HUD.set_visibility(false)
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

	$HUD.show_message("Score : " + str(score))

func new_game() -> void:
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$Music.play()
	$HUD.show_message("Get Ready!")
	$HUD.set_visibility(true)
	get_tree().call_group("mobs", "queue_free")


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$ScoreTimer.start()
	$MobTimer.start()

func _on_mob_timer_timeout() -> void:
	
	var mob: Node2D = mob_scene.instantiate()
	
	var mob_spawn_location: Node2D = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction: float = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity: Vector2 = Vector2(randf_range(150.0, 250.0), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

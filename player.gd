extends Area2D
signal hit

@export var speed: int = 400
var screen_size: Vector2
@onready var animator: Node2D = $AnimatedSprite2D
@onready var collider: Node2D = $CollisionShape2D

func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity: Vector2 = Vector2.ZERO;
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		animator.play()
	else:
		animator.stop()
	
	if velocity.x != 0:
		animator.animation = "walk"
		animator.flip_h = false
		animator.flip_h = velocity.x < 0

	elif velocity.y != 0:
		animator.animation = "up"
		animator.flip_v = velocity.y > 0
	
	if velocity.y > 0:
		$AnimatedSprite2D.flip_v = true
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
		


func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false

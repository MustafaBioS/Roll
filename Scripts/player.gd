extends CharacterBody2D
@onready var camera = $Camera2D

const SPEED = 250.0
const JUMP_VELOCITY = -300.0

func player():
	pass

func _physics_process(delta: float) -> void:
	print(global_position)
	
	var direction := Input.get_axis("a", "d")

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	rotation += velocity.x * delta / 20.0
	
	move_and_slide()

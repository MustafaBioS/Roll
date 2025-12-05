extends CharacterBody2D
@onready var camera = $Sprite2D/Camera2D

const SPEED = 250.0
const JUMP_VELOCITY = -300.0

var motion = Vector2()

var hook_pos = null
var hooked = false
var rope_length = 300
var current_rope_length
@onready var raycasts = $Raycasts

func _ready() -> void:
	current_rope_length = rope_length
	for raycast in raycasts.get_children():
		raycast.enabled = true

func player():
	pass

func _physics_process(delta: float) -> void:
	
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
	
	hook()
	
	if hooked:
		velocity += get_gravity() * delta
		swing(delta)
		motion *= 0.975
		velocity = motion
	
	move_and_slide()

func _draw():
	var pos = global_position
	
	if hooked and hook_pos != null:
		var local_hook = hook_pos - global_position
		draw_line(Vector2.ZERO, local_hook, Color(1, 1, 1), 2.0, true)
	else:
		for ray in raycasts.get_children():
			if ray.is_colliding():
				var collide_point = ray.get_collision_point()
				if pos.distance_to(collide_point) < rope_length:
					draw_line(Vector2.ZERO, to_local(collide_point), Color(1,1,1), 0.5, true)
				break

func hook():
	raycasts.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("lmb"):
		hook_pos = get_hook_pos()
		if hook_pos != null:
			hooked = true
			current_rope_length = global_position.distance_to(hook_pos)
			motion = velocity
	if Input.is_action_just_released("lmb") and hooked:
		hooked = false
			
func get_hook_pos():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			var p = raycast.get_collision_point()
			if typeof(p) == TYPE_VECTOR2:
				return p
	return null
			
func swing(delta):
	var radius = global_position - hook_pos

	if motion.length() < 0.01 or radius.length() < 10:
		return
		
	if radius.length() == 0 or motion.length() == 0:
		return

	var dot_val = clamp(radius.dot(motion) / (radius.length() * motion.length()), -1, 1)
	var angle = acos(dot_val)

	var rad_vel = cos(angle) * motion.length()
	motion += radius.normalized() * -rad_vel

	if global_position.distance_to(hook_pos) > current_rope_length:
		global_position = hook_pos + radius.normalized() * current_rope_length

	motion += (hook_pos - global_position).normalized() * 15000 * delta

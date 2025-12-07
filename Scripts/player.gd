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
@onready var rope = $Line2D

func _ready() -> void:
	current_rope_length = rope_length
	for raycast in raycasts.get_children():
		raycast.enabled = true

func player():
	pass

func _process(delta: float) -> void:
	if State.paused == false:
		if Input.is_action_just_pressed("pause"):
			print("click false")
			State.paused = true

	elif State.paused == true:
		if Input.is_action_just_pressed("pause"):
			print("click true")
			State.paused = false

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("a", "d")

	if direction != 0 and State.paused == false:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if not is_on_floor() and State.paused == false:
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("space") and is_on_floor() and State.paused == false:
		velocity.y = JUMP_VELOCITY

	rotation += velocity.x * delta / 20.0
	
	hook()
	
	if hooked:
		velocity += get_gravity() * delta
		swing(delta)
		motion *= 0.975
		velocity = motion
		
	_draw()
	
	if State.paused == false:
		move_and_slide()
	
func _draw():
	rope.clear_points()
	if not hooked or hook_pos == null:
		return
	rope.add_point(to_local(global_position))
	rope.add_point(to_local(hook_pos))

func get_hook_collider():
	for ray in raycasts.get_children():
		if ray.is_colliding():
			var c = ray.get_collider()
			if c == self or c.name == "Barriers":
				continue
			return c
	return null

func hook():
	for ray in raycasts.get_children():
		if ray.has_method("look_at"):
			ray.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("lmb") and State.paused == false:
		hook_pos = get_hook_pos()
		if hook_pos != null:
			var collider = get_hook_collider()
			hooked = true
			current_rope_length = global_position.distance_to(hook_pos)
			motion = velocity
			print("Hooked onto: ", collider, " (name: ", collider.name, ")")
	if Input.is_action_just_released("lmb") and hooked:
		hooked = false
			
func get_hook_pos():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider == self or collider.name == "Barriers":
				continue
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

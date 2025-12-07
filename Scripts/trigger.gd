extends Area2D
@onready var lmb = $"../LMB"
@onready var trust = $"../Trust"
@onready var good = $"../Good"
@onready var more = $"../More"
@onready var oh = $"../Oh"
@onready var enter = $"../Enter"

var x = false

func _ready() -> void:
	lmb.visible = false
	trust.visible = false
	good.visible = false
	more.visible = false
	oh.visible = false
	enter.visible = false

func _process(delta: float) -> void:
	if x == true:
		if Input.is_action_just_pressed("interact"):
			State.lvl2 = true
			get_tree().change_scene_to_file("res://Scenes/lvl2.tscn")

func _on_body_entered(body: Node2D) -> void:
	lmb.visible = true

func _on_body_exited(body: Node2D) -> void:
	lmb.visible = false

func _on_trigger_2_body_entered(body: Node2D) -> void:
	trust.visible = true

func _on_trigger_2_body_exited(body: Node2D) -> void:
	trust.visible = false

func _on_trigger_3_body_entered(body: Node2D) -> void:
	good.visible = true

func _on_trigger_3_body_exited(body: Node2D) -> void:
	good.visible = false 

func _on_trigger_4_body_entered(body: Node2D) -> void:
	more.visible = true

func _on_trigger_4_body_exited(body: Node2D) -> void:
	more.visible = false

func _on_trigger_5_body_entered(body: Node2D) -> void:
	oh.visible = true
	
func _on_trigger_5_body_exited(body: Node2D) -> void:
	oh.visible = false

func _on_trigger_6_body_entered(body: Node2D) -> void:
	enter.visible = true
	x = true
	
func _on_trigger_6_body_exited(body: Node2D) -> void:
	enter.visible = false
	x = false

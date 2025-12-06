extends Area2D
@onready var lmb = $"../LMB"
@onready var trust = $"../Trust"
@onready var good = $"../Good"
@onready var more = $"../More"


func _ready() -> void:
	lmb.visible = false
	trust.visible = false
	good.visible = false
	more.visible = false

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

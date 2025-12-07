extends Area2D
@onready var escaped = $"../Escaped"

func _ready() -> void:
	escaped.visible = false

func _on_body_entered(body: Node2D) -> void:
	escaped.visible = true
	await  get_tree().create_timer(3.0).timeout
	State.win = true
	
func _on_body_exited(body: Node2D) -> void:
	escaped.visible = false

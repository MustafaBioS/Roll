extends Area2D
@onready var escaped = $"../Escaped"

func _ready() -> void:
	escaped.visible = false

func _on_body_entered(body: Node2D) -> void:
	escaped.visible = true
	
func _on_body_exited(body: Node2D) -> void:
	escaped.visible = false

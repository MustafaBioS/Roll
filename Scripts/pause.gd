extends CanvasLayer
@onready var resume = $Buttons/Resume
@onready var options = $Buttons/Options
@onready var menu = $Buttons/Menu
@onready var exit = $Buttons/Exit
@onready var pause = $"."

func _process(delta: float) -> void:
	if State.paused == true:
		pause.visible = true
	if State.paused == false:
		pause.visible = false

func _on_resume_pressed() -> void:
	State.paused = false

func _on_options_pressed() -> void:
	pass # Replace with function body.

func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

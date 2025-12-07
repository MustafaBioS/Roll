extends CanvasLayer
@onready var resume = $Buttons/Resume
@onready var menu = $Buttons/Menu
@onready var exit = $Buttons/Exit
@onready var pause = $"."
@onready var options = $Options

func _ready() -> void:
	options.visible = false

func _process(delta: float) -> void:
	if State.paused == true:
		pause.visible = true
	if State.paused == false:
		pause.visible = false

func _on_resume_pressed() -> void:
	State.paused = false

func _on_options_pressed() -> void:
	options.visible = true
	
func _on_back_pressed() -> void:
	options.visible = false
	
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

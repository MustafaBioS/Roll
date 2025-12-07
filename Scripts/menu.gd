extends Control
@onready var options = $Options
@onready var play = $Buttons/Play

func _ready() -> void:
	options.visible = false

func _process(delta: float) -> void:
	if State.win == true:
		play.text = "Play Again"

func _on_play_pressed() -> void:
	State.win = false
	if State.lvl2 == true:
		get_tree().change_scene_to_file("res://Scenes/lvl2.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/lvl1.tscn")

func _on_options_pressed() -> void:
	options.visible = true

func _on_back_pressed() -> void:
	options.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()

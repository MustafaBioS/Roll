extends Control


func _on_play_pressed() -> void:
	if State.lvl2 == true:
		get_tree().change_scene_to_file("res://Scenes/lvl2.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/lvl1.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()

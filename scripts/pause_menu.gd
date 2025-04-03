extends Control

@onready var main = $"../../../"


func _on_resume_pressed() -> void:
	main.pauseMenu()




func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	Engine.time_scale = 1


func _on_quit_pressed() -> void:
	get_tree().quit()

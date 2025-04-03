extends Area2D

@onready var timer: Timer = $Timer

signal hurt

func _on_body_entered(body: Node2D) -> void:
	hurt.emit(50)


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

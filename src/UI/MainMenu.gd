extends Control

func _ready() -> void:
	pass # Replace with function body.


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://GameScene.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()

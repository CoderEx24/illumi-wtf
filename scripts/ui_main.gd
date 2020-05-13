extends Control


func _ready():
	pass


func _on_Start_pressed():
	get_tree().change_scene("res://2d/tutorial.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Tutorial_pressed():
	Game.level = 0
	get_tree().change_scene("res://2d/tutorial.tscn")

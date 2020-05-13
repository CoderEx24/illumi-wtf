extends Area2D


func _ready():
	pass


func _on_Niwtfit_body_entered(body):
	if body.name != 'Boy':
		return
	
	Game.niwtfit += 1
	queue_free()

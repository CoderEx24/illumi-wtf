extends Area2D

func _ready():
	pass


func _on_Key_body_entered(body):
	if body.name != 'Boy':
		return
	
	Game.has_key = true
	queue_free()

extends Area2D


func _ready():
	pass


func _on_Portal_body_entered(body):
	if body.name != 'Boy' or not Game.has_key:
		return
		
	Game.level += 1
	queue_free()

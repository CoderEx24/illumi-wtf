extends Area2D

var entered_before = false

func _ready():
	entered_before = false

func _on_Spike_body_entered(body):
	if body.name == 'Boy' and not entered_before:
		Game.health = 0
		entered_before = true

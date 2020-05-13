extends Control

var health_delta = 0
var bullet_delta = 0
var prev_scale = 1
onready var health_bar = $'Health Bar'
onready var bullet_bar = $'bullet Bar'

func _ready():
	Game.connect('health_changed', self, '_on_health_changed')

func _process(delta):
	if Input.is_action_just_pressed('shoot'):
		Game.health -= 10
	
	print('current_scale = %s\nprev_scale = %s\nhealth_delta = %f' % [health_bar.rect_scale, prev_scale, health_delta])
	health_bar.rect_scale.x = lerp(prev_scale, prev_scale - health_delta, 0.1)

func _on_health_changed(old, new):
	health_delta = (old - new) * 0.01
	prev_scale = health_bar.rect_scale.x
	
